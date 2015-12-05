//
//  TimespanSeries.m
//  InfoSeek
//
//  Created by Richmond Starbuck on 11/25/15.
//  Copyright © 2015 Dynamic Project Management Group. All rights reserved.
//

#import "TimespanSeries.h"

@implementation TimespanSeries

- (instancetype)initWithTimespans:(NSArray *)timespans color:(UIColor *)color {
    if (self = [super init]) {
        _timespans = timespans;
        _color = color;
    }
    
    return self;
}

@end
