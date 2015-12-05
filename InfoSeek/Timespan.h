//
//  Timespan.h
//  InfoSeek
//
//  Created by Richmond Starbuck on 11/25/15.
//  Copyright © 2015 Dynamic Project Management Group. All rights reserved.
//

#import <CoreMedia/CoreMedia.h>

@interface Timespan : NSObject

@property (nonatomic, readonly) CMTime startTime;
@property (nonatomic, readonly) CMTime endTime;

- (instancetype)initFromTime:(CMTime)startTime toTime:(CMTime)endTime;

+ (instancetype)makeFromTime:(CMTime)startTime toTime:(CMTime)endTime;
+ (instancetype)makeFromSecond:(float)startSecond toSecond:(float)endSecond;

@end
