//
//  StoreItemLayer.m
//  collector
//
//  Created by Kain Osterholt on 3/15/11.
//  Copyright 2011 C-Stick Run. All rights reserved.
//

#import "StoreItemLayer.h"
#import "MenuDefs.h"
#import "GameSettings.h"
#import "StoreLayer.h"
#import "AudioDefs.h"
#import "StoreManager.h"

@implementation StoreItemLayer

-(id) initWithTitle:(NSString*)title
          productID:(NSString*)pid
        description:(NSString*)desc
        priceString:(NSString*)priceStr
{
    self = [super init];
    
    if(self != nil)
    {
        CCLabelTTF* itemName = [CCLabelTTF labelWithString:title
                                                  fontName:STORE_ITEM_FONT
                                                  fontSize:24];
        [self addChild:itemName z:10];
        [itemName setPosition:ccp(240, 248)];
        
        CCLabelTTF* itemDesc = [CCLabelTTF labelWithString:desc
                                                dimensions:CGSizeMake(325, 290)
                                                 alignment:UITextAlignmentCenter
                                                  fontName:@"Helvetica" fontSize:19];
        [self addChild:itemDesc z:100];
        [itemDesc setPosition:ccp(240, 79)];
        
        if([[GameSettings sharedInstance] isItemPurchased:pid])
        {
            [self initPurchasedLabel];
        }
        else
        {
            [self initBuyButton];
            [self initPriceLabel:priceStr];
        }
        
        productID = [[NSString alloc] initWithString:pid];
        self.pageName = productID;
        
    }
    
    return self;
}

-(void)initPriceLabel:(NSString*)priceStr
{
    priceLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Price: %@", priceStr]
                                               fontName:STORE_ITEM_FONT
                                               fontSize:20];
    [self addChild:priceLabel z:10];
    [priceLabel setColor:ccGREEN];
    [priceLabel setPosition:ccp(240, 115)];
}

-(void)initBuyButton
{
    CCMenuItemSprite* buy = 
    [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:PURCHASE] 
                            selectedSprite:[CCSprite spriteWithFile:PURCHASE_PRESS]
                                    target:self
                                  selector:@selector(buy:)];
    
    
    buyMenu = [CCMenu menuWithItems:buy, nil];
    
    [buyMenu alignItemsVerticallyWithPadding:0];
    [buyMenu setPosition:ccp(240, 75)];
    
    [self addChild:buyMenu z:5];
}

-(void)initPurchasedLabel
{
    CCLabelTTF* purchased = [CCLabelTTF labelWithString:@"Owned" fontName:@"Helvetica" fontSize:MENU_BUY_BTN_SIZE];
    [purchased setPosition:ccp(240, 75)];
    [purchased setColor:ccORANGE];
    [self addChild:purchased z:20];
}

-(void)setPurchased
{
    [self removeChild:buyMenu cleanup:YES];
    [self removeChild:priceLabel cleanup:YES];
    
    [self initPurchasedLabel];
}

-(void)buy:(id)sender
{
    PLAY_SOUND(MENU_SELECT_SND);
    [[StoreManager sharedInstance] purchaseItem:productID];
}

+ (StoreItemLayer*)itemWithTitle:(NSString*)title
                       productID:(NSString*)pid
                     description:(NSString*)desc
                     priceString:(NSString*)priceStr
{
    return [[[StoreItemLayer alloc] initWithTitle:title productID:pid description:desc priceString:priceStr] autorelease];
}

-(void)dealloc
{
    [productID release];
    [super dealloc];
}

@end
