//
//  SHCircleProgressView.h
//  SHCircleProgressView
//
//  Created by ShengHuaWu on 2013/11/26.
//  Copyright (c) 2013年 ShengHuaWu. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  This class is used to display a mask view and a circle progress view inside the mask view.
 *  The circle progress view consists of an clear outside circle and an inside progressing area.
 */

@interface SHCircleProgressView : UIView
@property (nonatomic, assign) CGFloat progress; // This property is between 0.0 and 1.0.
@property (nonatomic, assign) CGFloat radius; // The radius of the outside circle
@property (nonatomic, assign) CGFloat circleGap; // The gap between the ouside cirlce and the inside progressing area
@property (nonatomic, strong) UIColor *maskColor; // The color of the mask view
@property (nonatomic, strong) UIColor *progressColor; // The color of the inside progressing area

@property (nonatomic, weak, readonly) UILabel *titleLabel;

- (void)startAnimating;
- (void)stopAnimating;
@end
