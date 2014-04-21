//
//  WWBaseTableViewController.m
//  WWFoundation
//
//  Created by William Wu on 4/4/14.
//  Copyright (c) 2014 WW. All rights reserved.
//

#import "WWBaseTableViewController.h"

@interface WWBaseTableViewController () <UITableViewDataSource, UITableViewDelegate>

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
