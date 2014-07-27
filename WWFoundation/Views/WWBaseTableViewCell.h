//
//  WWBaseTableViewCell.h
//  RipplingApp
//
//  Created by William Wu on 7/18/14.
//  Copyright (c) 2014 WW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+WWFoundation.h"
#import "WWBaseInfo.h"

@interface WWBaseTableViewCell : UITableViewCell <WWBaseViewDelegate>

@property (nonatomic, readonly) id<RIItemData> itemData;

- (void)bindData:(id<RIItemData>)itemData;

@end
