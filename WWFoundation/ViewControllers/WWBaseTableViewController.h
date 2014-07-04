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
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSNumber *pageNum;
@property (nonatomic, weak) UITableView *currentTableView;

- (void)reloadView;
- (void)reloadView:(BOOL)cleanUp;
- (void)refreshView;
- (void)loadMoreView;

@end
