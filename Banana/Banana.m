//
//  StrataMenu.m
//  StrataMenu
//
//  Created by Arnaud Schildknecht on 12/10/2015.
//  Copyright © 2015 Arnaud Schildknecht. All rights reserved.
//

#import "Banana.h"
#import "BananaComponentView.h"
#import "UIImage+Color.h"

@interface Banana ()

@property (nonatomic, getter=isOpen) BOOL        open;

@property (weak, nonatomic) UINavigationController  *navigationController;
@property (strong, nonatomic) UIView                *containerView;
@property (strong, nonatomic) UIView                *menuView;
@property (strong, nonatomic) NSMutableArray        *componentViews;

@property (nonatomic) CGFloat       menuViewHeight;

@end

@implementation Banana

- (id)initWithComponents:(NSArray *)components andNavigationController:(UINavigationController *)navigationController {
    self = [self init];
    
    if (self) {
        self.menuComponents = components;
        self.navigationController = navigationController;

        self.componentViews = [[NSMutableArray alloc] init];
        self.open = NO;
    
        self.separatorHeight = 1.0;
        self.separatorOffset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        self.animationDuration = 1.0;
        self.animationDelayDuration = 0.0;
        self.bounceAnimationDuration = 1.0;
        self.backgroundMaxAlpha = 0.5;
        self.bounce = NO;
        
        self.hasToggleButton = YES;
        self.hasBottomShadow = NO;
        self.buttonHeight = 50.0;
        self.buttonTitle = @"Open menu";
        self.buttonTitleFont = [UIFont fontWithName:@"HelveticaNeue-Regular" size:20.0];
        self.buttonOpenedOffset = CGSizeMake(0, 0);
        
        self.backgroundColor = [UIColor clearColor];
        self.menuBackgroundColor = [UIColor colorWithRed:65.0 / 255.0 green:121.0 / 255.0 blue:173.0 / 255.0 alpha:1.0];
        self.buttonBackgroundColor = [UIColor colorWithRed:65.0 / 255.0 green:121.0 / 255.0 blue:173.0 / 255.0 alpha:1.0];
        self.separatorColor = [UIColor whiteColor];
        self.highlightedButtonBackgroundColor = [UIColor clearColor];
        self.highlightedButtonTextColor = [UIColor clearColor];
        
        self.containerView = [[UIView alloc] init];
    }
    return self;
}

- (void)addComponentToMenu {
    CGFloat     yOrigin = [self getMenuViewHeight];
    CGFloat     xOrigin = 0.0;
        
    if (!_menuView) {
        _menuView = [[UIView alloc] init];
        
        _menuView.backgroundColor = _menuBackgroundColor;
    }
    
    for (BananaComponent *component in _menuComponents) {
        // Add component
        CGFloat                     componentWidth = _navigationController.navigationBar.frame.size.width;
        CGFloat                     componentHeight = component.view.frame.size.height;
        CGRect                      rect = CGRectMake(xOrigin, yOrigin, componentWidth, componentHeight);
        BananaComponentView     *componentView = [[BananaComponentView alloc] initWithFrame:rect andComponent:component andStrataMenu:self];
        
        [_componentViews addObject:componentView];
        [_menuView addSubview:componentView];
        yOrigin += componentHeight;
        
        // Add separator
        CGFloat                     separatorWidth = componentWidth - _separatorOffset.left - _separatorOffset.right;
        CGFloat                     separatorOriginY = yOrigin + _separatorOffset.top - _separatorOffset.bottom;
        UIView                      *separator = [[UIView alloc] initWithFrame:CGRectMake(0 + _separatorOffset.left, separatorOriginY, separatorWidth, _separatorHeight)];
        
        separator.backgroundColor = _separatorColor;
        
        [_menuView addSubview:separator];
        yOrigin += _separatorHeight;
    }
    _menuViewHeight = yOrigin;
    _menuView.alpha = 0.0;
    
    [_containerView addSubview:_menuView];
    
    if (_hasToggleButton) {
        [self addToggleButtonWithOrigin:CGPointMake(xOrigin, yOrigin)];
    }
}

- (void)addToggleButtonWithOrigin:(CGPoint)origin {
    CGRect  rect = CGRectZero;
    
    if (!_toggleButton) {
        rect = CGRectMake(origin.x, origin.y, self.navigationController.view.frame.size.width, _buttonHeight);
        
        _toggleButton = [UIButton buttonWithType:UIButtonTypeCustom];

        [_toggleButton setTitle:_buttonTitle forState:UIControlStateNormal];
        
        _toggleButton.backgroundColor = _buttonBackgroundColor;
        _toggleButton.titleLabel.font = _buttonTitleFont;
        
        [_toggleButton setBackgroundImage:[UIImage imageWithColor:_highlightedButtonBackgroundColor] forState:UIControlStateHighlighted];
        [_toggleButton setTitleColor:_highlightedButtonTextColor forState:UIControlStateHighlighted];
    }
    else {
        rect = _toggleButton.frame;
        
        rect.origin.x = origin.x;
        rect.origin.y = origin.y;
        rect.size.width = self.navigationController.view.frame.size.width;
    }
    
    rect.size.height = _buttonHeight;
    
    _toggleButton.frame = rect;
    
    if (_hasBottomShadow) {
        _toggleButton.layer.shadowColor = [UIColor blackColor].CGColor;
        _toggleButton.layer.shadowOffset = CGSizeMake(2, 4.0);
        _toggleButton.layer.shadowOpacity = 0.11;
        _toggleButton.layer.shadowRadius = 0.0;
    }
    
    [_toggleButton addTarget:self action:@selector(toggle) forControlEvents:UIControlEventTouchUpInside];
    [_containerView addSubview:_toggleButton];
}

