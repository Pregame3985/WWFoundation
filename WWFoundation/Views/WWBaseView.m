//
//  WWBaseView.m
//  WWFoundationDemo
//
//  Created by William Wu on 7/7/14.
//  Copyright (c) 2014 WW. All rights reserved.
//

#import "WWBaseView.h"

@interface WWBaseView ()

@property (nonatomic, weak) id<WWBaseViewDelegate> delegate;
@property (nonatomic, strong) id<RIItemData> itemData;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;

@end

@implementation WWBaseView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    [self addSubview:self.contentView];
    
    self.delegate = self;
    
    self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                              action:@selector(handleTapGesture:)];
    
    [self addGestureRecognizer:self.tapGesture];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

- (void)removeFromSuperview
{
    [self removeGestureRecognizer:self.tapGesture];
    
    self.tapGesture = nil;
    self.delegate = nil;
    
    [super removeFromSuperview];
}

- (void)bindData:(id<RIItemData>)itemData
{
    self.itemData = itemData;
    
    [self.delegate fillData];
}

- (void)fillData
{}

- (void)viewDidTapped
{}

- (void)handleTapGesture:(UITapGestureRecognizer *)tapGesture
{
    DLog(@"%@", @"Content View Did Tapped");
    
    [self.delegate viewDidTapped];
}

@end
