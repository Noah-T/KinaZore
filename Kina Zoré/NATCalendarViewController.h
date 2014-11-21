//
//  NATCalendarViewController.h
//  Kina Zoré
//
//  Created by Noah Teshu on 11/4/14.
//  Copyright (c) 2014 Noah Teshu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NATCalendarViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray *eventArray;
@property (strong, nonatomic) NSMutableDictionary *event;
@property (strong, nonatomic) UIRefreshControl *refreshControl;


@end
