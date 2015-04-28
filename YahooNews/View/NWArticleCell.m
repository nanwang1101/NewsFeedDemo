//
//  NWArticleCell.m
//  YahooNews
//
//  Created by Nan Wang on 6/13/14.
//
//

#import "NWArticleCell.h"
#import "UIImageView+WebCache.h"

@implementation NWArticleCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(NSString *)reuseIdentifier{
    return @"ArticleCell";
}

-(void)setupViewWithArticle:(NWArticle *)article{
    
    _titleLabel.text = article.title;
    _categoryLabel.text = article.category;
    _publisherLabel.text = article.publisher;
    
    _thumbView.image = [UIImage imageNamed:@"placeholder_loading"];
    if (article.images.count > 0) {
        NSDictionary *dict = [article.images objectAtIndex:0];
        NSString *urlstr = [dict objectForKey:@"url"];
        NSURL *url = [NSURL URLWithString:[urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        [_thumbView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeholder_loading"]];
    }
}

@end
