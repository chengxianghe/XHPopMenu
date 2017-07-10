//
//  XHPopMenu.m
//  XHPopMenu
//
//  Created by chengxianghe on 16/4/7.
//  Copyright © 2016年 cn. All rights reserved.
//

#import "XHPopMenu.h"

#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

static const CGFloat kXHDefaultAnimateDuration = 0.15;

@implementation XHPopMenuConfiguration

+ (XHPopMenuConfiguration *)defaultConfiguration {
    XHPopMenuConfiguration *defaultConfiguration = [[self alloc] init];
    defaultConfiguration.style = XHPopMenuAnimationStyleWeiXin;
    defaultConfiguration.arrowSize = 10;
    defaultConfiguration.arrowMargin = 0;
    defaultConfiguration.marginXSpacing = 10;
    defaultConfiguration.marginYSpacing = 10;
    defaultConfiguration.intervalSpacing = 10;
    defaultConfiguration.menuCornerRadius = 4;
    defaultConfiguration.menuScreenMinLeftRightMargin = 10;
    defaultConfiguration.menuScreenMinBottomMargin = 10;
    defaultConfiguration.menuMaxHeight = 200;
    defaultConfiguration.separatorInsetLeft = 10;
    defaultConfiguration.separatorInsetRight = 10;
    defaultConfiguration.separatorHeight = 1;
    defaultConfiguration.fontSize = 15;
    defaultConfiguration.itemHeight = 40;
    defaultConfiguration.itemMaxWidth = 150;
    defaultConfiguration.alignment = NSTextAlignmentLeft;
    defaultConfiguration.shadowOfMenu = false;
    defaultConfiguration.hasSeparatorLine = true;
    defaultConfiguration.dismissWhenRotationScreen = false;
    defaultConfiguration.revisedMaskWhenRotationScreen = false;
    defaultConfiguration.dismissWhenClickBackground = true;
    defaultConfiguration.titleColor = [UIColor whiteColor];
    defaultConfiguration.separatorColor = [UIColor blackColor];
    defaultConfiguration.shadowColor = [UIColor blackColor];
    defaultConfiguration.menuBackgroundColor = [UIColor colorWithWhite:0.2 alpha:1];
    defaultConfiguration.maskBackgroundColor = [UIColor clearColor];
    defaultConfiguration.selectedColor = [UIColor colorWithWhite:0.5 alpha:0.8];
    return defaultConfiguration;
}

@end

@implementation XHPopMenuItem

#pragma mark - public func

- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image block:(XHPopMenuItemAction)block {
    self = [super init];
    if (self) {
        _title = title;
        _image = image;
        _block = block;
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image target:(id)target action:(SEL)action {
    self = [super init];
    if (self) {
        _title = title;
        _image = image;
        _target = target;
        _action = action;
    }
    return self;
}

#pragma mark - private func

- (void)performAction {
    __strong id target = self.target;
    __weak typeof(self) weakSelf = self;
    if (_block) {
        _block(weakSelf);
    }
    if (target && [target respondsToSelector:_action]) {
        [target performSelectorOnMainThread:_action withObject:weakSelf waitUntilDone:true];
    }
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@ #%p %@>", [self class], self, _title];
}

@end

@interface XHPopMenuTableViewCell : UITableViewCell

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)setInfo:(XHPopMenuItem *)item configuration:(XHPopMenuConfiguration *)configuration;

@end

@implementation XHPopMenuTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *identifier = @"XHPopMenuTableViewCell";
    XHPopMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[XHPopMenuTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.iconImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        cell.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        cell.lineView = [[UILabel alloc] initWithFrame:CGRectZero];
        
        [cell.contentView addSubview:cell.iconImageView];
        [cell.contentView addSubview:cell.titleLabel];
        [cell.contentView addSubview:cell.lineView];
        
        cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
        cell.selectedBackgroundView.layer.cornerRadius = 2;
        
        cell.contentView.backgroundColor = [UIColor clearColor];
    }
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat yMargin = 1;
    CGFloat xMargin = 2;
    CGFloat insetH = CGRectGetHeight(self.lineView.frame);
    CGFloat selectH = CGRectGetHeight(self.bounds) - insetH - yMargin * 2;
    self.selectedBackgroundView.frame = CGRectMake(xMargin, yMargin, CGRectGetWidth(self.bounds) - xMargin * 2, selectH);
}

