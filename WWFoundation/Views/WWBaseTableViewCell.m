//
//  WWBaseTableViewCell.m
//  RipplingApp
//
//  Created by William Wu on 7/18/14.
//  Copyright (c) 2014 WW. All rights reserved.
//

#import "WWBaseTableViewCell.h"

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
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)fillData
{}

@end
