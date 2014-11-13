//
//  NATPaymentViewController.m
//  
//
//  Created by Noah Teshu on 11/13/14.
//
//

#import "NATPaymentViewController.h"
#import "Stripe.h"
#import "PTKView.h"

@interface NATPaymentViewController ()<PTKViewDelegate>

@property (weak, nonatomic) PTKView *paymentView;
- (IBAction)continuePressed:(id)sender;

@end

@implementation NATPaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    PTKView *view = [[PTKView alloc]initWithFrame:CGRectMake(15, 80, 290, 55)];
    self.paymentView = view;
    self.paymentView.delegate = self;
    [self.view addSubview:view];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)paymentView:(PTKView *)paymentView withCard:(PTKCard *)card isValid:(BOOL)valid
{
    NSLog(@"card is valid");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)continuePressed:(id)sender {
    STPCard *card = [[STPCard alloc]init];
    card.number = self.paymentView.card.number;
    card.expMonth = self.paymentView.card.expMonth;
    card.expYear = self.paymentView.card.expYear;
    card.cvc = self.paymentView.card.cvc;
    [Stripe createTokenWithCard:card completion:^(STPToken *token, NSError *error) {
        if (error) {
            NSLog(@"There was an error");
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Oops!" message:@"There was an error. Please make sure all fields are filled out correctly and try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        } else {
            NSLog(@"Hooray! No error.");
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Success!" message:@"Your card is valid and ready to use." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }];
}
@end
