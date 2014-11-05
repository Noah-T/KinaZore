//
//  NATCalendarViewController.m
//  Kina Zoré
//
//  Created by Noah Teshu on 11/4/14.
//  Copyright (c) 2014 Noah Teshu. All rights reserved.
//

#import "NATCalendarViewController.h"
#import "AFNetworking.h"

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
    
    NSString *calendarId = @"oe8l8miodc0gd5vilsirbqhink@group.calendar.google.com";
    NSString *apiKey = @"AIzaSyCAkVQVwMzmPHxbaLUAqvb6dYUwjKU5qnM";
    NSString *urlFormat = [NSString stringWithFormat:@"https://www.googleapis.com/calendar/v3/calendars/%@/events?key=%@&fields=items(id,start,summary,status,location)", calendarId, apiKey];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager GET:urlFormat parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDateFormatter *dayFormatter, *timeFormatter, *finalPresentationFormatter;
        dayFormatter = [[NSDateFormatter alloc]init];
        dayFormatter.dateFormat = @"yyyy-mm-dd";
        timeFormatter = [[NSDateFormatter alloc]init];
        timeFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZZZZZ";
        finalPresentationFormatter = [[NSDateFormatter alloc]init];
        finalPresentationFormatter.dateFormat = @"dd-MM-yyyy";
        
        
        
        for (NSDictionary *eventData in responseObject[@"items"]) {
            NSMutableDictionary *mutableEventData = [eventData mutableCopy];
            if (!self.eventArray) {
                self.eventArray = [NSMutableArray array];
            }
            
            NSDate *date;
            NSDate *todayDate = [NSDate date];
            if (eventData[@"start"][@"date"]) {
                date = [dayFormatter dateFromString:eventData[@"start"][@"date"]];
                
            } else if (eventData[@"start"][@"dateTime"]){
                date = [timeFormatter dateFromString:eventData[@"start"][@"dateTime"]];
                
            }
            
            //if event date is after the current date
            if ([date compare:todayDate] == NSOrderedDescending) {
                NSLog(@"date has come through %@", date);
                //format it into something more readable
                NSString *formattedDate = [finalPresentationFormatter stringFromDate: date];
                //add it to the event array
                NSLog(@"formatted date is %@", formattedDate);
                [mutableEventData setObject:formattedDate forKey:@"formattedDate"];
                [self.eventArray addObject:mutableEventData];
            }
            
            [self.calendarTableView reloadData];
        }
        NSLog(@"event array: %@", self.eventArray);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", error);
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"count is %d", [self.eventArray count]);
    return [self.eventArray count];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSMutableDictionary *event = [self.eventArray objectAtIndex:indexPath.row];
    UITableViewCell *cell = [self.calendarTableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@ - %@", event[@"summary"], event[@"formattedDate"], event[@"location"]];
    return cell;
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
