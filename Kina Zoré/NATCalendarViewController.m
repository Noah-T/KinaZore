//
//  NATCalendarViewController.m
//  Kina Zoré
//
//  Created by Noah Teshu on 11/4/14.
//  Copyright (c) 2014 Noah Teshu. All rights reserved.
//

#import "NATCalendarViewController.h"

@interface NATCalendarViewController ()

@end

@implementation NATCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSString *calendarId = @"1fg4tpnbnn5sanom55b99cuflo@group.calendar.google.com";
    NSString *apiKey = @"AIzaSyBUOjVcsfVwc14xCaIQeEpCfk0AvVpjUcc";
    NSString *urlFormat = @"https://www.googleapis.com/calendar/v3/calendars/%@/events?key=%@&fields=items(id,start,summary,status)";
    NSString *calendarUrl = [NSString stringWithFormat:urlFormat, calendarId, apiKey];
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:calendarUrl]completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"response is: %@", response);
    }]resume];
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

@end
