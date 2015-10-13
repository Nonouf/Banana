//
//  StrataMenuComponent.m
//  StrataMenu
//
//  Created by Arnaud Schildknecht on 12/10/2015.
//  Copyright © 2015 Arnaud Schildknecht. All rights reserved.
//

#import "BananaComponent.h"

@implementation BananaComponent

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        self.highlightedBackgroundColor = [UIColor lightGrayColor];
    }
    return self;
}

- (id)initWithCustomView:(UIView *)customView {
    self = [self init];
    
    if (self) {
        self.view = customView;
    }
    return self;
}

- (id)initWithCustomView:(UIView *)customView andAction:(void (^)(BananaComponent *))action {
    self = [self initWithCustomView:customView];
    
    if (self) {
        self.action = action;
    }
    return self;
}

@end
