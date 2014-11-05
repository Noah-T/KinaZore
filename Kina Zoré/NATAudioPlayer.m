//
//  NATAudioPlayer.m
//  Kina Zoré
//
//  Created by Noah Teshu on 10/31/14.
//  Copyright (c) 2014 Noah Teshu. All rights reserved.
//

#import "NATAudioPlayer.h"

@interface NATAudioPlayer ()

@end

@implementation NATAudioPlayer

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.r
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initPlayer:(NSString *)audioFile fileExtension:(NSString *)fileExtension
{
    NSURL *audioFileLocationURL = [[NSBundle mainBundle]URLForResource:audioFile withExtension:fileExtension];
    NSError *error;
    self.audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:audioFileLocationURL error:&error];
}

-(void)playAudio
{
    [self.audioPlayer play];
}

-(void)pauseAudio
{
    [self.audioPlayer pause];
}

-(NSString *)timeFormat:(float)value
{
    //time will be given in seconds
    //divide by 60, then round down to the nearest whole number
    
    //note: lround() declares closest integer value
    
    float minutes = floor(lroundf(value)/60);
    
    //closest integer value of number of seconds
    //subtract seconds that are already accounted for in minutes
    //this means the number should never be greater than 60
    //allow for display of times like 3:14, instead of 2:74, etc
    float seconds = lroundf(value) - (minutes * 60);
    
    int roundedMinutes = lroundf(minutes);
    int roundedSeconds = lroundf(seconds);
    
    //return formatted string with values
    NSString *time = [[NSString alloc]initWithFormat:@"%d:%02d", roundedMinutes, roundedSeconds ];
    
    return time;
}

- (void)setCurrentAudioTime:(float)value
{
    [self.audioPlayer setCurrentTime:value];
}

- (NSTimeInterval)getCurrentAudioTime
{
    return [self.audioPlayer currentTime];
}

-(float)getAudioDuration
{
    return [self.audioPlayer duration];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
