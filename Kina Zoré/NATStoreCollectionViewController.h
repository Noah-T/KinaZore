//
//  NATStoreCollectionViewController.h
//  Kina Zoré
//
//  Created by Noah Teshu on 12/5/14.
//  Copyright (c) 2014 Noah Teshu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NATStoreItem.h"
#import "NATStoreItemCollectionViewCell.h"

@interface NATStoreCollectionViewController : UIViewController

@property (strong, nonatomic) NSArray *itemsForSale;
@property (strong, nonatomic) NSMutableArray *itemsInCart;

- (IBAction)showAlbumDetail:(id)sender;

@end

