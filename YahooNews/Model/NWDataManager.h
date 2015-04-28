//
//  NWDataManager.h
//  YahooNews
//
//  Created by Nan Wang on 6/13/14.
//
//

#import <Foundation/Foundation.h>

typedef void (^DataBlock)(BOOL success);

@interface NWDataManager : NSObject

@property (nonatomic, strong) NSMutableArray *articleArray;

+(instancetype)sharedInstance;
-(void)refreshDataWithCompletionBlock:(DataBlock)block;
-(void)loadMoreItemsWithNumber:(int)count WithCompletionBlock:(DataBlock)block;

@end
