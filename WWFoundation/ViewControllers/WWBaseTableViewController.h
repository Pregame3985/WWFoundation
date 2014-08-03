//
//  WWBaseTableViewController.h
//  WWFoundation
//
//  Created by William Wu on 4/4/14.
//  Copyright (c) 2014 WW. All rights reserved.
//

#import "WWBaseViewController.h"

typedef NS_ENUM(NSInteger, TableViewScrollingDirection)
{
    TableViewScrollingDirectionNone = 0,
    TableViewScrollingDirectionUp,
    TableViewScrollingDirectionDown,
};

@interface WWBaseTableViewController : WWBaseViewController

@property (nonatomic, unsafe_unretained) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *sectionArray;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *filteredDataArray;    // When search bar inside 
@property (nonatomic, strong) NSNumber *pageNum;
@property (nonatomic, weak) UITableView *currentTableView;
@property (nonatomic, strong) NSDate *lastLoadMoreTime;

- (void)loadMoreView;

- (void)setAllowingTransparentFootView:(BOOL)allowingTransparentFootView;
- (void)setAllowingPullRefreshing:(BOOL)allowingPullRefreshing;

@end
