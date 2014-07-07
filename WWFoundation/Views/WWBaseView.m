//
//  WWBaseView.m
//  WWFoundationDemo
//
//  Created by William Wu on 7/7/14.
//  Copyright (c) 2014 WW. All rights reserved.
//

#import "WWBaseView.h"

@implementation WWBaseView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    [self addSubview:self.contentView];
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

@end
