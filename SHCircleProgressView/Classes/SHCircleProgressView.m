//
//  SHCircleProgressView.m
//  SHCircleProgressView
//
//  Created by ShengHuaWu on 2013/11/26.
//  Copyright (c) 2013年 ShengHuaWu. All rights reserved.
//

#import "SHCircleProgressView.h"

/**
 *  This string is an attribute, which you can apply to the user info in a timer.
 *  The value of this attribute is an NSNumber object containing an boolean.
 *  The value indicates whether the circle progress view repeats animating.
 */
static NSString *const SHCircleProgressViewRepeatAnimatingKey = @"SHCircleProgressViewRepeatAnimatingKey";

@interface SHCircleProgressView ()
@property (nonatomic, assign) CGFloat lastProgress;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, weak, readwrite) UILabel *titleLabel;
@end

@implementation SHCircleProgressView

- (void)setLastProgress:(CGFloat)lastProgress
{
    if (_lastProgress != lastProgress) {
        _lastProgress = lastProgress;
        [self setNeedsDisplay];
    }
}

- (void)setProgress:(CGFloat)progress
{
    if (_progress != progress) {
        _progress = progress;
        if (!self.timer) {
            self.timer = [NSTimer scheduledTimerWithTimeInterval:0.0625f target:self selector:@selector(updateLastProgress:) userInfo:@{SHCircleProgressViewRepeatAnimatingKey: [NSNumber numberWithBool:NO]} repeats:YES];
        }
    }
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _circleGap = 5.0f;
        _radius = 40.0f;
        _maskColor = [UIColor colorWithWhite:0.9f alpha:0.7f];
        _progressColor = [UIColor colorWithWhite:0.9f alpha:0.7f];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [UIColor lightGrayColor];
        titleLabel.font = [UIFont systemFontOfSize:14.0f];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLabel];
        _titleLabel = titleLabel;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.titleLabel sizeToFit];
    self.titleLabel.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds) + self.radius + 2.5f);
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    // Fill entire rect
    CGContextSetFillColorWithColor(context, self.maskColor.CGColor);
    CGContextFillRect(context, rect);
    // Clear the outside circle area
    CGRect circleFrame = CGRectInset(rect, CGRectGetWidth(rect) * 0.5f - self.radius, CGRectGetHeight(rect) * 0.5f - self.radius);
    circleFrame = CGRectOffset(circleFrame, 0.0f, -(CGRectGetHeight(self.titleLabel.frame) + 5.0f) * 0.5f); // Shift the circle frame
    if (CGRectIntersectsRect(circleFrame, rect)) {
        CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
        CGContextSetBlendMode(context, kCGBlendModeClear); // This is important
        CGContextFillEllipseInRect(context, circleFrame);
    }
    // Fill the inside progressing area, the measure of this area depends on the progress property
    if (self.progress < 1.0f) {
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, NULL, self.center.x, self.center.y - self.radius + self.circleGap - (CGRectGetHeight(self.titleLabel.frame) + 5.0f) * 0.5f);
        CGPathAddLineToPoint(path, NULL, self.center.x, self.center.y - (CGRectGetHeight(self.titleLabel.frame) + 5.0f) * 0.5f);
        /**
         *  The coordinate system of the path is the following:
         *
         *        3/2 pi
         *          |
         *  pi -----+----- 0(2 pi)
         *          |
         *        1/2 pi
         *
         */
        CGFloat startAngle = self.lastProgress * 2.0 * M_PI - M_PI_2; // Map the progress to the angle
        CGPathAddArc(path, NULL, self.center.x, self.center.y - (CGRectGetHeight(self.titleLabel.frame) + 5.0f) * 0.5f, self.radius - self.circleGap, startAngle, 3.0 * M_PI_2, NO);
        CGContextAddPath(context, path);
        CGContextClosePath(context);
        CGContextSetBlendMode(context, kCGBlendModeColor);
        CGContextSetFillColorWithColor(context, self.progressColor.CGColor);
        CGContextFillPath(context);
    }
    
    CGContextRestoreGState(context);
}

#pragma mark - Public method
- (void)startAnimating
{
    if (!self.timer) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.0625f target:self selector:@selector(updateLastProgress:) userInfo:@{SHCircleProgressViewRepeatAnimatingKey: [NSNumber numberWithBool:YES]} repeats:YES];
    }
}

- (void)stopAnimating
{
    [self.timer invalidate];
    self.timer = nil;
    
    [self removeFromSuperview];
}

#pragma mark - Timer selector
- (void)updateLastProgress:(NSTimer *)timer
{
    NSDictionary *userInfo = [timer userInfo];
    CGFloat maxProgress = [userInfo[SHCircleProgressViewRepeatAnimatingKey] boolValue] ? 1.0f : self.progress;
    if (self.lastProgress + 0.0125f < maxProgress) {
        self.lastProgress += 0.0125f;
    } else {
        if ([userInfo[SHCircleProgressViewRepeatAnimatingKey] boolValue]) {
            self.lastProgress = 0.0f;
        } else {
            self.lastProgress = self.progress;
            [self.timer invalidate];
            self.timer = nil;
        }
    }
}

@end
