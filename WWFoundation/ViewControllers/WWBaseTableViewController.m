//
//  WWBaseTableViewController.m
//  WWFoundation
//
//  Created by William Wu on 4/4/14.
//  Copyright (c) 2014 WW. All rights reserved.
//

#import "WWBaseTableViewController.h"
#import "ODRefreshControl.h"

@interface WWBaseTableViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) ODRefreshControl *refreshControl;

@end

@implementation WWBaseTableViewController

- (NSMutableArray *)dataArray
{
    if (!_dataArray)
    {
        _dataArray = [@[] mutableCopy];
    }
    
    return _dataArray;
}

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
    // Do any additional setup after loading the view.
    
    self.activeScrollView = self.tableView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareData
{
    [self refreshView];
}

- (void)reloadView
{
    [self reloadView:NO];
}

- (void)reloadView:(BOOL)cleanUp
{
    if (cleanUp)
    {
        [self.dataArray removeAllObjects];
    }
    
    [self.tableView reloadData];
}

- (void)refreshView
{
    self.pageNum = @1;
    self.lastLoadMoreTime = [NSDate date];
}

- (void)loadMoreView
{
    self.pageNum = @(self.pageNum.integerValue + 1);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)setAllowingTransparentFootView:(BOOL)allowingTransparentFootView
{
    UIView *footView = [[UIView alloc] init];
    footView.backgroundColor = [UIColor clearColor];
    [self.currentTableView setTableFooterView:footView];
}

- (void)setAllowingPullRefreshing:(BOOL)allowingPullRefreshing
{
    [self addPullRefreshScrolling];
}

- (void)addPullRefreshScrolling
{
    self.refreshControl = [[ODRefreshControl alloc] initInScrollView:self.tableView];
    [self.refreshControl addTarget:self action:@selector(dropViewDidBeginRefreshing:) forControlEvents:UIControlEventValueChanged];
}

- (void)dropViewDidBeginRefreshing:(id)sender
{
    [self refreshView];
    
    __weak WWBaseTableViewController *weakSelf = self;
    double delayInSeconds = 3.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [weakSelf.refreshControl endRefreshing];
    });
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

@end
