//
//  StoreLayer.m
//  collector
//
//  Created by Kain Osterholt on 3/15/11.
//  Copyright 2011 C-Stick Run. All rights reserved.
//

#import <StoreKit/StoreKit.h>

#import "StoreLayer.h"
#import "MenuDefs.h"
#import "GameDefs.h"
#import "StoreItemLayer.h"
#import "MainMenuLayer.h"
#import "StoreManager.h"
#import "AudioDefs.h"
#import "LoadingLayer.h"

#import "GameSettings.h"

#import "PlayerNode.h"

@implementation StoreLayer

+(id) scene
{
	CCScene *scene = [CCScene node];
	StoreLayer *layer = [StoreLayer node];
	[scene addChild: layer];
	return scene;
}

-(id)init
{
    self = [super init];
    
    if(self != nil)
    {
        CCMenuItemSprite* exit = 
        [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:BACK_BTN] 
                                selectedSprite:[CCSprite spriteWithFile:BACK_BTN_PRESS]
                                        target:self
                                      selector:@selector(exit:)];
        

        exitMenu = [CCMenu menuWithItems:exit, nil];
        
        [exitMenu alignItemsVerticallyWithPadding:0];
        [exitMenu setPosition:ccp(390, 30)];
        
        [self addChild:exitMenu z:5];
        
        player = [[PlayerNode alloc] init];
        [self addChild:player z:200];
        player.desiredPos = ccp(35, 275);
        player.accelerometerControlled = false;
        player.position = ccp(35, 275);
        [player initParticles];
        [player setOrbits:[GameSettings sharedInstance].numOrbits];
        
        livesLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Lives: %d", [GameSettings sharedInstance].lives]
                                   fontName:@"Futura" fontSize:22];
        [livesLabel setPosition:ccp(60, 25)];
        [self addChild:livesLabel];
        
        [self schedule:@selector(updateObjects:) interval:1.0f/60.0f];
        
        cover = [[LoadingLayer alloc] initWithText:@"Loading Shop..."];
        [self addChild:cover z:500];
        
        productPagesLoaded = false;
        
        [self performSelector:@selector(onStart:) withObject:nil afterDelay:0.8f];
    }
    
    return self;
}

-(void)onStart:(id)sender
{
    PLAY_MUSIC(STORE_MUSIC);
}

-(void)updateObjects:(float)dt
{
    [player updatePlayer:dt];
}

-(void)zipPlayer
{
    id action = [CCMoveTo actionWithDuration:0.5 position:ccp(500, -50)];
    id ease = [CCEaseBackIn actionWithAction:action];
    [player runAction: ease];
}

-(void)exit:(id)sender
{
    [self zipPlayer];
    PLAY_SOUND(ORBIT_PICKUP_SND);
    CCScene* scene = [MainMenuLayer scene];
    
    [[CCDirector sharedDirector] replaceScene: 
     [CCTransitionFade transitionWithDuration:2.0f scene:scene]];
}

-(void)loadPages:(id)sender
{
    [StoreManager sharedInstance].storeDelegate = self;
    [[StoreManager sharedInstance] requestProducts];
}

-(NSString*)titleText
{
    return @"Upgrades";
}

-(void)productsNotAvailable
{
    [self performSelector:@selector(alertNoProducts:) withObject:nil afterDelay:3.0f];
}

-(void)productsLoaded:(NSArray*)products
{
    if(!productPagesLoaded)
    {
        int productCount = [products count];
        
        if( productCount > 0 )
        {
            NSLog(@"Product Request Response received %d products", productCount);
            
            NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
            [numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
            [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
            
            for(SKProduct* product in products)
            {
                [numberFormatter setLocale:product.priceLocale];
                NSString *formattedString = [numberFormatter stringFromNumber:product.price];
                
                NSLog(@"product.productIdentifier: %@", product.productIdentifier);
                NSLog(@"product.localizedDescription: %@", product.localizedDescription);
                NSLog(@"product.localizedTitle: %@", product.localizedTitle);
                NSLog(@"product price: %@", formattedString);
                
                [self addPage: [StoreItemLayer itemWithTitle:product.localizedTitle 
                                                   productID:product.productIdentifier 
                                                 description:product.localizedDescription 
                                                 priceString:formattedString]];
            }
            
            [numberFormatter release];
            
            [cover runAction:[CCFadeOut actionWithDuration:0.5f]];
        
            productPagesLoaded = true;
        }
        else 
        {
            [self alertNoProducts:self];
        }

    }
}

-(void) purchaseRequested
{
    [exitMenu setVisible:NO];
}

-(void) purchaseMade:(NSString*)productID
{
    [exitMenu setVisible:YES];
    
    if([productID compare:ONE_UP_PURCHASE_ID] == NSOrderedSame)
    {
        [livesLabel setString:[NSString stringWithFormat:@"Lives: %d", [GameSettings sharedInstance].lives]];
    }
    else if([productID compare:MAX_ORBITS_PURCHASE_ID] == NSOrderedSame)
    {
        [player setOrbits:[GameSettings sharedInstance].maxOrbits];
    }
    
    if([productID compare:ONE_UP_PURCHASE_ID] != NSOrderedSame)
    {
        StoreItemLayer* itemLayer = (StoreItemLayer*)([self pageForKey:productID]);
        [itemLayer setPurchased];
    }
}

-(void) purchaseFailed:(NSString*)productID error:(NSError*)error
{
    [exitMenu setVisible:YES];
    
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Purchase Failed!"
                                                    message: error.localizedDescription
                                                   delegate: self 
                                          cancelButtonTitle: nil
                                          otherButtonTitles: @"Close", nil];
    
    [alert show];
    [alert release];
}

-(void)alertNoProducts:(id)sender
{
    [cover displayError:@"In app purchases are not available.  Please check your internet connection and try again."];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
}

-(void)dealloc
{
    [StoreManager sharedInstance].storeDelegate = nil;
    [cover release];
    [player release];
    [super dealloc];
}

@end
