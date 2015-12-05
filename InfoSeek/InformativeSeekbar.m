//
//  InformativeSeekbar.m
//  InfoSeek
//
//  Created by Richmond Starbuck on 11/20/15.
//  Copyright © 2015 Dynamic Project Management Group. All rights reserved.
//

#import "InformativeSeekbar.h"
#import "InformativeSeekbarPlayButtonLayer.h"
#import "InformativeSeekbarKnobLayer.h"
#import "InformativeSeekbarTrackLayer.h"
#import "TimespanSeries.h"

#import <AVFoundation/AVFoundation.h>
#import <QuartzCore/QuartzCore.h>

static const float SEEKBAR_REFRESH_HZ = 1.0f / 30.0f;

@implementation InformativeSeekbar {
    InformativeSeekbarPlayButtonLayer *_playButtonLayer;
    InformativeSeekbarTrackLayer *_trackLayer;
    InformativeSeekbarKnobLayer *_knobLayer;
    
    float _currentTimeInSeconds;
    float _durationInSeconds;
    
    float _knobWidth;
    float _useableTrackLength;
    
    CGPoint _previousTouchPoint;
    
    id _periodicTimeObserver;
}

#pragma mark Getters/setters

#define GENERATE_SETTER(PROPERTY, TYPE, SETTER, LAYER) \
- (void)SETTER:(TYPE)PROPERTY { \
    if (_##PROPERTY != PROPERTY) { \
        _##PROPERTY = PROPERTY; \
        [LAYER setNeedsDisplay]; \
    } \
}

GENERATE_SETTER(playButtonFillColor, UIColor*, setPlayButtonFillColor, _playButtonLayer)
GENERATE_SETTER(playButtonStrokeColor, UIColor*, setPlayButtonStrokeColor, _playButtonLayer)
GENERATE_SETTER(playButtonStrokeWidth, float, setPlayButtonStrokeWidth, _playButtonLayer)

GENERATE_SETTER(trackBackgroundColor, UIColor*, setTrackBackgroundColor, _trackLayer)
GENERATE_SETTER(trackInnerShadowColor, UIColor*, setTrackInnerShadowColor, _trackLayer)
GENERATE_SETTER(trackStrokeColor, UIColor*, setTrackStrokeColor, _trackLayer)
GENERATE_SETTER(trackStrokeWidth, float, setTrackStrokeWidth, _trackLayer)
GENERATE_SETTER(trackHighlightAlpha, float, setTrackHighlightAlpha, _trackLayer)
GENERATE_SETTER(trackHeight, float, setTrackHeight, self)
GENERATE_SETTER(trackCurvature, float, setTrackCurvature, _trackLayer)

GENERATE_SETTER(knobBackgroundColor, UIColor*, setKnobBackgroundColor, _knobLayer)
GENERATE_SETTER(knobInnerShadowColor, UIColor*, setKnobInnerShadowColor, _knobLayer)
GENERATE_SETTER(knobSelectedBackgroundColor, UIColor*, setKnobSelectedBackgroundColor, _knobLayer)
GENERATE_SETTER(knobSelectedInnerShadowColor, UIColor*, setKnobSelectedInnerShadowColor, _knobLayer)
GENERATE_SETTER(knobStrokeColor, UIColor*, setKnobStrokeColor, _knobLayer)
GENERATE_SETTER(knobHeightToWidthRatio, float, setKnobHeightToWidthRatio, self)
GENERATE_SETTER(knobStrokeWidth, float, setKnobStrokeWidth, _knobLayer)
GENERATE_SETTER(knobGradientShadowAlpha, float, setKnobGradientShadowAlpha, _knobLayer)
GENERATE_SETTER(knobCurvature, float, setKnobCurvature, _knobLayer)

#undef GENERATE_SETTER

- (void)setAvPlayer:(AVPlayer *)avPlayer {
    _avPlayer = avPlayer;
    _durationInSeconds = CMTimeGetSeconds(_avPlayer.currentItem.duration);
    
    [self addSelfAsObserver];
    
    NSLog(@"avPlayer added, duration = %g", _durationInSeconds);
}

#pragma mark Initialization

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initAll];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initAll];
    }
    
    return self;
}

