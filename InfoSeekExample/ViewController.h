//
//  ViewController.h
//  InfoSeek
//
//  Created by Richmond Starbuck on 11/20/15.
//  Copyright © 2015 Dynamic Project Management Group. All rights reserved.
//

#import "InformativeSeekbar.h"

#import <UIKit/UIKit.h>
#import <AVKit/AVKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *labelValue;
@property (weak, nonatomic) IBOutlet InformativeSeekbar *informativeSeekbar;

@property (strong, nonatomic) AVPlayerViewController *avPlayerViewController;
@property (weak, nonatomic) IBOutlet UIView *avPlayerViewContainer;

@end

