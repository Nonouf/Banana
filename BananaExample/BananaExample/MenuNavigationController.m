//
//  MenuNavigationController.m
//  Banana
//
//  Created by Arnaud Schildknecht on 13/10/2015.
//  Copyright © 2015 Arnaud Schildknecht. All rights reserved.
//

#import "MenuNavigationController.h"
#import "ViewController.h"
#import "Banana.h"
#import "CustomView.h"
#import <IonIcons.h>
#import <VBFPopFlatButton.h>

@interface MenuNavigationController () <BananaDelegate>

@property (strong, nonatomic) Banana            *menu;
@property (strong, nonatomic) VBFPopFlatButton      *arrow;

@end

@implementation MenuNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initMenu];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initMenu {
    CustomView      *homeView = [[[NSBundle mainBundle] loadNibNamed:@"CustomView" owner:self options:nil] objectAtIndex:0];
    CustomView      *settingsView = [[[NSBundle mainBundle] loadNibNamed:@"CustomView" owner:self options:nil] objectAtIndex:0];
    CustomView      *bookingsView = [[[NSBundle mainBundle] loadNibNamed:@"CustomView" owner:self options:nil] objectAtIndex:0];
    CustomView      *flightsView = [[[NSBundle mainBundle] loadNibNamed:@"CustomView" owner:self options:nil] objectAtIndex:0];
    
    [homeView.title setText:@"Home"];
    [homeView.icon setImage:[IonIcons imageWithIcon:ion_home size:30.f color:[UIColor whiteColor]]];
    [settingsView.title setText:@"Settings"];
    [settingsView.icon setImage:[IonIcons imageWithIcon:ion_levels size:30.f color:[UIColor whiteColor]]];
    [bookingsView.title setText:@"Bookings"];
    [bookingsView.icon setImage:[IonIcons imageWithIcon:ion_earth size:30.f color:[UIColor whiteColor]]];
    [flightsView.title setText:@"Flights"];
    [flightsView.icon setImage:[IonIcons imageWithIcon:ion_plane size:30.f color:[UIColor whiteColor]]];
    
    __typeof (self) __weak weakSelf = self;
    
    BananaComponent *home = [[BananaComponent alloc] initWithCustomView:homeView andAction:^(BananaComponent *component) {
        UIViewController *homeViewController = [[ViewController alloc] init];
        
        homeViewController.navigationItem.title = @"Home";
        homeViewController.navigationItem.leftBarButtonItem = nil;

        [weakSelf setViewControllers:@[homeViewController] animated:NO];
    }];
    
    BananaComponent *settings = [[BananaComponent alloc] initWithCustomView:settingsView andAction:^(BananaComponent *component) {
        UIViewController *settingsViewController = [[ViewController alloc] init];
        
        settingsViewController.navigationItem.title = @"Settings";
        
        [weakSelf setViewControllers:@[settingsViewController] animated:NO];
    }];
    
    BananaComponent *bookings = [[BananaComponent alloc] initWithCustomView:bookingsView andAction:^(BananaComponent *component) {
        UIViewController *bookingsViewController = [[ViewController alloc] init];
        
        bookingsViewController.navigationItem.title = @"Bookings";
        
        [weakSelf setViewControllers:@[bookingsViewController] animated:NO];
    }];
    
    BananaComponent *flights = [[BananaComponent alloc] initWithCustomView:flightsView andAction:^(BananaComponent *component) {
        UIViewController *flightsViewController = [[ViewController alloc] init];
        
        flightsViewController.navigationItem.title = @"Flights";
        
        [weakSelf setViewControllers:@[flightsViewController] animated:NO];
    }];
    
    _menu = [[Banana alloc] initWithComponents:@[home, flights, bookings, settings] andNavigationController:self];
    
    UIButton    *toggleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat     toggleHeight = 45.0;
    CGFloat     arrowSize = 30.0;
    CGRect      arrowFrame = CGRectMake(0, toggleHeight / 2 - (arrowSize / 2), arrowSize, arrowSize);
    
    _arrow = [[VBFPopFlatButton alloc] initWithFrame:arrowFrame
                                          buttonType:buttonDownBasicType
                                         buttonStyle:buttonPlainStyle
                               animateToInitialState:NO];
    
    _arrow.lineThickness = 2.0;
    _arrow.alpha = 1.0;
    _arrow.tintColor = [UIColor whiteColor];
    _arrow.userInteractionEnabled = NO;
    
    [toggleButton setTitleColor:[UIColor clearColor] forState:UIControlStateHighlighted];
    [toggleButton setTitle:@"Open" forState:UIControlStateNormal];
    [toggleButton setBackgroundColor:[UIColor colorWithRed:65.0 / 255.0 green:121.0 / 255.0 blue:173.0 / 255.0 alpha:1.0]];
    
    toggleButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    toggleButton.titleEdgeInsets = UIEdgeInsetsMake(0, _arrow.frame.origin.x + _arrow.frame.size.width + 20.0, 0, 0);
    
    [toggleButton addSubview:_arrow];

    _arrow.translatesAutoresizingMaskIntoConstraints = NO;
    
    [toggleButton addConstraint:[NSLayoutConstraint constraintWithItem:_arrow
                                                             attribute:NSLayoutAttributeLeading
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:toggleButton
                                                             attribute:NSLayoutAttributeLeading
                                                            multiplier:1.0
                                                              constant:10.0]];
    [toggleButton addConstraint:[NSLayoutConstraint constraintWithItem:_arrow
                                                             attribute:NSLayoutAttributeCenterY
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:toggleButton
                                                             attribute:NSLayoutAttributeCenterY
                                                            multiplier:1.0
                                                              constant:0.0]];
    
    [_menu setButtonHeight:toggleHeight];
    [_menu setToggleButton:toggleButton];
    [_menu setDelegate:self];
    [_menu setButtonOpenedOffset:CGSizeMake(0, 10)];
    [_menu setBounce:NO];
    [_menu setAnimationDuration:0.5];
    [_menu prepare];
}

- (IBAction)toggleMenu:(id)sender {
    [_menu toggle];
}

#pragma MARK: BananaDelegate

- (void)bananaWillOpen:(Banana *)banana {
    [_arrow animateToType:buttonUpBasicType];
}

- (void)bananaDidOpen:(Banana *)banana {
}

- (void)bananaWillClose:(Banana *)banana {
    [_arrow animateToType:buttonDownBasicType];
}

- (void)bananaDidClose:(Banana *)banana {
}

@end
