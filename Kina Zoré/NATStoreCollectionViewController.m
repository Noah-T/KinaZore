//
//  NATStoreCollectionViewController.m
//  Kina Zoré
//
//  Created by Noah Teshu on 12/5/14.
//  Copyright (c) 2014 Noah Teshu. All rights reserved.
//

#import "NATStoreCollectionViewController.h"
#import "NATStoreItemCollectionViewCell.h"

@interface NATStoreCollectionViewController ()

@property (nonatomic) BOOL detailIsVisible;
@property (nonatomic) BOOL tshirtsAreVisible;
@property (nonatomic) BOOL souvenirsAreVisible;

@property (strong, nonatomic) UIView *albumDetailView;
@property (strong, nonatomic) UIView *tshirtDetailView;
@property (strong, nonatomic) UIView *souvenirsDetailView;



@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation NATStoreCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    //store items
    NATStoreItem *acdcBag = [[NATStoreItem alloc]initWithImage:[UIImage imageNamed:@"acdcBag"] description:@"AC/DC Bag" price:9.99];
    NATStoreItem *acdcFigurines = [[NATStoreItem alloc]initWithImage:[UIImage imageNamed:@"acdcFigurines"] description:@"AC/DC Figurines" price:30];
    NATStoreItem *acdcHat = [[NATStoreItem alloc]initWithImage:[UIImage imageNamed:@"acdcHat"] description:@"AC/DC Hat" price:19.99];
    NATStoreItem *acdcMug = [[NATStoreItem alloc]initWithImage:[UIImage imageNamed:@"acdcMug"] description:@"AC/DC Mug" price:11.99];
    NATStoreItem *acdcRing = [[NATStoreItem alloc]initWithImage:[UIImage imageNamed:@"acdcRing"] description:@"AC/DC Ring" price:49.99];
    NATStoreItem *oneDirectionBracelet = [[NATStoreItem alloc]initWithImage:[UIImage imageNamed:@"oneDirectionBracelet"] description:@"One Direction Bracelet" price:99.99];
    self.itemsForSale = @[acdcBag, acdcFigurines, acdcHat, acdcMug, acdcRing, oneDirectionBracelet];
    
    //album detail view
    self.albumDetailView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
    [self.albumDetailView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.albumDetailView];
    
    //T-shirt detail view
    self.tshirtDetailView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height * 0.47, self.view.frame.size.width, self.view.frame.size.height)];
    [self.tshirtDetailView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.tshirtDetailView];
    
    UIButton *showTshirts = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    [showTshirts setBackgroundImage:[UIImage imageNamed:@"tshirt"] forState:UIControlStateNormal];

    [self.tshirtDetailView addSubview:showTshirts];
    [showTshirts addTarget:self action:@selector(showTshirts) forControlEvents:UIControlEventTouchUpInside];
    
    //tshirt button
    UILabel *tshirtLabel= [[UILabel alloc]initWithFrame:CGRectMake(0, self.tshirtDetailView.frame.size.height-100, self.tshirtDetailView.frame.size.width*0.8, (self.tshirtDetailView.frame.size.width*0.8)*0.4)];
    [tshirtLabel setBackgroundColor:[UIColor colorWithRed:0.161 green:0.671 blue:0.886 alpha:1] /*#29abe2*/
];
    tshirtLabel.text = @"This is the greatest t-shirt the world has ever seen";

    
    [self.tshirtDetailView addSubview:tshirtLabel];
    
    double tshirtImageWidth = self.view.frame.size.width * 0.8;
    double tshirtImageHeight = self.view.frame.size.height * 0.33;
    
    UIImageView *tshirtImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height * 0.33, tshirtImageWidth, tshirtImageHeight)];
    tshirtImageView.image = [UIImage imageNamed:@"kzlive"];
    [self.tshirtDetailView addSubview:tshirtImageView];
    
    //souvenirs detail view
    self.souvenirsDetailView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height * 0.74, self.view.frame.size.width, self.view.frame.size.height)];
    [self.souvenirsDetailView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.souvenirsDetailView];
    
    //souvenirs button
    UIButton *showSouvenirsButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.souvenirsDetailView.frame.size.width*0.8, (self.souvenirsDetailView.frame.size.width*0.8)*0.4)];
    [showSouvenirsButton addTarget:self action:@selector(showSouvenirs) forControlEvents:UIControlEventTouchUpInside];
    [showSouvenirsButton setBackgroundImage:[UIImage imageNamed:@"posters"] forState:UIControlStateNormal];
    
    [self.souvenirsDetailView addSubview:showSouvenirsButton];

    
    //autolayout
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(tshirtLabel, self.tshirtDetailView, showTshirts, self.souvenirsDetailView, showSouvenirsButton, tshirtImageView);
    tshirtLabel.translatesAutoresizingMaskIntoConstraints = NO;

    double width = self.view.frame.size.width*0.8;
    double height = width * 0.4;
    
    //tshirt button constraints
    showTshirts.translatesAutoresizingMaskIntoConstraints = NO;
    NSArray *tshirtButtonConstraintsHorizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[showTshirts(myVar)]" options:0 metrics:@{@"myVar": [NSNumber numberWithDouble:width] } views:viewsDictionary];
    NSArray *tshirtButtonConstraintsVertical =[NSLayoutConstraint constraintsWithVisualFormat:@"V:[showTshirts(myHeight)]" options:0 metrics:@{@"myHeight": [NSNumber numberWithDouble:height]} views:viewsDictionary];
    NSArray *tshirtButtonConstraints = @[[NSLayoutConstraint constraintsWithVisualFormat:@"H:[showTshirts(myVar)]" options:0 metrics:@{@"myVar": [NSNumber numberWithDouble:width] } views:viewsDictionary]];
    NSArray *tshirtBottomConstraint = [NSLayoutConstraint
                                 constraintsWithVisualFormat:@"V:|-yourMom-[showTshirts]"
                                 options:0
                                 metrics:@{@"yourMom": @30}
                                 views:viewsDictionary];

