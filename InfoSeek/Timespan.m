//
//  Timespan.m
//  InfoSeek
//
//  Created by Richmond Starbuck on 11/25/15.
//  Copyright © 2015 Dynamic Project Management Group. All rights reserved.
//

#import "Timespan.h"

@interface Timespan ()

@property (nonatomic, readwrite) CMTime startTime;
@property (nonatomic, readwrite) CMTime endTime;

@end

@implementation Timespan

- (instancetype)init {
    if (self = [super init]) {
        _startTime = kCMTimeInvalid;
        _endTime = kCMTimeInvalid;
    }
    
    return self;
}

- (instancetype)initFromTime:(CMTime)startTime toTime:(CMTime)endTime {
    if (self = [super init]) {
        _startTime = startTime;
        _endTime = endTime;
    }
    
    return self;
}

+ (instancetype)makeFromTime:(CMTime)startTime toTime:(CMTime)endTime {
    return [[self alloc] initFromTime:startTime toTime:endTime];
}

+ (instancetype)makeFromSecond:(float)startSecond toSecond:(float)endSecond {
    return [[self alloc] initFromTime:CMTimeMakeWithSeconds(startSecond, NSEC_PER_SEC)
                               toTime:CMTimeMakeWithSeconds(endSecond, NSEC_PER_SEC)];
}


@end
