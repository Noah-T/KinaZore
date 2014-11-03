//
//  NATAudioViewController.h
//  Kina Zoré
//
//  Created by Noah Teshu on 11/2/14.
//  Copyright (c) 2014 Noah Teshu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NATAudioPlayer.h"

@interface NATAudioViewController : UIViewController

@property (nonatomic, strong) NATAudioPlayer *audioPlayer;

@property (weak, nonatomic) IBOutlet UISlider *currentTimeSlider;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UILabel *duration;
@property (weak, nonatomic) IBOutlet UILabel *timeElapsed;
@property (weak, nonatomic) IBOutlet UILabel *nowPlayingLabel;

@property BOOL isPaused;
@property BOOL scrubbing;

@property NSTimer *timer;

@end
