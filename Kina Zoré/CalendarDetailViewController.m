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

@property (strong, nonatomic)EKEventStore *eventStore;

@property (nonatomic, strong)EKEvent *EKEvent;
- (IBAction)saveEvent:(id)sender;

@end

@implementation CalendarDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.eventStore = [[EKEventStore alloc]init];
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
    
    [self.eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        self.EKEvent= [EKEvent eventWithEventStore:self.eventStore];
        self.EKEvent.title= self.event[@"summary"];
        self.EKEvent.location = self.event[@"location"];
        self.EKEvent.startDate = self.event[@"unformattedDate"];
        self.EKEvent.endDate = self.event[@"unformattedEndDate"];
        [self.EKEvent setCalendar:[self.eventStore defaultCalendarForNewEvents]];
        NSError *err;
        [self.eventStore saveEvent:self.EKEvent span:EKSpanThisEvent commit:YES error:&err];
        NSLog(@"error is: %@", err);
        
        
        if (!err) {
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