- (void)setInfo:(XHPopMenuItem *)item configuration:(XHPopMenuConfiguration *)configuration {
    CGFloat margin = configuration.intervalSpacing;
    CGFloat left = configuration.marginXSpacing;
    CGFloat top = configuration.marginYSpacing;
    CGFloat height = configuration.itemHeight;
    CGFloat width = configuration.itemMaxWidth;
    
    CGFloat itemH = height - 2 * top;
    CGFloat itemW = width - 2 * left;
    
    if (configuration.hasSeparatorLine) {
        self.lineView.hidden = false;
        CGFloat insetL = configuration.separatorInsetLeft;
        CGFloat insetR = configuration.separatorInsetRight;
        CGFloat insetH = configuration.separatorHeight;
        self.lineView.backgroundColor = [UIColor clearColor];
        self.lineView.layer.backgroundColor = configuration.separatorColor.CGColor;
        self.lineView.frame = CGRectMake(insetL, height - insetH, width - insetL - insetR, insetH);
    } else {
        self.lineView.hidden = true;
    }
    
    if (item.image) {
        self.iconImageView.hidden = false;
        self.iconImageView.image = item.image;
        self.iconImageView.frame = CGRectMake(left, top, itemH, itemH);
        CGFloat labelX = CGRectGetMaxX(self.iconImageView.frame) + margin;
        
        self.titleLabel.frame = CGRectMake(labelX, top, width - labelX - left, itemH);
        
    } else {
        self.iconImageView.hidden = true;
        self.titleLabel.frame = CGRectMake(left, top, itemW, itemH);
    }
    
    self.titleLabel.text = item.title;
    self.titleLabel.font = item.titleFont;
    self.titleLabel.textColor = item.titleColor;
    self.titleLabel.textAlignment = configuration.alignment;
    self.backgroundColor = configuration.menuBackgroundColor;
    self.selectedBackgroundView.backgroundColor = configuration.selectedColor;
}

@end

@interface XHPopMenuView : UIView <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSArray<__kindof XHPopMenuItem *> *menuItems;
@property (nonatomic, strong) XHPopMenuConfiguration *configuration;
@property (nonatomic, assign, readonly) CGPoint startPoint;
@property (nonatomic, strong, readonly) UITableView *tableView;
@property (nonatomic, strong, readonly) CAShapeLayer *triangleLayer;
@property (nonatomic, strong, readonly) UIView *shadowView;
@property (nonatomic,   weak, readonly) UIView *targetView;
@property (nonatomic,   weak, readonly) UIView *inView;
@property (nonatomic, assign, readonly) CGRect targetRect;

- (void)dismissPopMenu;

@end

@implementation XHPopMenuView

- (instancetype)initInView:(UIView *)inView withRect:(CGRect)rect menuItems:(NSArray<__kindof XHPopMenuItem *> *)menuItems options:(XHPopMenuConfiguration *)options {
    CGRect frame = [UIScreen mainScreen].bounds;
    if (options.revisedMaskWhenRotationScreen) {
        CGFloat max = MAX(frame.size.width, frame.size.height);
        frame.size = CGSizeMake(max, max);
    }
    if (self = [super initWithFrame:frame]) {
        CGRect vFrame = rect;
        CGPoint centerPoint = CGPointMake(CGRectGetMinX(vFrame) + vFrame.size.width / 2.0, CGRectGetMinY(vFrame) + vFrame.size.height / 2.0);
        _targetRect = rect;
        _inView = inView;
        [self setupWithFrame:vFrame centerPoint:centerPoint menuItems:menuItems options:options];
    }
    return self;
}

