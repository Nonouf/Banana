//
//  ViewController.m
//  BananaExample
//
//  Created by Arnaud Schildknecht on 13/10/2015.
//  Copyright © 2015 Arnaud Schildknecht. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor colorWithRed:245.0 / 255.0 green:245.0 / 255.0 blue:245.0 / 255.0 alpha:1.0];
    
    UILabel     *label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height / 2 - 25, self.view.frame.size.width, 50)];
    
    label.text = [NSString stringWithFormat:@"%@ViewController", self.navigationItem.title];
    label.font = [UIFont fontWithName:@"AvenirNext-Regular" size:25];
    label.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:label];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
