//
//  NATStoreItem.m
//  Kina Zoré
//
//  Created by Noah Teshu on 12/5/14.
//  Copyright (c) 2014 Noah Teshu. All rights reserved.
//

#import "NATStoreItem.h"

@implementation NATStoreItem

-(instancetype)initWithImage:(UIImage *)image description:(NSString *)description price:(float)price
{
    self = [super init];
    
    _itemImage = image;
    _itemDescription = description;
    _itemPrice = price;
    
    return self;
}

@end
