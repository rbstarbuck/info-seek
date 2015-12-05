//
//  InformativeSeekbar.h
//  InfoSeek
//
//  Created by Richmond Starbuck on 11/20/15.
//  Copyright © 2015 Dynamic Project Management Group. All rights reserved.
//

#import <CoreMedia/CoreMedia.h>
#import <UIKit/UIKit.h>

@class AVPlayer;
@class Timespan;

@interface InformativeSeekbar : UIControl

@property (strong, nonatomic) AVPlayer *avPlayer;
@property (strong, nonatomic) NSArray *timespanSeries;

@property (nonatomic) BOOL isSeeking;
@property (nonatomic) float previousRate;

@property (nonatomic) float marginTop;
@property (nonatomic) float marginBottom;
@property (nonatomic) float marginLeft;
@property (nonatomic) float marginRight;

@property (strong, nonatomic) UIColor *playButtonFillColor;
@property (strong, nonatomic) UIColor *playButtonStrokeColor;
@property (nonatomic) float playButtonStrokeWidth;

@property (strong, nonatomic) UIColor *trackBackgroundColor;
@property (strong, nonatomic) UIColor *trackInnerShadowColor;
@property (strong, nonatomic) UIColor *trackStrokeColor;
@property (nonatomic) float trackStrokeWidth;
@property (nonatomic) float trackHighlightAlpha;
@property (nonatomic) float trackCurvature;
@property (nonatomic) float trackHeight;

@property (strong, nonatomic) UIColor *knobBackgroundColor;
@property (strong, nonatomic) UIColor *knobInnerShadowColor;
@property (strong, nonatomic) UIColor *knobSelectedBackgroundColor;
@property (strong, nonatomic) UIColor *knobSelectedInnerShadowColor;
@property (strong, nonatomic) UIColor *knobStrokeColor;
@property (nonatomic) float knobHeightToWidthRatio;
@property (nonatomic) float knobStrokeWidth;
@property (nonatomic) float knobGradientShadowAlpha;
@property (nonatomic) float knobSelectionHighlightAlpha;
@property (nonatomic) float knobCurvature;

- (void)applyDefaultStyle;

- (void)seekToTimespan:(Timespan *)timespan;
- (void)seekToTime:(CMTime)time;

- (float)trackbarPositionFromTime:(CMTime)time;
- (float)trackbarPositionFromSeconds:(float)seconds;

@end
