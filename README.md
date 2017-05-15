# XHPopMenu
a menu like pop view
弹出菜单

[![Platform](http://img.shields.io/badge/platform-iOS-blue.svg?style=flat
)](https://developer.apple.com/iphone/index.action)
[![License](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat
)](http://mit-license.org)
![CocoaPods Version](https://img.shields.io/badge/pod-v0.36.4-brightgreen.svg)


------

- 使用 Objective-C. 
- 支持 ARC 和 CocoaPods 
- iOS 7.0+, Swift 3.0+
- 编译环境 Xcode 8.2
- 支持自定义cell
- 支持屏幕旋转适配

------

### Using CocoaPods
    pod 'XHPopMenu'

目前支持的自定义选项...

```objective-c

// 菜单设置
@property (nonatomic, assign) XHPopMenuAnimationStyle style; ///< 动画风格
@property (nonatomic, assign) CGFloat arrowSize; ///< 箭头大小
@property (nonatomic, assign) CGFloat arrowMargin; ///< 手动设置箭头和目标view的距离
@property (nonatomic, assign) CGFloat menuCornerRadius; ///< 菜单圆角半径
@property (nonatomic, assign) CGFloat menuScreenMinLeftRightMargin; ///< 菜单和屏幕左右的最小间距
@property (nonatomic, assign) CGFloat menuScreenMinBottomMargin; ///< 菜单和屏幕底部的最小间距
@property (nonatomic, assign) CGFloat menuMaxHeight; ///< 菜单最大高度
@property (nonatomic, assign) BOOL shadowOfMenu; ///< default:false 是否添加菜单阴影
@property (nonatomic, strong, nullable) UIColor *shadowColor; ///< 阴影颜色
@property (nonatomic, strong, nullable) UIColor *menuBackgroundColor; ///< 菜单的底色
@property (nonatomic, strong, nullable) UIColor *maskBackgroundColor; ///< 遮罩颜色
@property (nonatomic, assign) BOOL dismissWhenRotationScreen; ///< default:true 旋转屏幕时自动消失 注：false的时候会调用inView的layoutIfNeeded
@property (nonatomic, assign) BOOL revisedMaskWhenRotationScreen; ///< default:false 旋转屏幕过程中，如果设置了mask颜色，会有一块白色的区域闪现，这个属性为true时，在设置蒙层的时候直接宽高都为屏幕宽高中的最大值

// MenuItem设置
@property (nonatomic, assign) CGFloat marginXSpacing; ///< MenuItem左右边距
@property (nonatomic, assign) CGFloat marginYSpacing; ///< MenuItem上下边距
@property (nonatomic, assign) CGFloat intervalSpacing; ///< MenuItemImage与MenuItemTitle的间距
@property (nonatomic, assign) CGFloat separatorInsetLeft; ///< 分割线左侧Insets
@property (nonatomic, assign) CGFloat separatorInsetRight; ///< 分割线右侧Insets
@property (nonatomic, assign) CGFloat separatorHeight; ///< 分割线高度
@property (nonatomic, assign) CGFloat fontSize; ///< 字体大小
@property (nonatomic, assign) CGFloat itemHeight; ///< 单行高度
@property (nonatomic, assign) CGFloat itemMaxWidth; ///< 单行最大宽度
@property (nonatomic, assign) NSTextAlignment alignment; ///< 文字对齐方式
@property (nonatomic, assign) BOOL hasSeparatorLine; ///< default:true 是否设置分割线
@property (nonatomic, strong, nullable) UIColor *titleColor; ///< MenuItem字体颜色
@property (nonatomic, strong, nullable) UIColor *separatorColor; ///< 分割线颜色
@property (nonatomic, strong, nullable) UIColor *selectedColor; ///< menuItem选中颜色

// Menu Cell 自定义
@property (nonatomic,   copy, nullable) XHPopMenuCellConfig cellForRowConfig; ///< MenuCell 自定义，需要自行匹配 MenuItem 的各项配置

```


### Usage

#### Use View
```
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
    
    // 单独设置某个item的字体 优先级大于options设置
    [tempArr[2] setTitleFont:[UIFont boldSystemFontOfSize:18]];
    
    [XHPopMenu showMenuWithView:sender menuItems:tempArr withOptions:nil];

```

#### Use CGRect
```
 NSMutableArray<__kindof XHPopMenuItem *> *tempArr = [NSMutableArray array];
    NSArray *titleArr = @[@"扫一扫", @"加好友", @"创建讨论组", @"发送到电脑", @"面对面快传", @"收钱"];
    for (int i = 1; i < titleArr.count; i++) {
        XHPopMenuItem *model = [[XHPopMenuItem alloc] initWithTitle:titleArr[i - 1] image:[UIImage imageNamed:[NSString stringWithFormat:@"menu_%d",i]] block:^(XHPopMenuItem *item) {
            NSLog(@"block:%@",item);
        }];
        
        [tempArr addObject:model];
    }
    
    XHPopMenuConfiguration *option = [XHPopMenuConfiguration defaultConfiguration];
    option.style = XHPopMenuAnimationStyleScale;
    option.maskBackgroundColor = [UIColor colorWithWhite:0.2 alpha:0.3];
    
    [XHPopMenu showMenuInView:nil withRect:CGRectMake(10, 20, 120, 40) menuItems:tempArr withOptions:option];

```

### gif
![预览图](https://github.com/chengxianghe/watch-gif/blob/master/PopMenu.gif?raw=true)

