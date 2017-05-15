//
//  TestCell.m
//  XHPopMenu
//
//  Created by chengxianghe on 2017/5/15.
//  Copyright © 2017年 cn. All rights reserved.
//

#import "TestCell.h"

@implementation TestCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setInfo:(XHPopMenuItem *)item configuration:(XHPopMenuConfiguration *)configuration {
    if (item.image) {
        self.myImageView.hidden = false;
        self.myImageView.image = item.image;
    } else {
        self.myImageView.hidden = true;
    }
    
    self.mySwitch.on = YES;

    self.backgroundColor = configuration.menuBackgroundColor;
    self.selectedBackgroundView.backgroundColor = configuration.selectedColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
