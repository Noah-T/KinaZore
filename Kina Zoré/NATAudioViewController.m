//
//  NATAudioViewController.m
//  Kina Zoré
//
//  Created by Noah Teshu on 11/2/14.
//  Copyright (c) 2014 Noah Teshu. All rights reserved.
//

#import "NATAudioViewController.h"

@interface NATAudioViewController ()

@end

@implementation NATAudioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.audioPlayer = [[NATAudioPlayer alloc]init];
    [self setupAudioPlayer:@"AuDualanga"];
    self.nowPlayingLabel.text = @"Au Dualanga";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (IBAction)playSelectedSong:(UIButton *)sender {
    if ([[sender currentTitle]isEqualToString:@"Au Dualanga"]) {
        [self.audioPlayer initPlayer:@"AuDualanga" fileExtension:@"mp3"];
        self.nowPlayingLabel.text = @"Au Dualanga";
        

        
    } else if ([[sender currentTitle]isEqualToString:@"Jam"]) {
        [self.audioPlayer initPlayer:@"Jam" fileExtension:@"mp3"];
        self.nowPlayingLabel.text = @"6/8 Jam";
        
    } else if ([[sender currentTitle]isEqualToString:@"Xitsungo Xa Africa"]){
        [self.audioPlayer initPlayer:@"Xitsungo Xa Africa" fileExtension:@"mp3"];
        self.nowPlayingLabel.text = @"Xitsungo Xa Africa";

        
    }
    
    //hit play button once
    [self.playButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    
    //if audio was playing at the time, hit it again to start playing
    if (!self.isPaused) {
        [self.playButton sendActionsForControlEvents:UIControlEventTouchUpInside];
        
    }
}

- (void)setupAudioPlayer:(NSString *)fileName
{
    NSString *fileExtension = @"mp3";
    [self.audioPlayer initPlayer:fileName fileExtension:fileExtension];
    self.currentTimeSlider.maximumValue = [self.audioPlayer getAudioDuration];
    
    //set time to zero at beginning of playback
    self.timeElapsed.text = @"0:00";
    
    //duration of whole song is set
    //time format is set with nested call
    //self.audioPlayer timeFormat >> self.audioPlayer getAudioDuration
    self.duration.text = [NSString stringWithFormat:@"-%@", [self.audioPlayer timeFormat:[self.audioPlayer getAudioDuration]]];
    
}

-(IBAction)playAudioPressed:(id)playButton
{
    //clear the timer from the run loop
    [self.timer invalidate];
    //play audio for first time, or if pause was pressed
    if (!self.isPaused) {
        //change the image from "play" to "pause"
        [self.playButton setBackgroundImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
        
        
        
        //start timer to update time label display
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                      target:self selector:@selector(updateTime:) userInfo:nil repeats:YES];
        [self.audioPlayer playAudio];
        self.isPaused = TRUE;
        
        
    } else {
        //player is paused and button is pressed again
        [self.playButton setBackgroundImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
        
        [self.audioPlayer pauseAudio];
        self.isPaused = FALSE;
    }
}


//update time label display, current value of slider while audio is playing

-(void)updateTime:(NSTimer *)timer
{
    //if not scrubbing
    if (!self.scrubbing) {
        //get the current audio position of the file
        self.currentTimeSlider.value = [self.audioPlayer getCurrentAudioTime];
    }
    self.timeElapsed.text= [NSString stringWithFormat:@"%@", [self.audioPlayer timeFormat:[self.audioPlayer getCurrentAudioTime]]];
        
    self.duration.text = [NSString stringWithFormat:@"-%@", [self.audioPlayer timeFormat:[self.audioPlayer getAudioDuration] - [self.audioPlayer getCurrentAudioTime]]];
}

//sets the current value of the slider/scrubber to the audio file when slider/scrubber is used

- (IBAction)setCurrentTime:(id)scrubber
{
    //update time every 100th of a second when scrubbing
    [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(updateTime:) userInfo:nil repeats:YES];
    
    //update audio player time to match value of slider
    [self.audioPlayer setCurrentAudioTime:self.currentTimeSlider.value];
    
    //set scrubbing to false after operation is complete
    self.scrubbing = FALSE;
}

- (IBAction)userIsScrubbing:(id)sender
{
    //done to stop update while user is currently scrubbing
    self.scrubbing = TRUE;
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.isPaused = YES;
    [self.playButton sendActionsForControlEvents:UIControlEventTouchUpInside];

    [super viewWillDisappear:animated];
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
