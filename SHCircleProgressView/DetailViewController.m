//
//  DetailViewController.m
//  SHCircleProgressView
//
//  Created by ShengHuaWu on 2013/11/30.
//  Copyright (c) 2013年 ShengHuaWu. All rights reserved.
//

#import "DetailViewController.h"
#import "SHCircleProgressView.h"

@interface DetailViewController ()
@property (nonatomic, weak) SHCircleProgressView *circleProgressView;
@end

@implementation DetailViewController

#pragma mark - View life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"Progress" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonWasPressed:) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    button.center = self.view.center;
    [self.view addSubview:button];
}

#pragma mark - Button action
- (void)buttonWasPressed:(UIButton *)sender
{
    SHCircleProgressView *circleProgressView = [[SHCircleProgressView alloc] initWithFrame:self.view.bounds];
    circleProgressView.titleLabel.text = @"Loading ...";
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [circleProgressView addGestureRecognizer:tap];
    [self.view addSubview:circleProgressView];
    self.circleProgressView = circleProgressView;
    
    [self.circleProgressView startAnimating];
}

#pragma mark - Gesture handler
- (void)tap:(UITapGestureRecognizer *)gesture
{
    [self.circleProgressView stopAnimating];
//    if (self.circleProgressView.progress + 0.1f <= 1.0f) {
//        self.circleProgressView.progress += 0.1f;
//    } else {
//        self.circleProgressView.progress = 1.0f;
//    }
}

@end
