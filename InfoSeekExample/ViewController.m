//
//  ViewController.m
//  InfoSeek
//
//  Created by Richmond Starbuck on 11/20/15.
//  Copyright © 2015 Dynamic Project Management Group. All rights reserved.
//

#import "ViewController.h"
#import "TimespanSeries.h"

#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *videoUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"SampleVideo"
                                                                             ofType:@"mp4"]];
    self.avPlayerViewController = [[AVPlayerViewController alloc] init];
    self.avPlayerViewController.player = [AVPlayer playerWithURL:videoUrl];
    self.avPlayerViewController.view.frame = self.avPlayerViewContainer.bounds;
    self.avPlayerViewController.showsPlaybackControls = NO;
    [self.avPlayerViewContainer addSubview:self.avPlayerViewController.view];
    
    self.informativeSeekbar.avPlayer = self.avPlayerViewController.player;
    
    NSArray *timespans1 = [[NSArray alloc] initWithObjects:
                           [Timespan makeFromSecond:0.0f toSecond:1.5f],
                           [Timespan makeFromSecond:6.1f toSecond:4.0f],
                           [Timespan makeFromSecond:10.0f toSecond:12.5f],
                           nil];
    
    TimespanSeries *series1 = [[TimespanSeries alloc] initWithTimespans:timespans1 color:[UIColor orangeColor]];
    
    NSArray *timespans2 = [[NSArray alloc] initWithObjects:
                           [Timespan makeFromSecond:7.0f toSecond:8.2f],
                           [Timespan makeFromSecond:14.0f toSecond:14.5f],
                           nil];
    
    TimespanSeries *series2 = [[TimespanSeries alloc] initWithTimespans:timespans2 color:[UIColor colorWithRed:0.0f green:0.9f blue:0.0f alpha:1.0f]];
    
    self.informativeSeekbar.timespanSeries = [[NSArray alloc] initWithObjects:
                                         series1,
                                         series2,
                                         nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)applyStyle1:(id)sender {
    self.informativeSeekbar.backgroundColor = [UIColor clearColor];
    
    self.informativeSeekbar.playButtonFillColor = [UIColor colorWithWhite:0.25f alpha:1.0f];
    self.informativeSeekbar.playButtonStrokeColor = [UIColor blackColor];
    self.informativeSeekbar.playButtonStrokeWidth = 0.0f;
    
    self.informativeSeekbar.trackBackgroundColor = [UIColor colorWithWhite:0.85f alpha:1.0f];
    self.informativeSeekbar.trackInnerShadowColor = [UIColor grayColor];
    self.informativeSeekbar.trackStrokeColor = [UIColor blackColor];
    self.informativeSeekbar.trackStrokeWidth = 0.5f;
    self.informativeSeekbar.trackHighlightAlpha = 0.4f;
    self.informativeSeekbar.trackHeight = 0.65f;
    self.informativeSeekbar.trackCurvature = 1.0f;
    
    self.informativeSeekbar.knobBackgroundColor = [UIColor colorWithWhite:1.0f alpha:0.2f];
    self.informativeSeekbar.knobInnerShadowColor = [UIColor grayColor];
    self.informativeSeekbar.knobSelectedBackgroundColor = [UIColor yellowColor];
    self.informativeSeekbar.knobSelectedInnerShadowColor = [UIColor blueColor];
    self.informativeSeekbar.knobStrokeColor = [UIColor blackColor];
    self.informativeSeekbar.knobHeightToWidthRatio = 1.0f;
    self.informativeSeekbar.knobStrokeWidth = 0.5f;
    self.informativeSeekbar.knobGradientShadowAlpha = 0.2f;
    self.informativeSeekbar.knobCurvature = 1.0f;
}

- (IBAction)applyStyle2:(id)sender {
    UIColor *darkGray = [UIColor colorWithWhite:0.2f alpha:1.0f];
    UIColor *lightGray = [UIColor colorWithWhite:0.95f alpha:1.0f];
    
    self.informativeSeekbar.backgroundColor = [UIColor clearColor];
    
    self.informativeSeekbar.playButtonFillColor = lightGray;
    self.informativeSeekbar.playButtonStrokeColor = darkGray;
    self.informativeSeekbar.playButtonStrokeWidth = 1.5f;
    
    self.informativeSeekbar.trackBackgroundColor = lightGray;;
    self.informativeSeekbar.trackInnerShadowColor = [UIColor clearColor];
    self.informativeSeekbar.trackStrokeColor = darkGray;
    self.informativeSeekbar.trackStrokeWidth = 2.0f;
    self.informativeSeekbar.trackHighlightAlpha = 0.0f;
    self.informativeSeekbar.trackHeight = 0.5f;
    self.informativeSeekbar.trackCurvature = 0.0f;
    
    self.informativeSeekbar.knobBackgroundColor = [UIColor colorWithWhite:0.65f alpha:0.0f];
    self.informativeSeekbar.knobInnerShadowColor = [UIColor clearColor];
    self.informativeSeekbar.knobSelectedBackgroundColor = [UIColor redColor];
    self.informativeSeekbar.knobSelectedInnerShadowColor = [UIColor clearColor];
    self.informativeSeekbar.knobStrokeColor = darkGray;
    self.informativeSeekbar.knobHeightToWidthRatio = 0.8f;
    self.informativeSeekbar.knobStrokeWidth = 1.0f;
    self.informativeSeekbar.knobGradientShadowAlpha = 0.2f;
    self.informativeSeekbar.knobCurvature = 0.2f;
}

- (IBAction)applyStyle3:(id)sender {
    self.informativeSeekbar.backgroundColor = [UIColor colorWithWhite:0.3f alpha:1.0f];
    
    self.informativeSeekbar.playButtonFillColor = [UIColor redColor];
    self.informativeSeekbar.playButtonStrokeColor = [UIColor whiteColor];
    self.informativeSeekbar.playButtonStrokeWidth = 1.5f;
    
    self.informativeSeekbar.trackBackgroundColor = [UIColor colorWithWhite:0.55f alpha:1.0f];
    self.informativeSeekbar.trackInnerShadowColor = [UIColor grayColor];
    self.informativeSeekbar.trackStrokeColor = [UIColor whiteColor];
    self.informativeSeekbar.trackStrokeWidth = 3.5f;
    self.informativeSeekbar.trackHighlightAlpha = 0.2f;
    self.informativeSeekbar.trackHeight = 1.0f;
    self.informativeSeekbar.trackCurvature = 0.35f;
    
    self.informativeSeekbar.knobBackgroundColor = [UIColor colorWithWhite:1.0f alpha:0.4f];
    self.informativeSeekbar.knobInnerShadowColor = [UIColor clearColor];
    self.informativeSeekbar.knobSelectedBackgroundColor = [UIColor colorWithWhite:1.0f alpha:0.7f];
    self.informativeSeekbar.knobSelectedInnerShadowColor = [UIColor clearColor];
    self.informativeSeekbar.knobStrokeColor = [UIColor whiteColor];
    self.informativeSeekbar.knobHeightToWidthRatio = 0.9f;
    self.informativeSeekbar.knobStrokeWidth = 1.0f;
    self.informativeSeekbar.knobGradientShadowAlpha = 0.2f;
    self.informativeSeekbar.knobCurvature = 0.35f;
}

@end
