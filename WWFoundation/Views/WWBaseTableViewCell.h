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
#import "WWBaseView.h"

@interface WWBaseTableViewCell : UITableViewCell <WWBaseViewDelegate>

@property (nonatomic, readonly) id<WWItemDataDelegate> itemData;
@property (nonatomic, readonly) NSUInteger index;

- (void)bindData:(id<WWItemDataDelegate>)itemData;

- (void)bindData:(id<WWItemDataDelegate>)itemData atIndex:(NSUInteger)index;

@end
