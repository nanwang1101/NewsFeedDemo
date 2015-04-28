//
//  NWDownloadManager.h
//  YahooNews
//
//  Created by Nan Wang on 6/13/14.
//
//

#import <Foundation/Foundation.h>

typedef void (^DownloadBlock)(NSDictionary *dict, NSError *error);

@interface NWDownloadManager : NSObject

-(void)getAllNewsDataWithCompletionBlock:(DownloadBlock)block;
-(void)getArticlesWithIDs:(NSArray*)idArray WithCompletionBlock:(DownloadBlock)block;

+(instancetype)sharedInstance;

@end
