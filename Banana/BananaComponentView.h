//
//  BananaComponentView.h
//  Banana
//
//  Created by Arnaud Schildknecht on 12/10/2015.
//  Copyright © 2015 Arnaud Schildknecht. All rights reserved.
//

#import "BananaComponent.h"
#import "Banana.h"

@interface BananaComponentView : UIView

@property (strong, nonatomic) BananaComponent   *component;

/**
 *  Initialize a BananaComponentView
 *
 *  @param frame     The frame of the view
 *  @param component The BananaComponent linked to the view
 *
 *  @return An initialized instance of BananaComponentView.
 */
- (id)initWithFrame:(CGRect)frame andComponent:(BananaComponent*)component;

/**
 *  Initialize a BananaComponentView
 *
 *  @param frame      The frame of the view
 *  @param component  The BananaComponent linked to the view
 *  @param banana     The Banana that own the view
 *
 *  @return An initialized instance of BananaComponentView.
 */
- (id)initWithFrame:(CGRect)frame andComponent:(BananaComponent*)component andBanana:(Banana*)banana;

@end
