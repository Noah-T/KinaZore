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

@interface NATCalendarViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *calendarTableView;

@end

@implementation NATCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.calendarTableView.delegate = self;
    self.calendarTableView.dataSource = self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    
    
    self.eventArray = nil;
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
                NSLog(@"formatted date is %@", formattedDate);
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
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
     NSIndexPath *indexPath = [self.calendarTableView indexPathForSelectedRow];
    
     NSMutableDictionary *event = [self.eventArray objectAtIndex:indexPath.row];
     CalendarDetailViewController *destinationViewController = segue.destinationViewController;
     destinationViewController.event = event;
     
     

 }


@end
