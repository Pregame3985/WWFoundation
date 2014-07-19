//
//  WWBaseView.h
//  WWFoundationDemo
//
//  Created by William Wu on 7/7/14.
//  Copyright (c) 2014 WW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+WWFoundation.h"

@protocol WWBaseViewDelegate <NSObject>

- (void)fillData;
- (void)viewDidTapped;

@end

@interface WWBaseView : UIView <WWBaseViewDelegate>

@property (nonatomic, weak) IBOutlet UIView *contentView;
@property (nonatomic, readonly) id<RIItemData> itemData;

- (void)bindData:(id<RIItemData>)itemData;

@end