//                                         ];
    NSLayoutConstraint *showTshirtsCenterConstraint = [NSLayoutConstraint constraintWithItem:showTshirts attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.tshirtDetailView attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f];
[showTshirts addConstraint:tshirtButtonConstraintsHorizontal[0]];
    [showTshirts addConstraint:tshirtButtonConstraintsVertical[0]];
    [showTshirts addConstraints:tshirtButtonConstraints[0]];

    [self.tshirtDetailView addConstraint:showTshirtsCenterConstraint];
    [self.tshirtDetailView addConstraint:tshirtBottomConstraint[0]];
    
    //tshirt image constraints
    
    tshirtImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    double fivePercentPadding = self.view.frame.size.height * 0.05;
    
    NSArray *tshirtImageConstraintHorizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[tshirtImageView(myHorizontal)]" options:0 metrics:@{@"myHorizontal": [NSNumber numberWithDouble: tshirtImageWidth]} views:viewsDictionary];
    NSArray *tshirtImageConstraintVertical = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[tshirtImageView(myVertical)]" options:0 metrics:@{@"myVertical": [NSNumber numberWithDouble:tshirtImageHeight]} views:viewsDictionary];
    NSArray *tshirtImagePinToAbove = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[showTshirts]-mySpace-[tshirtImageView]" options:0 metrics:@{@"mySpace": [NSNumber numberWithDouble:fivePercentPadding]} views:viewsDictionary];
    NSLayoutConstraint *tshirtImageCenterConstraint = [NSLayoutConstraint constraintWithItem:tshirtImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.tshirtDetailView attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0];
    
    [tshirtImageView addConstraint:tshirtImageConstraintHorizontal[0]];
    [tshirtImageView addConstraint:tshirtImageConstraintVertical[0]];
    [self.tshirtDetailView addConstraint:tshirtImagePinToAbove[0]];
    [self.tshirtDetailView addConstraint:tshirtImageCenterConstraint];
    //tshirt label constraints
    NSArray *widthConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[tshirtLabel(myVar)]" options:0 metrics:@{@"myVar": [NSNumber numberWithDouble:width] } views:viewsDictionary];
    
    NSArray *heightConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[tshirtLabel(myHeight)]" options:0 metrics:@{@"myHeight": [NSNumber numberWithDouble:height]} views:viewsDictionary];
    
    NSArray *bottomConstraint = [NSLayoutConstraint
                                 constraintsWithVisualFormat:@"V:[tshirtLabel]-yourMom-|"
                                 options:0
                                 metrics:@{@"yourMom": @50}
                                 views:viewsDictionary];
    NSLayoutConstraint *centerConstraint = [NSLayoutConstraint constraintWithItem:tshirtLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.tshirtDetailView attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f];
    
   [tshirtLabel addConstraint:widthConstraint[0]];
    [tshirtLabel addConstraint:heightConstraint[0]];
    [self.tshirtDetailView addConstraint:bottomConstraint[0]];
    [self.tshirtDetailView addConstraint:centerConstraint];
    
    //souvenir button constraints

    showSouvenirsButton.translatesAutoresizingMaskIntoConstraints = NO;

    NSLayoutConstraint *souvenirCenterConstraint = [NSLayoutConstraint constraintWithItem:showSouvenirsButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.souvenirsDetailView attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f];
    
    
    NSArray *souvenirWidthConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[showSouvenirsButton(myVar)]" options:0 metrics:@{@"myVar": [NSNumber numberWithDouble:width] } views:viewsDictionary];
    
    NSArray *souvenirHeightConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[showSouvenirsButton(myHeight)]" options:0 metrics:@{@"myHeight": [NSNumber numberWithDouble:height]} views:viewsDictionary];
    
    NSArray *souvenirBottomConstraint = [NSLayoutConstraint
                                 constraintsWithVisualFormat:@"V:|-yourMom-[showSouvenirsButton]"
                                 options:0
                                 metrics:@{@"yourMom": @30}
                                 views:viewsDictionary];

    [showSouvenirsButton addConstraint:souvenirWidthConstraint[0]];
    [showSouvenirsButton addConstraint:souvenirHeightConstraint[0]];
    [self.souvenirsDetailView addConstraint:souvenirCenterConstraint];

    [self.souvenirsDetailView addConstraint:souvenirBottomConstraint[0]];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.detailIsVisible = NO;
    self.tshirtsAreVisible = NO;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.itemsForSale.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NATStoreItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell
    NATStoreItem *item = [self.itemsForSale objectAtIndex:indexPath.row];
    
    cell.itemImage.image = item.itemImage;
    cell.itemDescription.text = item.itemDescription;
    cell.itemPrice.text = [NSString stringWithFormat:@"%.2f", item.itemPrice];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/
