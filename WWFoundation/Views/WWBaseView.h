//
//  WWBaseView.h
//  WWFoundationDemo
//
//  Created by William Wu on 7/7/14.
//  Copyright (c) 2014 WW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+WWFoundation.h"
#import "WWBaseInfo.h"

@protocol WWBaseViewDelegate <NSObject>

- (void)fillData;
- (void)viewDidTapped;

@optional
- (void)prepareForReuse;
- (void)applyStyle;

@end

@interface WWBaseView : UIView <WWBaseViewDelegate>

@property (nonatomic, weak) IBOutlet UIView *contentView;
@property (nonatomic, readonly) id<WWItemDataDelegate> itemData;
@property (nonatomic, readonly) NSUInteger index;
@property (nonatomic, strong) NSString *viewIdentifier;

- (void)bindData:(id<WWItemDataDelegate>)itemData;
- (void)bindData:(id<WWItemDataDelegate>)itemData atIndex:(NSUInteger)index;

@end
