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
+ (void)showMenuInView:(UIView * __nullable)inView
              withRect:(CGRect)rect
             menuItems:(NSArray<__kindof XHPopMenuItem *> * __nonnull)menuItems
           withOptions:(XHPopMenuConfiguration * __nullable)options;

/**
 展示Menu

 @param inView      容器View 默认KeyWindow
 @param view        触发View
 @param menuItems   items
 @param options     设置
 */
+ (void)showMenuInView:(UIView * __nullable)inView
              withView:(UIView * __nonnull)view
             menuItems:(NSArray<__kindof XHPopMenuItem *> * __nonnull)menuItems
           withOptions:(XHPopMenuConfiguration * __nullable)options;


/**
 展示Menu

 @param view        触发View
 @param menuItems   items
 @param options     设置
 */
+ (void)showMenuWithView:(UIView * __nonnull)view
               menuItems:(NSArray<__kindof XHPopMenuItem *> * __nonnull)menuItems
             withOptions:(XHPopMenuConfiguration * __nullable)options;


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
@property (nonatomic, assign) BOOL shadowOfMenu; ///< 是否添加菜单阴影 default:false
@property (nonatomic, strong) UIColor *shadowColor; ///< 阴影颜色
@property (nonatomic, strong) UIColor *menuBackgroundColor; ///< 菜单的底色
@property (nonatomic, strong) UIColor *maskBackgroundColor; ///< 遮罩颜色
@property (nonatomic, assign) BOOL    dismissWhenRotationScreen; ///< 旋转屏幕时自动消失 default:true 注：false的时候会调用inView的layoutIfNeeded

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
@property (nonatomic, assign) BOOL hasSeparatorLine; ///< 是否设置分割线 default:true
@property (nonatomic, strong) UIColor *titleColor; ///< MenuItem字体颜色
@property (nonatomic, strong) UIColor *separatorColor; ///< 分割线颜色
@property (nonatomic, strong) UIColor *selectedColor; ///< menuItem选中颜色

+ (instancetype)defaultConfiguration;

@end

@interface XHPopMenuItem : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIColor *titleColor; ///< menuItem字体颜色 优先级大于Configuration的设置
@property (nonatomic, strong) UIFont *titleFont; ///< menuItem字体 优先级大于Configuration的设置
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign, readonly) SEL action;
@property (nonatomic,   weak, readonly) id target;
@property (nonatomic,   copy, readonly) XHPopMenuItemAction block;

- (instancetype)initWithTitle:(NSString *)title
                        image:(UIImage *)image
                       target:(id)target
                       action:(SEL)action;

- (instancetype)initWithTitle:(NSString *)title
                        image:(UIImage *)image
                        block:(XHPopMenuItemAction)block;

@end

NS_ASSUME_NONNULL_END
