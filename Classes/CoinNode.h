//
//  Coin.h
//  collector
//
//  Created by Kain Osterholt on 3/6/11.
//  Copyright 2011 C-Stick Run. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#import "GameObject.h"

@class PlayerNode;
@class CCParticleSystem;

typedef enum CoinBlinkState
{
    NO_BLINK,
    BLINK_SLOW,
    BLINK_FAST
} CoinBlinkState;

@interface CoinNode : GameObject
{
    CCSprite* coinSprite;
    CCParticleSystem* particles;
    
    CoinBlinkState blinkState;
    
    CGPoint accel;
    CGPoint vel;
    
    float lifeSpan;
    bool isAlive;
    bool isCollected;
}

@property (nonatomic, readonly) bool isAlive;
@property (nonatomic, readonly) bool isCollected;
@property (nonatomic, assign) float lifeSpan;

-(void)updateAcceleration:(PlayerNode*)player;
-(void)updateCoin:(float)dt;
-(void)updateBlink;

@end
