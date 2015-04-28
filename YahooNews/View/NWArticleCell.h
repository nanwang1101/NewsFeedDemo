//
//  NWArticleCell.h
//  YahooNews
//
//  Created by Nan Wang on 6/13/14.
//
//

#import <UIKit/UIKit.h>
#import "NWArticle.h"

@interface NWArticleCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *publisherLabel;
@property (weak, nonatomic) IBOutlet UIImageView *thumbView;


-(void)setupViewWithArticle:(NWArticle*)article;
+ (NSString *)reuseIdentifier;

@end
