//
//  NATRadioViewController.m
//  Kina Zoré
//
//  Created by Noah Teshu on 11/5/14.
//  Copyright (c) 2014 Noah Teshu. All rights reserved.
//

#import "NATRadioViewController.h"

@interface NATRadioViewController ()

@end

@implementation NATRadioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)openSpotify:(id)sender {
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"spotify:user:spotify:playlist:0XUlpafP8eIlIWt3VHSd7q"]];
}
@end
