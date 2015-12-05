//
//  InformativeSeekbarTrackLayer.m
//  InfoSeek
//
//  Created by Richmond Starbuck on 11/22/15.
//  Copyright © 2015 Dynamic Project Management Group. All rights reserved.
//

#import "InformativeSeekbarTrackLayer.h"
#import "InformativeSeekbar.h"
#import "TimespanSeries.h"

@implementation InformativeSeekbarTrackLayer

- (void)drawInContext:(CGContextRef)ctx {
    // clip
    float cornerRadius = self.bounds.size.height * _parent.trackCurvature / 2.0f;
    float halfStrokeWidth = _parent.trackStrokeWidth / 2.0f;
    CGRect trackFrame = CGRectInset(self.bounds, halfStrokeWidth, halfStrokeWidth);
    
    UIBezierPath *switchOutline = [UIBezierPath bezierPathWithRoundedRect:trackFrame
                                                             cornerRadius:cornerRadius];
    CGContextAddPath(ctx, switchOutline.CGPath);
    CGContextClip(ctx);
    
    // fill
    CGContextSetFillColorWithColor(ctx, _parent.trackBackgroundColor.CGColor);
    CGContextAddPath(ctx, switchOutline.CGPath);
    CGContextFillPath(ctx);
    
    // highlight
    CGRect highlight = CGRectMake(cornerRadius / 2.0f, self.bounds.size.height / 2.0f,
                                  self.bounds.size.width - cornerRadius, self.bounds.size.height / 2.0f);
    UIBezierPath *highlightPath = [UIBezierPath bezierPathWithRoundedRect:highlight
                                                             cornerRadius:highlight.size.height * _parent.trackCurvature / 2.0f];
    CGContextAddPath(ctx, highlightPath.CGPath);
    CGColorRef highlightColor =[UIColor colorWithWhite:1.0 alpha:_parent.trackHighlightAlpha].CGColor;
    CGContextSetFillColorWithColor(ctx, highlightColor);
    CGContextFillPath(ctx);
    
    // timespans
    for (TimespanSeries *series in _parent.timespanSeries) {
        for (Timespan *timespan in series.timespans) {
            float left = [_parent trackbarPositionFromTime:timespan.startTime];
            float right = [_parent trackbarPositionFromTime:timespan.endTime];
            CGContextSetFillColorWithColor(ctx, series.color.CGColor);
            CGContextFillRect(ctx, CGRectMake(left, 0, right - left, self.bounds.size.height));
        }
    }
    
    // inner shadow
    CGContextSetShadowWithColor(ctx, CGSizeMake(0, 2.0), 3.0, _parent.trackInnerShadowColor.CGColor);
    CGContextAddPath(ctx, switchOutline.CGPath);
    CGContextSetStrokeColorWithColor(ctx, _parent.trackInnerShadowColor.CGColor);
    CGContextStrokePath(ctx);
    
    // outline
    CGContextAddPath(ctx, switchOutline.CGPath);
    CGContextSetStrokeColorWithColor(ctx, _parent.trackStrokeColor.CGColor);
    CGContextSetLineWidth(ctx, _parent.trackStrokeWidth);
    CGContextStrokePath(ctx);
}

@end
