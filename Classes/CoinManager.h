//
//  CoinManager.h
//  collector
//
//  Created by Kain Osterholt on 3/6/11.
//  Copyright 2011 C-Stick Run. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoinDelegate.h"
#import "GameObject.h"

@class CoinNode;
@class PlayerNode;

@interface CoinManager : NSObject {

    NSMutableArray* coins;
    NSMutableArray* coinsToKill;
    
    id<CoinDelegate> coinDelegate;
}

@property (nonatomic, assign) id<CoinDelegate> coinDelegate;

-(CoinNode*)createCoin:(ObjectType)pickupType location:(CGPoint)location lifeSpan:(float)lifeSpan;
-(void)applyGravity:(PlayerNode*)player;
-(void)updateCoins:(float)dt;

-(int) numCoins;

@end
