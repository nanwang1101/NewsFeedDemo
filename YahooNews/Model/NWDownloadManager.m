//
//  NWDownloadManager.m
//  YahooNews
//
//  Created by Nan Wang on 6/13/14.
//
//

#import "NWDownloadManager.h"
#import "NWCommon.h"



@implementation NWDownloadManager

+(instancetype)sharedInstance
{
    static NWDownloadManager *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[NWDownloadManager alloc] init];
    });
    return sharedInstance;
}

-(void)getAllNewsDataWithCompletionBlock:(DownloadBlock)block{
    
    NSLog(@"Download All Data");
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       
        NSURL *url = [NSURL URLWithString:[GetAllArticlesURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSLog(@"Refresh: %@", url.absoluteString);
        
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        NSError *error = nil;
        NSDictionary *results = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        
        dispatch_async(dispatch_get_main_queue(),^{
            if (error || data == nil) {
                block(nil, error);
            }else{
                block(results, nil);
            }
        });
        
    });
}

-(void)getArticlesWithIDs:(NSArray *)idArray WithCompletionBlock:(DownloadBlock)block{
    
    NSString *base = [NSString stringWithFormat:@"%@", GetArticlesWithIDs];
    
    for (int i= 0; i < idArray.count; i++) {
        NSString *uuid = [[idArray objectAtIndex:i] objectForKey:@"id"];
        if (i == idArray.count-1) {
            base = [base stringByAppendingString:uuid];
        }else{
            base = [base stringByAppendingString:uuid];
            base = [base stringByAppendingString:@","];
        }
    }
    
    NSURL *url = [NSURL URLWithString:[base stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSLog(@"Load More: %@", url.absoluteString);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        NSError *error = nil;
        NSDictionary *results = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        
        dispatch_async(dispatch_get_main_queue(),^{
            if (error || data == nil) {
                block(nil, error);
            }else{
                block(results, nil);
            }
        });

    });
}

@end
