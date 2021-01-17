//
//  GradientButton.m
//  wink
//
//  Created by 王斌 on 2019/8/8.
//  Copyright © 2019 王斌. All rights reserved.
//

#import "GradientButton.h"
//#import <EDColor/EDColor.h>

@implementation GradientButton

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    _gradientStartColor = [UIColor redColor];
    _gradientEndColor = [UIColor greenColor];
    if (self.enabled == NO) {
         _gradientStartColor = [UIColor redColor];
         _gradientEndColor = [UIColor greenColor];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    _gradientStartColor = [UIColor redColor];
    _gradientEndColor = [UIColor greenColor];
    if (self.enabled == NO) {
         _gradientStartColor = [UIColor redColor];
         _gradientEndColor = [UIColor greenColor];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();

    
    CGPoint start = CGPointMake(0, 0);
    CGPoint end = CGPointMake(rect.size.width, 0);

    NSArray *gradientColors = @[(id) self.gradientStartColor.CGColor, (id) self.gradientEndColor.CGColor];
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) gradientColors, NULL);
    CGColorSpaceRelease(colorSpace);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:self.bounds.size.height / 2];
    CGContextSaveGState(context);
    [path addClip];
    CGContextDrawLinearGradient(context, gradient, start, end, 0);
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
}

@end
