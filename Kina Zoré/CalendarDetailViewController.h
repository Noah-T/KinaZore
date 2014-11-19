//
//  CalendarDetailViewController.h
//  Kina Zoré
//
//  Created by Noah Teshu on 11/5/14.
//  Copyright (c) 2014 Noah Teshu. All rights reserved.
//

#import <EventKit/EventKit.h>
#import <EventKitUI/EventKitUI.h>

#import <UIKit/UIKit.h>

@interface CalendarDetailViewController : UIViewController

@property (strong, nonatomic)NSMutableDictionary *event;
@property (weak, nonatomic) IBOutlet UILabel *eventTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventDateLabel;

@end
