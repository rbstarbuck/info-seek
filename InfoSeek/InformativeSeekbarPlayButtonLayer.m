//
//  InformativeSeekbarPlayButtonLayer.m
//  InfoSeek
//
//  Created by Richmond Starbuck on 12/3/15.
//  Copyright © 2015 Dynamic Project Management Group. All rights reserved.
//

#import "InformativeSeekbarPlayButtonLayer.h"
#import "InformativeSeekbar.h"

#import <AVFoundation/AVFoundation.h>

@implementation InformativeSeekbarPlayButtonLayer

- (void)drawInContext:(CGContextRef)ctx {
    float buttonFrameInset =_parent.playButtonStrokeWidth / 2 + self.bounds.size.width * 0.05;
    CGRect buttonFrame = CGRectInset(self.bounds, buttonFrameInset, buttonFrameInset);
    
    // path
    UIBezierPath* buttonPath;
    
    BOOL isPlaying = 0 < (_parent.isSeeking ? _parent.previousRate : _parent.avPlayer.rate);
    if (isPlaying) {
        // pause button
        float barWidth = buttonFrame.size.width / 4.0f;
        float xMargin = barWidth / 2.0f;
        buttonPath = [UIBezierPath bezierPathWithRect:CGRectMake(buttonFrame.origin.x + xMargin, buttonFrame.origin.y, barWidth, buttonFrame.size.height)];
        [buttonPath appendPath:[UIBezierPath bezierPathWithRect:CGRectMake(CGRectGetMaxX(buttonFrame) - barWidth - xMargin, buttonFrame.origin.y, barWidth, buttonFrame.size.height)]];
    }
    else {
        // play button
        CGFloat radius = buttonFrame.size.height / 13.5f;
        
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, NULL, CGRectGetMinX(buttonFrame), CGRectGetMidY(buttonFrame));
        CGPathAddArcToPoint(path, NULL, CGRectGetMinX(buttonFrame), CGRectGetMidY(buttonFrame), CGRectGetMinX(buttonFrame), CGRectGetMinY(buttonFrame), radius);
        CGPathAddArcToPoint(path, NULL, CGRectGetMinX(buttonFrame), CGRectGetMinY(buttonFrame), CGRectGetMaxX(buttonFrame), CGRectGetMidY(buttonFrame), radius);
        CGPathAddArcToPoint(path, NULL, CGRectGetMaxX(buttonFrame), CGRectGetMidY(buttonFrame), CGRectGetMinX(buttonFrame), CGRectGetMaxY(buttonFrame), radius);
        CGPathAddArcToPoint(path, NULL, CGRectGetMinX(buttonFrame), CGRectGetMaxY(buttonFrame), CGRectGetMinX(buttonFrame), CGRectGetMidY(buttonFrame), radius);
        CGPathCloseSubpath(path);
        
        buttonPath = [UIBezierPath bezierPathWithCGPath:path];
        CGPathRelease(path);
    }
    
    // fill
    CGContextSetFillColorWithColor(ctx, _parent.playButtonFillColor.CGColor);
    CGContextAddPath(ctx, buttonPath.CGPath);
    CGContextFillPath(ctx);
    
    // outline
    CGContextSetStrokeColorWithColor(ctx, _parent.playButtonStrokeColor.CGColor);
    CGContextSetLineWidth(ctx, _parent.playButtonStrokeWidth);
    CGContextAddPath(ctx, buttonPath.CGPath);
    CGContextStrokePath(ctx);
}

@end
