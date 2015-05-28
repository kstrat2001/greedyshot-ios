//
//  Coin.m
//  collector
//
//  Created by Kain Osterholt on 3/6/11.
//  Copyright 2011 C-Stick Run. All rights reserved.
//

#import "CoinNode.h"
#import "PlayerNode.h"

@implementation CoinNode

@synthesize isAlive, lifeSpan, isCollected;

-(id) init
{
    self = [super init];
    
    if(self != nil)
    {
        objectType = COIN_OBJ;
        
        coinSprite = [CCSprite spriteWithFile:[self getTextureName]];
        [coinSprite setPosition:ccp(0, 0)];
        [self addChild:coinSprite];
        
        particles = nil;
        
        radius = coinSprite.textureRect.size.width / 2.0f;
        
        accel = ccp(0,0);
        vel = ccp(0,0);
        
        lifeSpan = 0;
        isAlive = true;
        isCollected = false;
        
        blinkState = NO_BLINK;
    }
    
    return self;
}

-(NSString*)getTextureName
{
    return @"coin.png";
}

-(void)updateCoin:(float)dt
{
    lifeSpan -= dt;
    
    [self updateBlink];
    
    vel = ccpAdd(ccpMult(accel, dt), vel);
    [self setPosition:ccpAdd(self.position, ccpMult(vel, dt))];
    
    if(lifeSpan < 0)
        isAlive = false;
}

-(void)updateAcceleration:(PlayerNode*)player
{
    CGPoint dir = ccpNormalize(ccpSub(player.position, self.position));
    float distSq = [self distanceToObjectSquared:player] + 10;
    dir = ccpMult(dir, 1/distSq);
    
    accel = ccpMult(dir, [player getGravity]);
}

// override sets the coin collected
-(void)hitPlayer:(PlayerNode*)player
{
    if(player.isAlive)
    {
        isCollected = true;
    }
}

-(void)updateBlink
{
    if(lifeSpan < 2.0f && blinkState < BLINK_FAST)
    {
        blinkState = BLINK_FAST;
        [self unschedule:@selector(blink:)];
        [self schedule:@selector(blink:) interval:0.025f];
    }
    else if(lifeSpan < 5.0f && blinkState < BLINK_SLOW)
    {
        blinkState = BLINK_SLOW;
        [self schedule:@selector(blink:) interval:0.05];
    }
}

-(void)blink:(float)dt
{
    GLubyte target = 255;
    
    if(lifeSpan < 2.0f)
        target = 128;
    
    if(coinSprite.opacity == target)
    {
        [coinSprite setOpacity:target - 128];
        
        if( particles != nil)
            [particles setVisible:NO];
    }
    else 
    {
        [coinSprite setOpacity:target];
        
        if( particles != nil)
            [particles setVisible:YES];
    }
    
}

-(void)dealloc
{
    if(particles != nil)
        [particles release];
    
    [super dealloc];
}


@end
