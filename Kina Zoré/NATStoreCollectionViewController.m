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
    self.albumDetailView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - 170)];
    [self.albumDetailView setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:self.albumDetailView];
    
    //T-shirt detail view
    self.tshirtDetailView = [[UIView alloc]initWithFrame:CGRectMake(0, 170, self.view.frame.size.width, self.view.frame.size.height)];
    [self.tshirtDetailView setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:self.tshirtDetailView];
    
    UIButton *showTshirts = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    [showTshirts setTitle:@"Show shirts" forState:UIControlStateNormal];
    [showTshirts setBackgroundColor:[UIColor greenColor]];
    [self.tshirtDetailView addSubview:showTshirts];
    [showTshirts addTarget:self action:@selector(showTshirts) forControlEvents:UIControlEventTouchUpInside];
    
    //tshirt button
    UILabel *tshirtLabel= [[UILabel alloc]initWithFrame:CGRectMake(0, self.tshirtDetailView.frame.size.height-100, self.tshirtDetailView.frame.size.width*0.8, (self.tshirtDetailView.frame.size.width*0.8)*0.4)];
    [tshirtLabel setBackgroundColor:[UIColor whiteColor]];
    
    [self.tshirtDetailView addSubview:tshirtLabel];
    
    
    
    
                               
    
    
    //souvenirs detail view
    self.souvenirsDetailView = [[UIView alloc]initWithFrame:CGRectMake(0, 340, self.view.frame.size.width, self.view.frame.size.height)];
    [self.souvenirsDetailView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.souvenirsDetailView];
    
    //souvenirs button
    UIButton *showSouvenirsButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.souvenirsDetailView.frame.size.width*0.8, (self.souvenirsDetailView.frame.size.width*0.8)*0.4)];
    [showSouvenirsButton setBackgroundColor:[UIColor blackColor]];
    [self.souvenirsDetailView addSubview:showSouvenirsButton];

    
    //autolayout
    
    
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(tshirtLabel, self.tshirtDetailView, showTshirts, self.souvenirsDetailView, showSouvenirsButton);
    tshirtLabel.translatesAutoresizingMaskIntoConstraints = NO;

    double width = self.view.frame.size.width*0.8;
    double height = width * 0.4;
    
    //tshirt button constraints
    showTshirts.translatesAutoresizingMaskIntoConstraints = NO;
    NSArray *tshirtButtonConstraints = @[
                                         [NSLayoutConstraint constraintsWithVisualFormat:@"H:[showTshirts(myVar)]" options:0 metrics:@{@"myVar": [NSNumber numberWithDouble:width] } views:viewsDictionary],
                                         [NSLayoutConstraint constraintsWithVisualFormat:@"V:[showTshirts(myHeight)]" options:0 metrics:@{@"myHeight": [NSNumber numberWithDouble:height]} views:viewsDictionary]
                                         ];
    NSLayoutConstraint *showTshirtsCenterConstraint = [NSLayoutConstraint constraintWithItem:showTshirts attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.tshirtDetailView attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f];
    [showTshirts addConstraints:tshirtButtonConstraints];
    //[self.tshirtDetailView addConstraint:showTshirtsCenterConstraint];
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
                                 metrics:@{@"yourMom": @50}
                                 views:viewsDictionary];

    [self.souvenirsDetailView addConstraint:souvenirCenterConstraint];
    [showSouvenirsButton addConstraint:souvenirWidthConstraint[0]];
    [showSouvenirsButton addConstraint:souvenirHeightConstraint[0]];
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

- (IBAction)showAlbumDetail:(id)sender {

    [self.view bringSubviewToFront:self.albumDetailView];
    if (!self.detailIsVisible) {
        [UIView animateWithDuration:0.5 animations:^{
            self.albumDetailView.frame = CGRectMake(0, 170, self.view.frame.size.width, self.view.frame.size.height-170);
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
    
    NSLog(@"heyyy");
    if (!self.tshirtsAreVisible) {
        
        [UIView animateWithDuration:0.5 animations:^{
            [self.view bringSubviewToFront:self.tshirtDetailView];

            
            self.tshirtDetailView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            self.souvenirsDetailView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
        } completion:^(BOOL finished) {
            
        }];
        self.tshirtsAreVisible = YES;
    } else {
        [UIView animateWithDuration:0.5 animations:^{
            [self.view bringSubviewToFront:self.souvenirsDetailView];
            self.tshirtDetailView.frame = CGRectMake(0, 170, self.view.frame.size.width, self.view.frame.size.height);
            self.souvenirsDetailView.frame = CGRectMake(0, 340, self.view.frame.size.width, self.view.frame.size.height);
        } completion:^(BOOL finished) {
            //[self.view sendSubviewToBack:self.tshirtDetailView];

        }];
        self.tshirtsAreVisible = NO;
    }
}
@end
