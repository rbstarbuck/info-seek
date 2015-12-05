//
//  InformativeSeekbarKnobLayer.h
//  InfoSeek
//
//  Created by Richmond Starbuck on 11/20/15.
//  Copyright © 2015 Dynamic Project Management Group. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@class InformativeSeekbar;

@interface InformativeSeekbarKnobLayer : CALayer

@property BOOL isSelected;
@property (weak) InformativeSeekbar *parent;

@end
