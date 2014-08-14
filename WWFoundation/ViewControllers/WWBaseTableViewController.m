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

- (NSMutableArray *)sectionArray
{
    if (!_sectionArray)
    {
        _sectionArray = [@[] mutableCopy];
    }
    
    return _sectionArray;
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray)
    {
        _dataArray = [@[] mutableCopy];
    }
    
    return _dataArray;
}

- (NSMutableArray *)indexTitleArray
{
    if (!_indexTitleArray)
    {
        _indexTitleArray = [@[] mutableCopy];
    }
    
    return _indexTitleArray;
}

- (NSMutableArray *)filteredDataArray
{
    if (!_filteredDataArray)
    {
        _filteredDataArray = [@[] mutableCopy];
    }
    
    return _filteredDataArray;
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)applyStyle
{
    [super applyStyle];
    
    self.activeScrollView = self.tableView;
    self.currentTableView = self.tableView;
    
    // There is different bg color in Bounce area when search bar inside tableview
    if (self.searchDisplayController.searchBar)
    {
        UIView *backgroundView = [[UIView alloc] initWithFrame:self.currentTableView.bounds];
        backgroundView.backgroundColor = [UIColor clearColor];
        self.currentTableView.backgroundView = backgroundView;
    }
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.sectionArray.count > 1)
    {
        return self.sectionArray.count;
    }
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.sectionArray.count > 1)
    {
        NSArray *dataArray = self.dataArray[section];
        
        return dataArray.count;
    }
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark - UITableViewDelegate
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.indexTitleArray;
}

@end
