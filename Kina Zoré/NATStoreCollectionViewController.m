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
    
    UIButton *showTshirts = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 200, 100)];
    [showTshirts setTitle:@"Show shirts" forState:UIControlStateNormal];
    [showTshirts setBackgroundColor:[UIColor whiteColor]];
    [self.tshirtDetailView addSubview:showTshirts];
    [showTshirts addTarget:self action:@selector(showTshirts) forControlEvents:UIControlEventTouchUpInside];
    
    
    //souvenirs detail view
    self.souvenirsDetailView = [[UIView alloc]initWithFrame:CGRectMake(0, 340, self.view.frame.size.width, self.view.frame.size.height)];
    [self.souvenirsDetailView setBackgroundColor:[UIColor yellowColor]];
    [self.view addSubview:self.souvenirsDetailView];
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
