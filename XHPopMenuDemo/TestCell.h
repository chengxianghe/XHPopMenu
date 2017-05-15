//
//  TestCell.h
//  XHPopMenu
//
//  Created by chengxianghe on 2017/5/15.
//  Copyright © 2017年 cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHPopMenu.h"

@interface TestCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (weak, nonatomic) IBOutlet UISwitch *mySwitch;

- (void)setInfo:(XHPopMenuItem *)item configuration:(XHPopMenuConfiguration *)configuration;

@end
