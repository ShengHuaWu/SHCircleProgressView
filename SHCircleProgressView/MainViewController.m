//
//  MainViewController.m
//  SHCircleProgressView
//
//  Created by ShengHuaWu on 2013/11/26.
//  Copyright (c) 2013年 ShengHuaWu. All rights reserved.
//

#import "MainViewController.h"
#import "DetailViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

#pragma mark - View life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"Detail" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonWasPressed:) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    button.center = self.view.center;
    [self.view addSubview:button];
}

#pragma mark - Button action
- (void)buttonWasPressed:(UIButton *)sender
{
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    [self presentViewController:detailVC animated:YES completion:nil];
}

@end