- (void)initBackgroundView {
    UITapGestureRecognizer  *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggle)];

    tap.numberOfTapsRequired = 1;
    
    _backgroundView = [[UIView alloc] initWithFrame:_navigationController.view.frame];
    
    _backgroundView.alpha = 0.0;
    _backgroundView.backgroundColor = _backgroundColor;
    
    [_backgroundView addGestureRecognizer:tap];
}

- (void)prepare {
    [self initBackgroundView];
    [self addComponentToMenu];
    CGFloat menuYOrigin = _navigationController.navigationBar.frame.origin.y + _navigationController.navigationBar.frame.size.height + + [UIApplication sharedApplication].statusBarFrame.size.height;
    CGRect  containerRect = CGRectMake(0, menuYOrigin - [self getMenuViewHeight], _navigationController.view.frame.size.width, [self getMenuViewHeight] + _toggleButton.frame.size.height);
    CGRect  menuRect = CGRectMake(0, 0, _navigationController.view.frame.size.width, [self getMenuViewHeight]);
    
    _menuView.frame = menuRect;
    _containerView.frame = containerRect;
    
    [self.navigationController.view insertSubview:_backgroundView atIndex:1];
    [self.navigationController.view insertSubview:_containerView atIndex:2];
}

- (void)open {
    self.open = YES;

    [UIView animateWithDuration:_animationDuration / 2
                          delay:0.0
                        options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.menuView.alpha = 1.0;
                     } completion:nil];
    
    if (_bounce) {
        [UIView animateWithDuration:_animationDuration + _bounceAnimationDuration
                              delay:_animationDelayDuration
             usingSpringWithDamping:0.6
              initialSpringVelocity:4.0
                            options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             [self openMenu];
                         } completion:^(BOOL finished) {
                             if ([_delegate respondsToSelector:@selector(bananaDidOpen:)]) {
                                 [_delegate performSelector:@selector(bananaDidOpen:) withObject:self];
                             }
                         }];
    }
    else {
        [UIView animateWithDuration:_animationDuration
                              delay:_animationDelayDuration
                            options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             [self openMenu];
                         } completion:^(BOOL finished) {
                             if ([_delegate respondsToSelector:@selector(bananaDidOpen:)]) {
                                 [_delegate performSelector:@selector(bananaDidOpen:) withObject:self];
                             }
                         }];
    }
}

- (void)openMenu {
    CGRect frame = _containerView.frame;
    CGRect bounds = _containerView.bounds;
    CGRect buttonBounds = _toggleButton.frame;
    
    frame.origin.y += [self getMenuViewHeight] - [self getNavigationBarTotalHeight];
    bounds.size.height += _buttonOpenedOffset.height;
    buttonBounds.size.height += _buttonOpenedOffset.height;
    
    _backgroundView.alpha = _backgroundMaxAlpha;
    _containerView.frame = frame;
    _containerView.bounds = bounds;
    _toggleButton.frame = buttonBounds;
}

- (void)close {
    [UIView animateWithDuration:_animationDuration
                          delay:0.4
                        options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.menuView.alpha = 0.0;
                     } completion:nil];
    if (_bounce) {
        [UIView animateWithDuration:_animationDuration + _bounceAnimationDuration
                              delay:0.0
             usingSpringWithDamping:0.6
              initialSpringVelocity:4.0
                            options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             [self closeMenu];
                         } completion:^(BOOL finished) {
                             if ([_delegate respondsToSelector:@selector(bananaDidClose:)]) {
                                 [_delegate performSelector:@selector(bananaDidClose:) withObject:self];
                             }
                         }];
    }
    else {
        [UIView animateWithDuration:_animationDuration
                              delay:0.0
                            options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             [self closeMenu];
                         } completion:^(BOOL finished) {
                             if ([_delegate respondsToSelector:@selector(bananaDidClose:)]) {
                                 [_delegate performSelector:@selector(bananaDidClose:) withObject:self];
                             }
                         }];
    }
    self.open = NO;
}

- (void)closeMenu {
    CGRect frame = _containerView.frame;
    CGRect bounds = _containerView.bounds;
    CGRect buttonBounds = _toggleButton.frame;
    
    frame.origin.y -= [self getMenuViewHeight] - [self getNavigationBarTotalHeight];
    bounds.size.height -= _buttonOpenedOffset.height;
    buttonBounds.size.height -= _buttonOpenedOffset.height;

    _backgroundView.alpha = 0.0;
    _containerView.frame  = frame;
    _containerView.bounds = bounds;
    _toggleButton.frame = buttonBounds;
}

- (void)toggle {
    if (_open) {
        if ([_delegate respondsToSelector:@selector(bananaWillClose:)]) {
            [_delegate performSelector:@selector(bananaWillClose:) withObject:self];
        }
        [self close];
    }
    else {
        if ([_delegate respondsToSelector:@selector(bananaWillOpen:)]) {
            [_delegate performSelector:@selector(bananaWillOpen:) withObject:self];
        }
        [self open];
    }
}

#pragma mark - Utils

- (CGFloat)getNavigationBarTotalHeight {
    return _navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height;
}

- (CGFloat)getMenuViewHeight {
    CGFloat     totalHeight = [self getNavigationBarTotalHeight];
    
    for (BananaComponentView *componentView in _componentViews) {
        totalHeight += componentView.frame.size.height;
    }
    return totalHeight + (_componentViews.count * _separatorHeight);
}

@end