- (void)initAll {
    _currentTimeInSeconds = 0.0f;
    _isSeeking = NO;
    
    [self applyDefaultStyle];
    
    _playButtonLayer = [InformativeSeekbarPlayButtonLayer layer];
    _playButtonLayer.parent = self;
    [self.layer addSublayer:_playButtonLayer];
    
    _trackLayer = [InformativeSeekbarTrackLayer layer];
    _trackLayer.parent = self;
    [self.layer addSublayer:_trackLayer];
    
    _knobLayer = [InformativeSeekbarKnobLayer layer];
    _knobLayer.parent = self;
    [self.layer addSublayer:_knobLayer];
}

- (void)dealloc {
    [self removeSelfAsObserver];
}

- (void)applyDefaultStyle {
    _marginTop = 10.0f;
    _marginBottom = 10.0f;
    _marginLeft = 20.0f;
    _marginRight = 20.0f;
    
    _playButtonFillColor = [UIColor colorWithWhite:0.25f alpha:1.0f];
    _playButtonStrokeColor = [UIColor blackColor];
    _playButtonStrokeWidth = 0.0f;
    
    _trackBackgroundColor = [UIColor colorWithWhite:0.85f alpha:1.0f];
    _trackInnerShadowColor = [UIColor grayColor];
    _trackStrokeColor = [UIColor blackColor];
    _trackStrokeWidth = 0.5f;
    _trackHighlightAlpha = 0.4f;
    _trackHeight = 0.65f;
    _trackCurvature = 1.0f;
    
    _knobBackgroundColor = [UIColor colorWithWhite:1.0f alpha:0.2f];
    _knobInnerShadowColor = [UIColor grayColor];
    _knobSelectedBackgroundColor = [UIColor yellowColor];
    _knobSelectedInnerShadowColor = [UIColor blueColor];
    _knobStrokeColor = [UIColor blackColor];
    _knobHeightToWidthRatio = 1.0f;
    _knobStrokeWidth = 0.5f;
    _knobGradientShadowAlpha = 0.2f;
    _knobCurvature = 1.0f;
}

- (void)addSelfAsObserver {
    [self removeSelfAsObserver];
    
    if (_avPlayer) {
        __weak typeof(self) weakSelf = self;
        _periodicTimeObserver =
        [_avPlayer addPeriodicTimeObserverForInterval:CMTimeMakeWithSeconds(SEEKBAR_REFRESH_HZ, NSEC_PER_SEC)
                                                queue:nil
                                           usingBlock:^(CMTime time) {
                                               [weakSelf playTimeChanged:CMTimeGetSeconds(time)];
                                           }];
        
        [_avPlayer addObserver:self forKeyPath:@"rate" options:0 context:nil];
        [_avPlayer.currentItem addObserver:self forKeyPath:@"duration" options:0 context:nil];
    }
}

- (void)removeSelfAsObserver {
    if (_periodicTimeObserver) {
        NSLog(@"Removing self as observer");
        
        [_avPlayer removeTimeObserver:_periodicTimeObserver];
        _periodicTimeObserver = nil;
        
        @try {
            [_avPlayer removeObserver:self forKeyPath:@"rate"];
        }
        @catch (NSException * __unused exception) {
            NSLog(@"Unexpected exception removing self from rate observer");
        }
        
        @try {
            [_avPlayer.currentItem removeObserver:self forKeyPath:@"duration"];
        }
        @catch (NSException * __unused exception) {
            NSLog(@"Unexpected exception removing self from duration observer");
        }
    }
}

# pragma mark Layout

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setLayerFrames];
}

- (void)setNeedsDisplay {
    [super setNeedsDisplay];
    [self setLayerFrames];
}

