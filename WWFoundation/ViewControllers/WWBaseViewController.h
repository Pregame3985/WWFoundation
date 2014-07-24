//
//  WWBaseViewController.h
//  WWFoundation
//
//  Created by William Wu on 4/4/14.
//  Copyright (c) 2014 WW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+WWFoundation.h"

@interface WWBaseViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIImageView *backgroundView;

@property (nonatomic, weak) UITextField *activeTextField;
@property (nonatomic, weak) UITextView *activeTextView;
@property (nonatomic, weak) UISearchBar *activeSearchBar;
@property (nonatomic, weak) UIScrollView *activeScrollView;
@property (nonatomic, readonly) UIToolbar *editInputAccessoryView;

@property (nonatomic, assign) BOOL observeKeyboard;

- (void)applyStyle;
- (void)prepareData;

- (IBAction)back:(UIButton *)sender;
- (IBAction)cancel:(UIButton *)sender;

@end
