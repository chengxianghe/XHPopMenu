//
//  XHPopMenu.h
//  XHPopMenu
//
//  Created by chengxianghe on 16/4/7.
//  Copyright © 2016年 cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class XHPopMenuView, XHPopMenuItem, XHPopMenuConfiguration;

typedef void (^XHPopMenuItemAction)(XHPopMenuItem * __nullable item);
typedef UITableViewCell * __nonnull (^XHPopMenuCellConfig)(UITableView *tableView, NSIndexPath *indexPath, XHPopMenuConfiguration *option, XHPopMenuItem *item);

typedef NS_ENUM(NSUInteger, XHPopMenuAnimationStyle) {
    XHPopMenuAnimationStyleNone,
    XHPopMenuAnimationStyleFade,
    XHPopMenuAnimationStyleScale,
    XHPopMenuAnimationStyleWeiXin,
};

@interface XHPopMenu : NSObject

/**
 展示Menu(CGRect)
 
 @param inView      容器View 默认KeyWindow
 @param rect        触发者的rect(需根据容器View指定rect)
 @param menuItems   items
 @param options     设置
 */
+ (void)showMenuInView:(nullable UIView *)inView
              withRect:(CGRect)rect
             menuItems:(nonnull NSArray<__kindof XHPopMenuItem *> *)menuItems
           withOptions:(nullable XHPopMenuConfiguration *)options;

/**
 展示Menu
 
 @param inView      容器View 默认KeyWindow
 @param view        触发View
 @param menuItems   items
 @param options     设置
 */
+ (void)showMenuInView:(nullable UIView *)inView
              withView:(nonnull UIView *)view
             menuItems:(nonnull NSArray<__kindof XHPopMenuItem *> *)menuItems
           withOptions:(nullable XHPopMenuConfiguration *)options;


/**
 展示Menu
 
 @param view        触发View
 @param menuItems   items
 @param options     设置
 */
+ (void)showMenuWithView:(nonnull UIView *)view
               menuItems:(nonnull NSArray<__kindof XHPopMenuItem *> *)menuItems
             withOptions:(nullable XHPopMenuConfiguration *)options;


/**
 取消展示
 */
+ (void)dismissMenu;

@end

@interface XHPopMenuConfiguration : NSObject

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
@property (nonatomic, assign) BOOL dismissWhenClickBackground; ///< default:true 是否在点击背景的时候消失
@property (nonatomic,   copy, nullable) void(^dismissBlock)(void); ///<点击背景dismiss的时候会执行

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

+ (instancetype)defaultConfiguration;

@end

@interface XHPopMenuItem : NSObject

@property (nonatomic, strong, nullable) NSString *title;
@property (nonatomic, strong, nullable) UIColor *titleColor; ///< menuItem字体颜色 优先级大于Configuration的设置
@property (nonatomic, strong, nullable) UIFont *titleFont; ///< menuItem字体 优先级大于Configuration的设置
@property (nonatomic, strong, nullable) UIImage *image;
@property (nonatomic, assign, nullable, readonly) SEL action;
@property (nonatomic,   weak, nullable, readonly) id target;
@property (nonatomic,   copy, nullable, readonly) XHPopMenuItemAction block;

- (instancetype)initWithTitle:(nullable NSString *)title
                        image:(nullable UIImage *)image
                       target:(id)target
                       action:(SEL)action;

- (instancetype)initWithTitle:(nullable NSString *)title
                        image:(nullable UIImage *)image
                        block:(nullable XHPopMenuItemAction)block;

@end

NS_ASSUME_NONNULL_END
