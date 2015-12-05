//
//  TimespanSeries.h
//  InfoSeek
//
//  Created by Richmond Starbuck on 11/25/15.
//  Copyright © 2015 Dynamic Project Management Group. All rights reserved.
//

#import "Timespan.h"

#import <UIKit/UIKit.h>

@interface TimespanSeries : NSObject

@property (strong, nonatomic) NSArray *timespans;
@property (strong, nonatomic) UIColor *color;

- (instancetype)initWithTimespans:(NSArray *)timespans color:(UIColor *)color;

@end
