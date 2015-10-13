//
//  Banana.h
//  Banana
//
//  Created by Arnaud Schildknecht on 12/10/2015.
//  Copyright © 2015 Arnaud Schildknecht. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BananaComponent.h"

@class Banana;

@protocol BananaDelegate <NSObject>

@optional
- (void)bananaWillOpen:(Banana*)banana;
- (void)bananaDidOpen:(Banana*)banana;
- (void)bananaWillClose:(Banana*)banana;
- (void)bananaDidClose:(Banana*)banana;

@end

@interface Banana : NSObject

@property (nonatomic, weak) id<BananaDelegate>    delegate;

@property (nonatomic, readonly, getter=isOpen) BOOL        open;

@property (strong, nonatomic) NSArray           *menuComponents;
@property (strong, nonatomic) UIView            *backgroundView;
@property (strong, nonatomic) UIButton          *toggleButton;

// Separator
@property (nonatomic) CGFloat               separatorHeight;
@property (nonatomic) UIEdgeInsets          separatorOffset;

// Button
@property (nonatomic) BOOL                                  hasToggleButton;
@property (nonatomic) BOOL                                  hasBottomShadow;
@property (nonatomic) CGFloat                               buttonHeight;
@property (strong, nonatomic) NSString                      *buttonTitle;
@property (strong, nonatomic) UIFont                        *buttonTitleFont;
@property (nonatomic) UIControlContentHorizontalAlignment   titleAlignment;
@property (nonatomic) UIEdgeInsets                          titleEdgeInsets;
@property (nonatomic) CGSize                                buttonOpenedOffset;

// Animation Options
@property (nonatomic) NSTimeInterval        animationDuration;
@property (nonatomic) NSTimeInterval        animationDelayDuration;
@property (nonatomic) NSTimeInterval        bounceAnimationDuration;
@property (nonatomic) CGFloat               backgroundMaxAlpha;
@property (nonatomic) BOOL                  bounce;

// Color
@property (strong, nonatomic) UIColor       *backgroundColor;
@property (strong, nonatomic) UIColor       *menuBackgroundColor;
@property (strong, nonatomic) UIColor       *buttonBackgroundColor;
@property (strong, nonatomic) UIColor       *separatorColor;
@property (strong, nonatomic) UIColor       *highlightedButtonBackgroundColor;
@property (strong, nonatomic) UIColor       *highlightedButtonTextColor;

/**
 *  Initialize a Banana object that will contain and manage the menu.
 *
 *  @param components           An array of BananaComponent, which are the different items display in the menu.
 *  @param navigationController The navigation controller that own the menu.
 *
 *  @return An initialized Banana instance with the given components.
 */
- (id)initWithComponents:(NSArray*)components andNavigationController:(UINavigationController*)navigationController;

/**
 *  Initialize the menu by adding all the components and settings the menu's frame.
 */
- (void)prepare;

/**
 *  Open or close the menu. If the menu is opened it will close it. If the menu is closed it will open it.
 */
- (void)toggle;

@end
