//
//  NWArticle.h
//  YahooNews
//
//  Created by Nan Wang on 6/13/14.
//
//

#import <Foundation/Foundation.h>

@interface NWArticle : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *uuid;
@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *publisher;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSString *summary;

-(instancetype)initWithDictionary:(NSDictionary*)dict;

@end
