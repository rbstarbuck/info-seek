//
//  InformativeSeekbarKnobLayer.m
//  InfoSeek
//
//  Created by Richmond Starbuck on 11/20/15.
//  Copyright © 2015 Dynamic Project Management Group. All rights reserved.
//

#import "InformativeSeekbarKnobLayer.h"
#import "InformativeSeekbar.h"

@implementation InformativeSeekbarKnobLayer

- (void)drawInContext:(CGContextRef)ctx {
    float knobFrameInset =_parent.knobStrokeWidth / 2 + 2;
    CGRect knobFrame = CGRectInset(self.bounds, knobFrameInset, knobFrameInset);
    
    
    UIBezierPath *knobPath = [UIBezierPath bezierPathWithRoundedRect:knobFrame
                                                        cornerRadius:knobFrame.size.height * _parent.knobCurvature / 2.0];
    
    // fill
    if (self.isSelected) {
        CGContextSetShadowWithColor(ctx, CGSizeMake(0, 1), 1.0, _parent.knobSelectedInnerShadowColor.CGColor);
        CGContextSetFillColorWithColor(ctx, _parent.knobSelectedBackgroundColor.CGColor);
    }
    else {
        CGContextSetShadowWithColor(ctx, CGSizeMake(0, 1), 1.0, _parent.knobInnerShadowColor.CGColor);
        CGContextSetFillColorWithColor(ctx, _parent.knobBackgroundColor.CGColor);
    }
    CGContextAddPath(ctx, knobPath.CGPath);
    CGContextFillPath(ctx);
    
    // outline
    CGContextSetStrokeColorWithColor(ctx, _parent.knobStrokeColor.CGColor);
    CGContextSetLineWidth(ctx, _parent.knobStrokeWidth);
    CGContextAddPath(ctx, knobPath.CGPath);
    CGContextStrokePath(ctx);
    
    // inner gradient
    CGRect rect = CGRectInset(knobFrame, 2.0, 2.0);
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithRoundedRect:rect
                                                        cornerRadius:rect.size.height * _parent.knobCurvature / 2.0];
    CGGradientRef myGradient;
    CGColorSpaceRef myColorspace;
    size_t num_locations = 2;
    CGFloat locations[2] = { 0.0, 1.0 };
    CGFloat components[8] = { 0.0, 0.0, 0.0 , _parent.knobGradientShadowAlpha,  // Start color
        0.0, 0.0, 0.0, 0.05 }; // End color
    
    myColorspace = CGColorSpaceCreateDeviceRGB();
    myGradient = CGGradientCreateWithColorComponents (myColorspace, components,
                                                      locations, num_locations);
    
    CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
    
    CGContextSaveGState(ctx);
    CGContextAddPath(ctx, clipPath	.CGPath);
    CGContextClip(ctx);
    CGContextDrawLinearGradient(ctx, myGradient, startPoint, endPoint, 0);
    
    CGGradientRelease(myGradient);
    CGColorSpaceRelease(myColorspace);
    CGContextRestoreGState(ctx);
}

@end
