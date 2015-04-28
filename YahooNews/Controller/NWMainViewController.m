//
//  NWMainViewController.m
//  YahooNews
//
//  Created by Nan Wang on 6/13/14.
//
//

#import "NWMainViewController.h"
#import "NWDownloadManager.h"
#import "NWDataManager.h"
#import "SVPullToRefresh.h"
#import "NWArticleCell.h"
#import "NWDetailViewController.h"

@interface NWMainViewController ()<UITableViewDataSource, UITableViewDelegate>{
}

@property (weak, nonatomic) IBOutlet UITableView *articleTable;
@property  (atomic) BOOL isLoadingMore;
@end

@implementation NWMainViewController

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
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.title = @"Yahoo!";
    self.isLoadingMore = NO;
    
    [[NWDataManager sharedInstance] refreshDataWithCompletionBlock:^(BOOL success) {
        [_articleTable reloadData];
    }];
    
    [_articleTable addPullToRefreshWithActionHandler:^{
        [[NWDataManager sharedInstance] refreshDataWithCompletionBlock:^(BOOL success) {
            if (success) {
                [_articleTable reloadData];
            }
            [_articleTable.pullToRefreshView stopAnimating];
        }];
    } position:SVPullToRefreshPositionTop];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - uitableview delegate/datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [NWDataManager sharedInstance].articleArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 226;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NWArticleCell *cell = (NWArticleCell *)[tableView dequeueReusableCellWithIdentifier:[NWArticleCell reuseIdentifier]];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NWCell" owner:self options:nil] objectAtIndex:0];
    }
    
    [cell setupViewWithArticle:[[NWDataManager sharedInstance].articleArray objectAtIndex:indexPath.row]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NWDetailViewController *detailView = [[NWDetailViewController alloc] initWithNibName:@"NWDetailViewController" bundle:nil];
    
    detailView.currArticle = [[NWDataManager sharedInstance].articleArray objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:detailView animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView_
{
    if (self.isLoadingMore) {
        return;
    }
    CGFloat actualPosition = scrollView_.contentOffset.y;
    CGFloat contentHeight = scrollView_.contentSize.height - CGRectGetHeight(self.view.frame);
    if (actualPosition >= contentHeight) {
        if ([NWDataManager sharedInstance].articleArray.count == 0) {
            return;
        }
        self.isLoadingMore = YES;
        [[NWDataManager sharedInstance] loadMoreItemsWithNumber:5 WithCompletionBlock:^(BOOL success) {
            if (success) {
                [_articleTable reloadData];
                self.isLoadingMore = NO;
            }
        }];
    }
}


@end