- (void)setLayerFrames {
    float marginVertical = _marginTop + _marginBottom;
    float marginHorizontal = _marginLeft + _marginRight;
    
    float playButtonSize = self.bounds.size.height - marginVertical;
    float playButtonSizeWithPadding = playButtonSize * 1.5f;
    float trackLayerInset = (self.bounds.size.height - marginVertical) * (1.0f - _trackHeight);
    
    _playButtonLayer.frame = CGRectMake(self.bounds.origin.x + _marginLeft, self.bounds.origin.y + _marginTop, playButtonSize, playButtonSize);
    [_playButtonLayer setNeedsDisplay];
    
    _trackLayer.frame = CGRectMake(playButtonSizeWithPadding + _marginLeft, trackLayerInset / 2.0f + _marginTop, self.bounds.size.width - playButtonSizeWithPadding - marginHorizontal, self.bounds.size.height - trackLayerInset - marginVertical);
    [_trackLayer setNeedsDisplay];
    
    _knobWidth = (self.bounds.size.height - marginVertical) * _knobHeightToWidthRatio;
    _useableTrackLength = _trackLayer.bounds.size.width - _knobWidth;
    
    float knobPosition = _trackLayer.frame.origin.x + (_durationInSeconds > 0 ? _useableTrackLength * (_currentTimeInSeconds / _durationInSeconds) : 0.0f);
    _knobLayer.frame = CGRectMake(knobPosition, _marginTop, _knobWidth, self.bounds.size.height - marginVertical);
    [_knobLayer setNeedsDisplay];
}

- (float)trackbarPositionFromTime:(CMTime)time {
    return [self trackbarPositionFromSeconds:CMTimeGetSeconds(time)];
}

- (float)trackbarPositionFromSeconds:(float)seconds {
    return (_knobWidth / 2) + (_durationInSeconds > 0 ? _useableTrackLength * (seconds / _durationInSeconds) : 0.0f);
}

#pragma mark Playback control

- (void)seekToTime:(CMTime)time {
    [_avPlayer seekToTime:time
          toleranceBefore:kCMTimeZero
           toleranceAfter:kCMTimeZero];
}

- (void)seekToTimespan:(Timespan *)timespan {
    [self seekToTime:timespan.startTime];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"rate"]) {
        NSLog(@"Observed: rate = %g", _avPlayer.rate);
        if (!_knobLayer.isSelected) {
            [_playButtonLayer setNeedsDisplay];
        }
    }
    else if ([keyPath isEqualToString:@"duration"]) {
        _durationInSeconds = CMTimeGetSeconds(_avPlayer.currentItem.duration);
        [_trackLayer setNeedsDisplay];
        
        NSLog(@"Observed: duration = %g", _durationInSeconds);
    }
}

- (void)playTimeChanged:(float)seconds {
    _currentTimeInSeconds = seconds;
    [self updateSeekbarPosition];
}

- (void)updateSeekbarPosition {
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    
    [self setLayerFrames];
    
    [CATransaction commit];
}

- (void)suspendPlay {
    _isSeeking = YES;
    _previousRate = _avPlayer.rate;
    _avPlayer.rate = 0.0f;
}

- (void)resumePlay {
    _isSeeking = NO;
    _avPlayer.rate = _previousRate;
}

#pragma mark Touch tracking

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    _previousTouchPoint = [touch locationInView:self];
    
    if (CGRectContainsPoint(_knobLayer.frame, _previousTouchPoint)) {
        [self suspendPlay];
        _knobLayer.isSelected = YES;
        [_knobLayer setNeedsDisplay];
        return YES;
    }
    else if (CGRectContainsPoint(_playButtonLayer.frame, _previousTouchPoint)) {
        if (_avPlayer.rate) {
            _avPlayer.rate = 0;
        }
        else {
            _avPlayer.rate = 1;
        }
    }
    
    return NO;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchPoint = [touch locationInView:self];
    
    float delta = touchPoint.x - _previousTouchPoint.x;\
    _currentTimeInSeconds += delta * _durationInSeconds / _useableTrackLength;
    
    if (_currentTimeInSeconds < 0.0) {
        _currentTimeInSeconds = 0.0;
    }
    else if (_currentTimeInSeconds > _durationInSeconds) {
        _currentTimeInSeconds = _durationInSeconds;
    }
    else {
        _previousTouchPoint = touchPoint;
    }
    
    [self updateSeekbarPosition];
    [self seekToTime:CMTimeMakeWithSeconds(_currentTimeInSeconds, NSEC_PER_SEC)];
    
    return YES;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    _knobLayer.isSelected = NO;
    [self resumePlay];
    [_knobLayer setNeedsDisplay];
}

@end