- (instancetype)initInView:(UIView *)inView withView:(UIView *)view menuItems:(NSArray<__kindof XHPopMenuItem *> *)menuItems options:(XHPopMenuConfiguration *)options {
    CGRect frame = [UIScreen mainScreen].bounds;
    if (options.revisedMaskWhenRotationScreen) {
        CGFloat max = MAX(frame.size.width, frame.size.height);
        frame.size = CGSizeMake(max, max);
    }
    if (self = [super initWithFrame:frame]) {
        CGRect vFrame = [view.superview convertRect:view.frame toView:inView];
        CGPoint centerPoint = CGPointMake(CGRectGetMinX(vFrame) + vFrame.size.width / 2.0, CGRectGetMinY(vFrame) + vFrame.size.height / 2.0);
        _targetView = view;
        _inView = inView;
        [self setupWithFrame:vFrame centerPoint:centerPoint menuItems:menuItems options:options];
    }
    return self;
}

- (void)setupWithFrame:(CGRect)vFrame centerPoint:(CGPoint)centerPoint menuItems:(NSArray<__kindof XHPopMenuItem *> *)menuItems options:(XHPopMenuConfiguration *)options {
    self.configuration = options;
    self.menuItems = menuItems;
    
    UIFont *itemFont = [UIFont systemFontOfSize:self.configuration.fontSize];
    UIColor *itemTitleColor = self.configuration.titleColor;
    
    [menuItems enumerateObjectsUsingBlock:^(__kindof XHPopMenuItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (!obj.titleFont) {
            obj.titleFont = itemFont;
        }
        if (!obj.titleColor) {
            obj.titleColor = itemTitleColor;
        }
    }];
    
    self.backgroundColor = self.configuration.maskBackgroundColor;
    
    CGFloat itemHeight = self.configuration.itemHeight;
    CGFloat menuWidth = self.configuration.itemMaxWidth;
    CGFloat triangleHeight = self.configuration.arrowSize;
    CGFloat triangleMargin = self.configuration.arrowMargin;
    CGFloat menuScreenLeftRightMinMargin = self.configuration.menuScreenMinLeftRightMargin;
    
    CGFloat tableViewH = itemHeight * menuItems.count;
    BOOL isBounces = tableViewH > self.configuration.menuMaxHeight;
    
    if (isBounces) {
        tableViewH = self.configuration.menuMaxHeight;
    }
    
    BOOL isDown = tableViewH + triangleHeight + triangleMargin + CGRectGetMaxY(vFrame) < kScreenH - self.configuration.menuScreenMinBottomMargin;
    
    CGFloat triangleX = centerPoint.x;
    CGFloat triangleY = isDown ? CGRectGetMaxY(vFrame) + triangleMargin : CGRectGetMinY(vFrame) - triangleMargin;
    
    CGFloat tableViewY = CGRectGetMaxY(vFrame) + triangleHeight + triangleMargin - 0.5 * tableViewH;
    CGFloat tableViewX = triangleX - menuWidth * 0.5;
    
    
    if (!isDown) {
        tableViewY = triangleY - triangleHeight - tableViewH * 0.5;
    }
    
    CGPoint anchorPoint = isDown ? CGPointMake(0.5f, 0.0f) :CGPointMake(0.5f, 1.0f);
    
    //fixed bug: tableViewX < menuScreenLeftRightMinMargin + menuWidth * 0.5
    if (tableViewX < menuScreenLeftRightMinMargin) {
        tableViewX = menuScreenLeftRightMinMargin;
        anchorPoint.x = (triangleX - tableViewX)/menuWidth;
        tableViewX = triangleX - menuWidth * 0.5;
        
    } else if (tableViewX + menuWidth > kScreenW - menuScreenLeftRightMinMargin){
        tableViewX = kScreenW - menuScreenLeftRightMinMargin - menuWidth;
        anchorPoint.x = (triangleX - tableViewX)/menuWidth;
        tableViewX = triangleX - menuWidth * 0.5;
    }
    
    _startPoint = CGPointMake(triangleX, triangleY);
    
    CGRect tableFrame = CGRectMake(tableViewX, tableViewY, menuWidth, tableViewH);
    
    _tableView = [[UITableView alloc] initWithFrame:tableFrame style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = self.configuration.menuBackgroundColor;
    _tableView.layer.cornerRadius = self.configuration.menuCornerRadius;
    _tableView.layer.masksToBounds = true;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.bounces = isBounces;
    _tableView.layer.anchorPoint = anchorPoint;
    _tableView.rowHeight = itemHeight;
    [self addSubview:_tableView];
    
    if (self.configuration.shadowOfMenu) {
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        
        UIView *shadow = [[UIView alloc] init];
        shadow.backgroundColor = [UIColor clearColor];
        shadow.frame = CGRectMake(_startPoint.x, _startPoint.y + triangleHeight, 1, 1);
        if (!isDown) {
            shadow.frame = CGRectMake(_startPoint.x, _startPoint.y - triangleHeight, 1, 1);
        }
        CGRect rect = CGRectMake(_startPoint.x -tableViewX - (anchorPoint.x+ 0.5) * menuWidth, _startPoint.y + triangleHeight - tableViewY - 0.5 *tableViewH, menuWidth, tableViewH);
        if (!isDown) {
            rect.origin.y = tableViewY + triangleHeight - _startPoint.y - 0.5 * tableViewH;
        }
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:self.configuration.menuCornerRadius];
        shadow.layer.shadowPath = path.CGPath;
        
        shadow.layer.shadowOpacity = 0.8;
        shadow.layer.shadowColor = _configuration.shadowColor.CGColor;
        shadow.layer.shadowOffset = CGSizeMake(0, 1);
        shadow.layer.shadowRadius = 5;
        
        _shadowView = shadow;
        [self insertSubview:shadow belowSubview:_tableView];
        [CATransaction commit];
    }
    
    [self drawTriangleLayerIsDown:isDown];
}

