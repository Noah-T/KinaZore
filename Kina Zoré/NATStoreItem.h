//
//  NATStoreItem.h
//  Kina Zoré
//
//  Created by Noah Teshu on 12/5/14.
//  Copyright (c) 2014 Noah Teshu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NATStoreItem : NSObject
@property (strong, nonatomic) UIImage *itemImage;
@property (strong, nonatomic) NSString *itemDescription;
@property (nonatomic) float itemPrice;

- (instancetype)initWithImage:(UIImage *)image description:(NSString *)description price:(float)price;

@end
