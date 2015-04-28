//
//  NWDetailViewController.m
//  YahooNews
//
//  Created by Nan Wang on 6/13/14.
//
//

#import "NWDetailViewController.h"
#import "UIImageView+WebCache.h"

@interface NWDetailViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *thumbView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *publisherLabel;

@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;
@property (weak, nonatomic) IBOutlet UIWebView *contentWebview;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;


@end

@implementation NWDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _contentWebview.scrollView.scrollEnabled = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [self setupViewWithArticle:_currArticle];
}

-(void)setupViewWithArticle:(NWArticle *)article{
    
    _thumbView.image = [UIImage imageNamed:@"placeholder_loading"];
    if (article.images.count > 0) {
        NSDictionary *dict = [article.images objectAtIndex:0];
        NSString *urlstr = [dict objectForKey:@"url"];
        NSURL *url = [NSURL URLWithString:[urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        [_thumbView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeholder_loading"]];
    }
    
    _titleLabel.text = article.title;
    _categoryLabel.text = article.category;
    _publisherLabel.text = article.publisher;
    _summaryLabel.text = article.summary;
    
    [_summaryLabel sizeToFit];
    
    CGRect frame = _summaryLabel.frame;
    if (frame.origin.y + frame.size.height > self.view.frame.size.height - 64) {
        frame.size.height = self.view.frame.size.height - frame.origin.y - 100;
        _summaryLabel.frame = frame;
    }
    
    frame.origin.y = self.view.frame.size.height + 10;
    _contentWebview.frame = frame;
    
    [_contentWebview loadHTMLString:article.content baseURL:[NSURL URLWithString:@"http://"]];
}

-(void)webViewDidFinishLoad:(UIWebView *)aWebView{
    if (aWebView == _contentWebview) {
        CGRect frame = aWebView.frame;
        frame.size.height = 1;        // Set the height to a small one.
        aWebView.frame = frame;       // Set webView's Frame, forcing the Layout of its embedded scrollView with current Frame's constraints (Width set above).
        frame.size.height = aWebView.scrollView.contentSize.height;  // Get the corresponding height from the webView's embedded scrollView.
        aWebView.frame = frame;
        
        int contentHeight =  frame.origin.y + frame.size.height;
        [_contentScrollView setContentSize:CGSizeMake(self.view.frame.size.width, contentHeight)];

    }
}

@end
