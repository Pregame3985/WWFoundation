//
//  WWBaseTableViewController.h
//  WWFoundation
//
//  Created by William Wu on 4/4/14.
//  Copyright (c) 2014 WW. All rights reserved.
//

#import "WWBaseViewController.h"

@interface WWBaseTableViewController : WWBaseViewController

@property (nonatomic, unsafe_unretained) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end
