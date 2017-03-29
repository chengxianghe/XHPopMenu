//
//  SecondViewController.m
//  XHPopMenu
//
//  Created by chengxianghe on 16/4/6.
//  Copyright © 2016年 cn. All rights reserved.
//

#import "SecondViewController.h"
#import "XHPopMenu.h"

#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

@interface SecondViewController ()

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UISlider *upDownMove;
@property (weak, nonatomic) IBOutlet UISlider *leftRightMove;
@property (weak, nonatomic) IBOutlet UIButton *moveButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *moveY;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *moveX;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.upDownMove.maximumValue = kScreenH - 30;
    self.leftRightMove.maximumValue = kScreenW - 38;
    
    self.upDownMove.value = 300;
    self.leftRightMove.value = 10;
    self.moveX.constant = 10;
    self.moveY.constant = 300;
}

- (IBAction)onLeftBarButtonItemClick:(UIBarButtonItem *)sender {
    NSMutableArray<__kindof XHPopMenuItem *> *tempArr = [NSMutableArray array];
    NSArray *titleArr = @[@"扫一扫", @"加好友", @"创建讨论组", @"发送到电脑", @"面对面快传", @"收钱"];
    for (int i = 1; i < titleArr.count; i++) {
        XHPopMenuItem *model = [[XHPopMenuItem alloc] initWithTitle:titleArr[i - 1] image:[UIImage imageNamed:[NSString stringWithFormat:@"menu_%d",i]] block:^(XHPopMenuItem *item) {
            NSLog(@"block:%@",item);
        }];
        
        [tempArr addObject:model];
    }
    
    // 单独设置某个item的字体颜色 优先级大于options设置
    [tempArr[0] setTitleColor:[UIColor redColor]];
    [tempArr[1] setTitleColor:[UIColor yellowColor]];
    
    // 单独设置某个item的字体 优先级大于options设置
    [tempArr[2] setTitleFont:[UIFont boldSystemFontOfSize:18]];
    
    XHPopMenuConfiguration *option = [XHPopMenuConfiguration defaultConfiguration];
    option.style = XHPopMenuAnimationStyleScale;
    option.maskBackgroundColor = [UIColor colorWithWhite:0.2 alpha:0.3];
    
    [XHPopMenu showMenuInView:nil withRect:CGRectMake(10, 20, 120, 40) menuItems:tempArr withOptions:option];
}


- (IBAction)onButtonClick:(UIButton *)sender {
    NSMutableArray<__kindof XHPopMenuItem *> *tempArr = [NSMutableArray array];
    NSArray *titleArr = @[@"扫一扫", @"加好友", @"创建讨论组", @"发送到电脑", @"面对面快传", @"收钱"];
    for (int i = 1; i < titleArr.count; i++) {
        XHPopMenuItem *model = [[XHPopMenuItem alloc] initWithTitle:titleArr[i - 1] image:[UIImage imageNamed:[NSString stringWithFormat:@"menu_%d",i]] block:^(XHPopMenuItem *item) {
            NSLog(@"block:%@",item);
        }];
        
        [tempArr addObject:model];
    }
    
//    [XHPopMenu showMenuInView:self.view withRect:_backView.frame menuItems:tempArr withOptions:nil];
    [XHPopMenu showMenuInView:self.view withView:_backView menuItems:tempArr withOptions:nil];

}

- (IBAction)move:(UIButton *)sender {
    NSMutableArray<__kindof XHPopMenuItem *> *tempArr = [NSMutableArray array];
    NSArray *titleArr = @[@"扫一扫", @"加好友", @"创建讨论组", @"发送到电脑", @"面对面快传", @"收钱"];
    for (int i = 1; i < titleArr.count; i++) {
        XHPopMenuItem *model = [[XHPopMenuItem alloc] initWithTitle:titleArr[i - 1] image:[UIImage imageNamed:[NSString stringWithFormat:@"menu_%d",i]] block:^(XHPopMenuItem *item) {
            NSLog(@"block:%@",item);
        }];
        
        [tempArr addObject:model];
    }
    
    XHPopMenuConfiguration *options = [XHPopMenuConfiguration defaultConfiguration];
    
    // 设置menu动画风格
    options.style = XHPopMenuAnimationStyleScale;
    
    // 设置menu距离屏幕左右两边的最小间距
    options.menuScreenMinLeftRightMargin = 10;
    
    // 新增方法 设置menu距离屏幕底部的最小间距
    options.menuScreenMinBottomMargin = 49;
    
    [XHPopMenu showMenuInView:self.tabBarController.view withView:sender menuItems:tempArr withOptions:options];
}

- (IBAction)upDownMoveChange:(UISlider *)sender {
    self.moveY.constant = sender.value;
}

- (IBAction)leftRightMoveChange:(UISlider *)sender {
    self.moveX.constant = sender.value;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
