//
//  ViewController.m
//  Kina Zoré
//
//  Created by Noah Teshu on 10/29/14.
//  Copyright (c) 2014 Noah Teshu. All rights reserved.
//

#import "SubscribeViewController.h"
#import "ChimpKit.h"


@interface SubscribeViewController ()
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *zipCodeTextField;
@property (strong, nonatomic)NSString *apiErrorKey;
@property (nonatomic, copy) ChimpKitRequestCompletionBlock completionHandler;


#import "ChimpKit.h"
- (IBAction)subscribePressed:(id)sender;

@end

@implementation SubscribeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //NSDictionary *testDictionary = @{@"key1" : @"value1", @"key2" : @"value2"};
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (IBAction)subscribePressed:(id)sender {
    
    //make sure all fields are filled out
    if (self.emailTextField.text.length == 0 || self.firstNameTextField.text.length == 0 || self.lastNameTextField.text.length == 0 || self.zipCodeTextField.text.length < 5) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Oops!" message:@"Please fill out all fields." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    } else {
        NSDictionary *params = @{ @"id": @"878629c097"
                                  , @"email": @{@"email": self.emailTextField.text}, @"merge_vars": @{@"FIRSTNAME": self.firstNameTextField.text, @"LASTNAME": self.lastNameTextField.text, @"ZIPCODE" : self.zipCodeTextField.text, @"new-email" : self.emailTextField.text}};
        
        [[ChimpKit sharedKit]callApiMethod:@"lists/subscribe" withApiKey:@"db02af20c5f964d668e994e7d1785968-us5" params:params andCompletionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            NSLog(@"response is: %@", response);
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            NSLog(@"the status code is: %d", httpResponse.statusCode);
            if ([response respondsToSelector:@selector(allHeaderFields)]) {
                NSDictionary *dictionary = [httpResponse allHeaderFields];
                NSLog(@"%@", [dictionary description]);
                self.apiErrorKey = [dictionary valueForKey:@"X-MailChimp-API-Error-Code"];
            }
            //if success, show confirmation
            if (httpResponse.statusCode == 200) {
                dispatch_async(dispatch_get_main_queue()
                               , ^{
                                   UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Success!" message:@"Thanks for signing up!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                                   [alert show];
                               }
                               );
                return;
            }
            //tell user if they're already signed up
            if ([self.apiErrorKey isEqualToString:@"214"]) {
                
                dispatch_async(dispatch_get_main_queue()
                               , ^{
                                   UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Oops!" message:@"It looks like you're already signed up." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                                   [alert show];
                               }
                               );
                return;
                
            }else {
                //general error message
                dispatch_async(dispatch_get_main_queue()
                               , ^{
                                   UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Oops!" message:@"Something went wrong. Please try again soon. If the problem continues, let us know at kinazore@gmail.com." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                                   [alert show];
                               }
                               );
            }
            NSLog(@"error: %@", error);
        }];

    }
    
    
}
@end




