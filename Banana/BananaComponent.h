//
//  BananaComponent.h
//  Banana
//
//  Created by Arnaud Schildknecht on 12/10/2015.
//  Copyright © 2015 Arnaud Schildknecht. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BananaComponent : NSObject

@property (strong, nonatomic) UIView    *view;

@property (copy, nonatomic) void        (^action)(BananaComponent *component);

// Customization
@property (strong, nonatomic) UIColor       *highlightedBackgroundColor;

/**
 *  Init a StratMenuComponent instance with a custom view.
 *
 *  @param customView The custom view shown by the component.
 *
 *  @return An initialized instance of BananaComponent.
 */
- (id)initWithCustomView:(UIView*)customView;

/**
 *  Init a StratMenuComponent instance with a custom view and a action.
 *
 *  @param customView The custom view shown by the component.
 *  @param action     The callback when the user hit the view.
 *
 *  @return An initialized instance of BananaComponent.
 */
- (id)initWithCustomView:(UIView *)customView andAction:(void (^)(BananaComponent *component))action;

@end
