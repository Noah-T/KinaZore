//
//  NATAudioPlayer.h
//  Kina Zoré
//
//  Created by Noah Teshu on 10/31/14.
//  Copyright (c) 2014 Noah Teshu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface NATAudioPlayer : UIViewController

@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

- (void)initPlayer:(NSString *) audioFile fileExtension:(NSString *)fileExtension;
- (void)playAudio;
- (void)pauseAudio;
- (void)setCurrentAudioTime:(float)value;
- (float)getAudioDuration;
- (NSString *)timeFormat:(float)value;
- (NSTimeInterval)getCurrentAudioTime;

@end
