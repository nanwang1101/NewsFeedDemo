//
//  NWDetailViewController.h
//  YahooNews
//
//  Created by Nan Wang on 6/13/14.
//
//

#import <UIKit/UIKit.h>
#import "NWArticle.h"

@interface NWDetailViewController : UIViewController

@property (nonatomic, strong) NWArticle *currArticle;

-(void)setupViewWithArticle:(NWArticle*)article;

@end
