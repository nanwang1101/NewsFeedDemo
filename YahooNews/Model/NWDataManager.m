//
//  NWDataManager.m
//  YahooNews
//
//  Created by Nan Wang on 6/13/14.
//
//

#import "NWDataManager.h"
#import "NWDownloadManager.h"
#import "NWArticle.h"

@interface NWDataManager ()

@property (nonatomic, strong) NSArray *moreItems;
@property (atomic) int currentIndex;

@end

@implementation NWDataManager

+(instancetype)sharedInstance
{
    static NWDataManager *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[NWDataManager alloc] init];
    });
    return sharedInstance;
}

-(id)init{
    self = [super init];
    if (self) {
        _articleArray = [NSMutableArray array];
        [self resetAllData];
    }
    return  self;
}

#pragma mark - custom functions
-(void)resetAllData{
    _currentIndex = 0;
    
    if (_articleArray.count) {
        [_articleArray removeAllObjects];
    }
}

-(void)refreshDataWithCompletionBlock:(DataBlock)block{
    
    NWDownloadManager *downloadManager = [NWDownloadManager sharedInstance];
    [downloadManager getAllNewsDataWithCompletionBlock:^(NSDictionary *dict, NSError *error) {
        BOOL success = YES;
        if (!error) {
            NSArray *articleArray = [[dict objectForKey:@"result"] objectForKey:@"items"];
            if (articleArray) {
                [self resetAllData];
                for (NSDictionary *detail in articleArray) {
                    
                    NWArticle *article = [[NWArticle alloc] initWithDictionary:detail];
                    [_articleArray addObject:article];
                }
            }else{
                success = NO;
            }
            
            _moreItems = [[dict objectForKey:@"result"] objectForKey:@"more_items"];
        }else{
            success = NO;
        }
        
        block(success);
    }];
    
}

-(void)loadMoreItemsWithNumber:(int)count WithCompletionBlock:(DataBlock)block{
    
    NWDownloadManager *downloadManager = [NWDownloadManager sharedInstance];
    NSInteger total = _moreItems.count;
    NSArray *array;
    if (_currentIndex > total) {
        return;
    }
    if (total-_currentIndex >= count) {
        array = [_moreItems subarrayWithRange:NSMakeRange(_currentIndex, count)];
    }else{
        array = [_moreItems subarrayWithRange:NSMakeRange(_currentIndex, total-_currentIndex-1
                                                          )];
    }
    [downloadManager getArticlesWithIDs:array WithCompletionBlock:^(NSDictionary *dict, NSError *error) {
        BOOL success = YES;
        if (!error) {
            NSArray *articleArray = [[dict objectForKey:@"result"] objectForKey:@"items"];
            if (articleArray) {
                for (NSDictionary *detail in articleArray) {
                    
                    NWArticle *article = [[NWArticle alloc] initWithDictionary:detail];
                    [_articleArray addObject:article];
                }
            }else{
                success = NO;
            }
        }else{
            success = NO;
        }
        
        if (success) {
            _currentIndex = _currentIndex + count + 1;
        }

        block(success);
    }];
    
}


@end
