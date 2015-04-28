//
//  NWArticle.m
//  YahooNews
//
//  Created by Nan Wang on 6/13/14.
//
//

#import "NWArticle.h"

@implementation NWArticle

-(instancetype)initWithDictionary:(NSDictionary *)dict{
    self = [self init];
    if (self) {
        [self loadValueWithDict:dict];
    }
    return self;

}

-(void)loadValueWithDict:(NSDictionary*)dict{
    
    if ([dict objectForKey:@"title"]) {
        _title = [dict objectForKey:@"title"];
    }
    
    if ([dict objectForKey:@"uuid"]) {
        _uuid = [dict objectForKey:@"uuid"];
    }
    
    if ([dict objectForKey:@"content"]) {
        _content = [dict objectForKey:@"content"];
    }
    
    if ([dict objectForKey:@"publisher"]) {
        _publisher = [dict objectForKey:@"publisher"];
    }
    
    if ([dict objectForKey:@"images"]) {
        _images = [dict objectForKey:@"images"];
    }
    
    if ([dict objectForKey:@"summary"]) {
        _summary = [dict objectForKey:@"summary"];
    }
    
    if ([dict objectForKey:@"category"]) {
        _category = [dict objectForKey:@"category"];
    }
}


@end
