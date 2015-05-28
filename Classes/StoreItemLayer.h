//
//  StoreItemLayer.h
//  collector
//
//  Created by Kain Osterholt on 3/15/11.
//  Copyright 2011 C-Stick Run. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#import "PageLayer.h"
#import "StoreManagerDelegate.h"

@interface StoreItemLayer : PageLayer <StoreManagerDelegate>
{
    NSString* productID;
    
    CCLabelTTF* priceLabel;
    CCMenu* buyMenu;
}

-(void)initPriceLabel:(NSString*)priceStr;
-(void)initBuyButton;
-(void)initPurchasedLabel;

-(void)setPurchased;

+ (StoreItemLayer*)itemWithTitle:(NSString*)title 
                       productID:(NSString*)pid
                     description:(NSString*)desc
                     priceString:(NSString*)priceStr;

-(id) initWithTitle:(NSString*)title
          productID:(NSString*)pid
        description:(NSString*)desc
        priceString:(NSString*)priceStr;

@end
