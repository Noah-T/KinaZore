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

- (IBAction)subscribePressed:(id)sender {
//    NSDictionary *params = @{@"apikey": @"db02af20c5f964d668e994e7d1785968-us5", @"id": @"878629c097"
//                             , @"email": @{@"email": self.emailTextField.text}, @"merge_vars": @{@"FNAME": self.firstNameTextField.text, @"LName": self.lastNameTextField.text}};
//    NSError *error = nil;
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:&error];
//    NSString *jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
//
//    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://us5.db02af20c5f964d668e994e7d1785968-us5.mailchimp.com/2.0/lists/subscribe.json%@", jsonString]];
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
//
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
//    request.HTTPMethod = @"POST";
//    
//   
//        NSLog(@"jsonString: %@", jsonString);
//    
//    NSURLSessionUploadTask *downloadTask = [session uploadTaskWithStreamedRequest:request];
//    [downloadTask resume];
//
//   }
    
    NSDictionary *params = @{ @"id": @"878629c097"
                              , @"email": @{@"email": self.emailTextField.text}, @"merge_vars": @{@"FIRSTNAME": self.firstNameTextField.text, @"LASTNAME": self.lastNameTextField.text, @"ZIPCODE" : self.zipCodeTextField.text, @"new-email" : self.emailTextField.text}};
    NSLog(@"params: %@", params);
[[ChimpKit sharedKit]callApiMethod:@"lists/subscribe" withApiKey:@"db02af20c5f964d668e994e7d1785968-us5" params:params andCompletionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
    NSLog(@"response: %@", response);
    NSLog(@"error: %@", error);
}];
    
}
@end