- (void)drawTriangleLayerIsDown:(BOOL)isDown {
    CGFloat triangleHeight = self.configuration.arrowSize;
    CGFloat triangleLength = triangleHeight * 2.0 / 1.732;
    CGPoint point = _startPoint;
    UIBezierPath *path = [UIBezierPath bezierPath];
    if (isDown) {
        [path moveToPoint:point];
        [path addLineToPoint:CGPointMake(point.x - triangleLength * 0.5, point.y + triangleHeight)];
        [path addLineToPoint:CGPointMake(point.x + triangleLength * 0.5, point.y + triangleHeight)];
    } else {
        [path moveToPoint:point];
        [path addLineToPoint:CGPointMake(point.x - triangleLength * 0.5, point.y - triangleHeight)];
        [path addLineToPoint:CGPointMake(point.x + triangleLength * 0.5, point.y - triangleHeight)];
    }
    
    CAShapeLayer *triangleLayer = [CAShapeLayer layer];
    triangleLayer.path = path.CGPath;
    triangleLayer.fillColor = _configuration.menuBackgroundColor.CGColor;
    triangleLayer.strokeColor = _configuration.menuBackgroundColor.CGColor;
    
    if (self.configuration.shadowOfMenu) {
        triangleLayer.shadowOpacity = 0.8;
        triangleLayer.shadowColor = _configuration.shadowColor.CGColor;
        triangleLayer.shadowOffset = CGSizeMake(0, 0);
        triangleLayer.shadowRadius = 5;
    }
    
    _triangleLayer = triangleLayer;
    [self.layer insertSublayer:triangleLayer below:_tableView.layer];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.configuration.dismissWhenClickBackground) {
        [XHPopMenu dismissMenu];
        if (self.configuration.dismissBlock) {
            self.configuration.dismissBlock();
        }
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.menuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.configuration.cellForRowConfig) {
        return self.configuration.cellForRowConfig(tableView, indexPath, self.configuration, self.menuItems[indexPath.row]);
    }
    
    XHPopMenuTableViewCell *cell = [XHPopMenuTableViewCell cellWithTableView:tableView];
    XHPopMenuItem *item = self.menuItems[indexPath.row];
    [cell setInfo:item configuration:self.configuration];
    
    if (indexPath.row == self.menuItems.count - 1) {
        cell.lineView.hidden = true;
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    XHPopMenuItem *item = self.menuItems[indexPath.row];
    [item performAction];
    [XHPopMenu dismissMenu];
}