#pragma mark - Animation 
- (IBAction)showAlbumDetail:(id)sender {
    [self.view bringSubviewToFront:self.albumDetailView];
    if (!self.detailIsVisible) {
        [UIView animateWithDuration:0.5 animations:^{
            self.albumDetailView.frame = CGRectMake(0, self.view.frame.size.height * 0.46, self.view.frame.size.width, self.view.frame.size.height-170);
        } completion:^(BOOL finished) {
            NSLog(@"first animation happened");
        }];
        self.detailIsVisible = YES;

    } else {
        [UIView animateWithDuration:0.5 animations:^{
            self.albumDetailView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - 170);
        } completion:^(BOOL finished) {
            NSLog(@"animation happened");
        }];
        self.detailIsVisible = NO;

    }
}

- (void)showTshirts {

    [self.view bringSubviewToFront:self.tshirtDetailView];

    NSLog(@"heyyy");
    if (!self.tshirtsAreVisible) {
        [UIView animateWithDuration:0.5 animations:^{

            
            self.tshirtDetailView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            self.souvenirsDetailView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
            self.albumDetailView.frame = CGRectMake(0, 400, self.view.frame.size.width, self.view.frame.size.height);

        } completion:^(BOOL finished) {

        }];
        self.tshirtsAreVisible = YES;
    } else {
        [UIView animateWithDuration:0.5 animations:^{
            [self.view bringSubviewToFront:self.souvenirsDetailView];
            self.tshirtDetailView.frame = CGRectMake(0, self.view.frame.size.height * 0.47, self.view.frame.size.width, self.view.frame.size.height);
            self.souvenirsDetailView.frame = CGRectMake(0, self.view.frame.size.height * 0.74, self.view.frame.size.width, self.view.frame.size.height);
        } completion:^(BOOL finished) {
            //[self.view sendSubviewToBack:self.tshirtDetailView];

        }];
        self.tshirtsAreVisible = NO;
    }
}

-(void)showSouvenirs
{
    [self.view bringSubviewToFront:self.souvenirsDetailView];
    if (!self.souvenirsAreVisible) {
        [UIView animateWithDuration:0.5 animations:^{
            self.souvenirsDetailView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        } completion:^(BOOL finished) {
            NSLog(@"first animation happened");
        }];
        self.souvenirsAreVisible = YES;
        
    } else {
        [UIView animateWithDuration:0.5 animations:^{
            self.souvenirsDetailView.frame = CGRectMake(0, self.view.frame.size.height * 0.74, self.view.frame.size.width, self.view.frame.size.height);
            self.tshirtDetailView.frame = CGRectMake(0, self.view.frame.size.height * 0.47, self.view.frame.size.width, self.view.frame.size.height);
        } completion:^(BOOL finished) {
            NSLog(@"animation happened");
        }];
        self.souvenirsAreVisible = NO;
        
    }
   
}
@end
