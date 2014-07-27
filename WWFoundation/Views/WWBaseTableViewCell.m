//
//  WWBaseTableViewCell.m
//  RipplingApp
//
//  Created by William Wu on 7/18/14.
//  Copyright (c) 2014 WW. All rights reserved.
//

#import "WWBaseTableViewCell.h"

@interface WWBaseTableViewCell ()

@property (nonatomic, weak) id<WWBaseViewDelegate> delegate;
@property (nonatomic, strong) id<RIItemData> itemData;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;

@end

@implementation WWBaseTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
    self.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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

@end