- (void)showMenuInView:(UIView *)view {
    [view addSubview:self];
    
    XHPopMenuAnimationStyle style = _configuration.style;
    
    if (style == XHPopMenuAnimationStyleScale) {
        self.tableView.transform = CGAffineTransformIdentity;
        self.shadowView.transform = CGAffineTransformIdentity;
        self.tableView.transform = CGAffineTransformMakeScale(0.001, 0.001);
        self.shadowView.transform = CGAffineTransformMakeScale(0.001, 0.001);
        self.alpha = 0;
        
        [UIView animateWithDuration:kXHDefaultAnimateDuration animations:^{
            self.alpha = 1;
            self.tableView.transform = CGAffineTransformIdentity;
            self.shadowView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
        }];
        
    } else if (style == XHPopMenuAnimationStyleFade) {
        self.alpha = 0;
        [UIView animateWithDuration:kXHDefaultAnimateDuration animations:^{
            self.alpha = 1;
        } completion:^(BOOL finished) {
        }];
    }
}

- (void)dismissPopMenu {
    XHPopMenuAnimationStyle style = _configuration.style;
    
    if (style == XHPopMenuAnimationStyleWeiXin) {
        self.alpha = 1;
        [UIView animateWithDuration:kXHDefaultAnimateDuration animations:^{
            self.tableView.transform = CGAffineTransformMakeScale(0.6, 0.6);
            self.shadowView.transform = CGAffineTransformMakeScale(0.6, 0.6);
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self dismissCompletion];
        }];
        
    } else if (style == XHPopMenuAnimationStyleScale) {
        self.alpha = 1;
        [UIView animateWithDuration:kXHDefaultAnimateDuration animations:^{
            self.tableView.transform = CGAffineTransformMakeScale(0.001, 0.001);
            self.shadowView.transform = CGAffineTransformMakeScale(0.001, 0.001);
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self dismissCompletion];
        }];
    } else if (style == XHPopMenuAnimationStyleFade) {
        self.alpha = 1;
        [UIView animateWithDuration:kXHDefaultAnimateDuration animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self dismissCompletion];
        }];
    } else if (style == XHPopMenuAnimationStyleNone) {
        [self dismissCompletion];
    }
}

- (void)dismissCompletion {
    self.configuration = nil;
    self.menuItems = nil;
    [self.shadowView removeFromSuperview];
    [self.tableView removeFromSuperview];
    [self.triangleLayer removeFromSuperlayer];
    [self removeFromSuperview];
}

@end

@interface XHPopMenu ()

@property (nonatomic,   weak) XHPopMenuView *popmenuView;
@property (nonatomic, assign) BOOL isObserving;

@end

@implementation XHPopMenu

#pragma mark - public func
+ (void)showMenuInView:(UIView *)inView withRect:(CGRect)rect menuItems:(NSArray<__kindof XHPopMenuItem *> *)menuItems withOptions:(XHPopMenuConfiguration *)options {
    if (options == nil) {
        options = [XHPopMenuConfiguration defaultConfiguration];
    }
    [[self sharedManager] showMenuInView:inView withRect:rect menuItems:menuItems withOptions:options];
}

+ (void)showMenuWithView:(UIView *)view menuItems:(NSArray<__kindof XHPopMenuItem *> *)menuItems withOptions:(XHPopMenuConfiguration *)options {
    [self showMenuInView:nil withView:view menuItems:menuItems withOptions:options];
}

