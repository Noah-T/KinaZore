//
//  CalendarDetailViewController.m
//  Kina Zoré
//
//  Created by Noah Teshu on 11/5/14.
//  Copyright (c) 2014 Noah Teshu. All rights reserved.
//

#import "CalendarDetailViewController.h"
#import <EventKit/EventKit.h>
#import <EventKitUI/EventKitUI.h>


@interface CalendarDetailViewController ()

- (IBAction)saveEvent:(id)sender;

@end

@implementation CalendarDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
    
    self.eventTitleLabel.text = self.event[@"summary"];
    self.eventDateLabel.text = self.event[@"formattedDate"];
    
    
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

- (IBAction)saveEvent:(id)sender {
    
    NSLog(@"event values are: %@", self.event);
    EKEventStore *eventStore = [[EKEventStore alloc]init];
    [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        EKEvent *event= [EKEvent eventWithEventStore:eventStore];
        event.title= self.event[@"summary"];
        event.location = self.event[@"location"];
        event.startDate = self.event[@"unformattedDate"];
        event.endDate = self.event[@"unformattedEndDate"];
        [event setCalendar:[eventStore defaultCalendarForNewEvents]];
        NSError *err;
        [eventStore saveEvent:event span:EKSpanThisEvent commit:YES error:&err];
        NSLog(@"error is: %@", err);
        
        
        if (!err) {
            NSLog(@"no error");
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:@"Yay!" message:@"See you at the show!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                [alertview show];
            });
        } else if (err){
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:@"Oops!" message:err.description delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                [alertview show];
            });

        }
    }];
    
}

@end
