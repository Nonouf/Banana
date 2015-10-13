//
//  StrataMenuComponentView.h
//  StrataMenu
//
//  Created by Arnaud Schildknecht on 12/10/2015.
//  Copyright © 2015 Arnaud Schildknecht. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BananaComponent.h"
#import "Banana.h"

@interface BananaComponentView : UIView

@property (strong, nonatomic) BananaComponent   *component;

/**
 *  Initialize a StrataMenuComponentView
 *
 *  @param frame     The frame of the view
 *  @param component The StrataMenuComponent linked to the view
 *
 *  @return An initialized instance of StrataMenuComponentView.
 */
- (id)initWithFrame:(CGRect)frame andComponent:(BananaComponent*)component;

/**
 *  Initialize a StrataMenuComponentView
 *
 *  @param frame      The frame of the view
 *  @param component  The StrataMenuComponent linked to the view
 *  @param strataMenu The StrataMenu that own the view
 *
 *  @return An initialized instance of StrataMenuComponentView.
 */
- (id)initWithFrame:(CGRect)frame andComponent:(BananaComponent*)component andStrataMenu:(Banana*)strataMenu;

@end
