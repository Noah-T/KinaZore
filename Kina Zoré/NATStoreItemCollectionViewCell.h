//
//  NATStoreItemCollectionViewCell.h
//  Kina Zoré
//
//  Created by Noah Teshu on 12/5/14.
//  Copyright (c) 2014 Noah Teshu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NATStoreItemCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *itemImage;
@property (weak, nonatomic) IBOutlet UILabel *itemDescription;
@property (weak, nonatomic) IBOutlet UILabel *itemPrice;

@end
