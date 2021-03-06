//
//  NATCalendarViewController.m
//  Kina Zoré
//
//  Created by Noah Teshu on 11/4/14.
//  Copyright (c) 2014 Noah Teshu. All rights reserved.
//

#import "NATCalendarViewController.h"
#import "AFNetworking.h"
#import "CalendarDetailViewController.h"
#import <EventKitUI/EventKitUI.h>


@interface NATCalendarViewController () <UITableViewDelegate, UITableViewDataSource, EKEventEditViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *calendarTableView;
@property (strong, nonatomic) EKEventEditViewController *eventViewController;
@property (strong, nonatomic) EKEvent *EKEvent;
@property (strong, nonatomic) EKEventStore *eventStore;


@end

@implementation NATCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.refreshControl addTarget:self action:@selector(updateCalendar) forControlEvents:UIControlEventValueChanged];

    
    self.calendarTableView.delegate = self;
    self.calendarTableView.dataSource = self;
    
    self.eventStore = [[EKEventStore alloc]init];
    //create event view controller
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
//    [self.tableView setContentOffset:CGPointMake(-44, -self.refreshControl.frame.size.height) animated:YES];

    [self updateCalendar];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.eventArray count];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSMutableDictionary *event = [self.eventArray objectAtIndex:indexPath.row];
    UITableViewCell *cell = [self.calendarTableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@", event[@"summary"], event[@"formattedDate"]];
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
// - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
// // Get the new view controller using [segue destinationViewController].
// // Pass the selected object to the new view controller.
//     NSLog(@"prepare for segue fired");
//     NSLog(@"Inside of prepareforsegue, self.event has a vlue of: %@", self.event);
//     if ([segue.identifier isEqualToString:@"calendarDetail"]) {
//         NATEKEventViewController *destinationViewController = segue.destinationViewController;
//         destinationViewController.dictionaryEvent = self.event;
//     }
//
// }


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    self.event = [self.eventArray objectAtIndex:indexPath.row];
    
    __weak NATCalendarViewController *weakSelf = self;
    
    
    
    //request access to user calendar/eventStore
    [self.eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        
        self.eventViewController = [[EKEventEditViewController alloc]init];
        self.eventViewController.editViewDelegate = self;
        self.eventViewController.navigationItem.rightBarButtonItem = nil;
        self.eventViewController.eventStore = self.eventStore;
        
        self.EKEvent= [EKEvent eventWithEventStore:self.eventStore];
        self.EKEvent.title= self.event[@"summary"];
        self.EKEvent.location = self.event[@"location"];
        self.EKEvent.startDate = self.event[@"unformattedDate"];
        self.EKEvent.endDate = self.event[@"unformattedEndDate"];
        [self.EKEvent setCalendar:[self.eventStore defaultCalendarForNewEvents]];
        self.eventViewController.event = self.EKEvent;
        
        [self presentViewController:self.eventViewController animated:YES completion:^{
            NSLog(@"viewController presented");
        }];
        
    }];
    
    
    
}


- (void)eventEditViewController:(EKEventEditViewController *)controller didCompleteWithAction:(EKEventEditViewAction)action
{
    NSError *err;
    switch (action) {
            
        case EKEventEditViewActionSaved:
            NSLog(@"done pressed");
            [controller.eventStore saveEvent:controller.event span:EKSpanThisEvent commit:YES error:&err];
            NSLog(@"error is: %@", err);
            
            if (!err) {
                UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:@"Yay!" message:@"See you at the show!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                [alertview show];
            } else if(err){
                
                UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:@"Oops!" message:err.description delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                [alertview show];
            }
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
            
        case EKEventEditViewActionDeleted:
        case EKEventEditViewActionCanceled:
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
            
        default:
            break;
    }
}

- (void)updateCalendar
{
    self.eventArray = [NSMutableArray array];
    
    NSString *calendarId = @"1fg4tpnbnn5sanom55b99cuflo@group.calendar.google.com";
    NSString *apiKey = @"AIzaSyCAkVQVwMzmPHxbaLUAqvb6dYUwjKU5qnM";
    NSString *urlFormat = [NSString stringWithFormat:@"https://www.googleapis.com/calendar/v3/calendars/%@/events?key=%@&fields=items(id,start,end,summary,status,location)", calendarId, apiKey];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager GET:urlFormat parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDateFormatter *dayFormatter, *timeFormatter, *finalPresentationFormatter;
        dayFormatter = [[NSDateFormatter alloc]init];
        dayFormatter.dateFormat = @"yyyy-mm-dd";
        timeFormatter = [[NSDateFormatter alloc]init];
        timeFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZZZZZ";
        finalPresentationFormatter = [[NSDateFormatter alloc]init];
        finalPresentationFormatter.dateFormat = @"MM/dd/yyyy";
        
        for (NSDictionary *eventData in responseObject[@"items"]) {
            NSMutableDictionary *mutableEventData = [eventData mutableCopy];
            if (!self.eventArray) {
                self.eventArray = [NSMutableArray array];
            }
            
            NSDate *startDate;
            NSDate *endDate;
            NSDate *todayDate = [NSDate date];
            if (mutableEventData[@"start"][@"date"]) {
                startDate = [dayFormatter dateFromString:mutableEventData[@"start"][@"date"]];
                endDate = [dayFormatter dateFromString:mutableEventData[@"end"][@"date"]];
            } else if (mutableEventData[@"start"][@"dateTime"]){
                startDate = [timeFormatter dateFromString:mutableEventData[@"start"][@"dateTime"]];
                endDate = [timeFormatter dateFromString:mutableEventData[@"end"][@"dateTime"]];
            }
            
            //if event date is after the current date
            if ([startDate compare:todayDate] == NSOrderedDescending) {
                //format it into something more readable
                NSString *formattedDate = [finalPresentationFormatter stringFromDate: startDate];
                //add it to the event array
                [mutableEventData setObject:formattedDate forKey:@"formattedDate"];
                [mutableEventData setObject:startDate forKey:@"unformattedDate"];
                [mutableEventData setObject:endDate forKey:@"unformattedEndDate"];
                [self.eventArray addObject:mutableEventData];
            }
            
            [self.calendarTableView reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", error);
    }];
    
    if ([self.refreshControl isRefreshing]) {
        [self.refreshControl endRefreshing];
    }
}


@end




