//
//  StrataMenuComponentView.m
//  StrataMenu
//
//  Created by Arnaud Schildknecht on 12/10/2015.
//  Copyright © 2015 Arnaud Schildknecht. All rights reserved.
//

#import "BananaComponentView.h"

@interface BananaComponentView ()

@property (weak, nonatomic) Banana      *strataMenu;

@end

@implementation BananaComponentView

- (id)initWithFrame:(CGRect)frame andComponent:(BananaComponent *)component {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.component = component;
        
        [self addSubview:self.component.view];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame andComponent:(BananaComponent *)component andStrataMenu:(Banana *)strataMenu {
    self = [self initWithFrame:frame andComponent:component];
    
    if (self) {
        self.strataMenu = strataMenu;
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.backgroundColor = _component.highlightedBackgroundColor;
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.backgroundColor = [UIColor clearColor];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.backgroundColor = [UIColor clearColor];
    
    [_strataMenu toggle];
    _component.action(self.component);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
