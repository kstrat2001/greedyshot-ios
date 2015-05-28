//
//  CoinManager.m
//  collector
//
//  Created by Kain Osterholt on 3/6/11.
//  Copyright 2011 C-Stick Run. All rights reserved.
//

#import "CoinManager.h"
#import "PlayerNode.h"
#import "GameObject.h"
#import "CoinNode.h"
#import "FieroPickup.h"
#import "OrbitPickup.h"

@implementation CoinManager

@synthesize coinDelegate;

-(id)init
{
    self = [super init];
    
    if(self != nil)
    {
        coins = [[NSMutableArray alloc] initWithCapacity:100];
        coinsToKill = [[NSMutableArray alloc] initWithCapacity:20];
    }
    
    return self;
}

-(CoinNode*)createCoin:(ObjectType)pickupType location:(CGPoint)location lifeSpan:(float)lifeSpan
{
    CoinNode* coin = nil;
    
    if(pickupType == ORBIT_OBJ)
    {
        coin = [[OrbitPickup alloc] init];
    }
    else if(pickupType == FIERO_OBJ)
    {
        coin = [[FieroPickup alloc] init];
    }
    else
    {
        coin = [[CoinNode alloc] init];
    }
    
    [coins addObject:coin];
    
    [coin setPosition:location];
    coin.lifeSpan = lifeSpan;
    
    return coin;
}

-(int)numCoins
{
    return [coins count];
}

-(void)applyGravity:(PlayerNode*)player
{
    if(player.isAlive == true)
    {
        for(CoinNode* coin in coins)
        {
            [coin updateAcceleration:player];
        }
    }
}

-(void)updateCoins:(float)dt
{
    for(CoinNode* coin in coins)
    {
        [coin updateCoin:dt];
        
        if(coin.isAlive == false)
        {
            [coinDelegate coinDied:coin];
            [coinsToKill addObject:coin];
        }
        else if(coin.isCollected)
        {
            [coinDelegate coinCollected:coin];
            [coinsToKill addObject:coin];
        }
    }
    
    for (CoinNode* coin in coinsToKill)
    {
        [coins removeObject:coin];
        [coin release];
    }
    
    [coinsToKill removeAllObjects];
}

-(void)dealloc
{
    [coins release];
    [coinsToKill release];
    [super dealloc];
}

@end