+ (void)showMenuInView:(UIView *)inView withView:(UIView *)view menuItems:(NSArray<__kindof XHPopMenuItem *> *)menuItems withOptions:(XHPopMenuConfiguration *)options {
    if (options == nil) {
        options = [XHPopMenuConfiguration defaultConfiguration];
    }
    [[self sharedManager] showMenuInView:inView withView:view menuItems:menuItems withOptions:options];
}

+ (void)dismissMenu {
    [[self sharedManager] dismissMenu];
}

+ (instancetype)sharedManager{
    static XHPopMenu *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[XHPopMenu alloc] init];
    });
    return manager;
}

#pragma mark - implementation
- (void)dealloc {
    if (_isObserving) {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
}

- (void)showMenuInView:(UIView *)inView withRect:(CGRect)rect menuItems:(NSArray<__kindof XHPopMenuItem *> *)menuItems withOptions:(XHPopMenuConfiguration *)options {
    
    if (_popmenuView) {
        [_popmenuView dismissPopMenu];
        _popmenuView = nil;
    }
    if (!_isObserving) {
        _isObserving = true;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(orientationDidChange:)
                                                     name:UIApplicationDidChangeStatusBarOrientationNotification
                                                   object:nil];
    }
    if (!inView) {
        inView = [UIApplication sharedApplication].keyWindow;
    }
    XHPopMenuView *popmenuView = [[XHPopMenuView alloc] initInView:inView withRect:rect menuItems:menuItems options:options];
    _popmenuView = popmenuView;
    [_popmenuView showMenuInView:inView];
}

- (void)showMenuInView:(UIView *)inView withView:(UIView *)view menuItems:(NSArray<__kindof XHPopMenuItem *> *)menuItems withOptions:(XHPopMenuConfiguration *)options {
    
    if (_popmenuView) {
        [_popmenuView dismissPopMenu];
        _popmenuView = nil;
    }
    if (!_isObserving) {
        _isObserving = true;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(orientationDidChange:)
                                                     name:UIApplicationDidChangeStatusBarOrientationNotification
                                                   object:nil];
    }
    if (!inView) {
        inView = [UIApplication sharedApplication].keyWindow;
    }
    XHPopMenuView *popmenuView = [[XHPopMenuView alloc] initInView:inView withView:view menuItems:menuItems options:options];
    _popmenuView = popmenuView;
    [_popmenuView showMenuInView:inView];
}

#pragma mark - orientation

- (void)orientationDidChange:(NSNotification *)note {
    XHPopMenuConfiguration *options = _popmenuView.configuration;
    
    if (options.dismissWhenRotationScreen) {
        [self dismissMenu];
    } else {
        NSArray<__kindof XHPopMenuItem *> *menuItems = _popmenuView.menuItems;
        UIView *inView = _popmenuView.inView;
        
        if (_popmenuView.targetView) {
            UIView *withView = _popmenuView.targetView;
            [self dismissMenuAnimation:NO];
            
            // refresh the inView frame
            [inView layoutIfNeeded];
            [inView setNeedsDisplay];
            XHPopMenuAnimationStyle style = options.style;
            options.style = XHPopMenuAnimationStyleNone;
            [self showMenuInView:inView withView:withView menuItems:menuItems withOptions:options];
            options.style = style;
        } else {
            CGRect rect = _popmenuView.targetRect;
            [self dismissMenuAnimation:NO];
            
            // refresh the inView frame
            [inView layoutIfNeeded];
            [inView setNeedsDisplay];
            XHPopMenuAnimationStyle style = options.style;
            options.style = XHPopMenuAnimationStyleNone;
            [self showMenuInView:inView withRect:rect menuItems:menuItems withOptions:options];
            options.style = style;
        }
    }
}

- (void)dismissMenu {
    [self dismissMenuAnimation:YES];
}

- (void)dismissMenuAnimation:(BOOL)animation {
    if (_popmenuView) {
        if (animation) {
            [_popmenuView dismissPopMenu];
        } else {
            [_popmenuView dismissCompletion];
            _popmenuView = nil;
        }
    }
    if (_isObserving) {
        _isObserving = false;
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
}

@end
