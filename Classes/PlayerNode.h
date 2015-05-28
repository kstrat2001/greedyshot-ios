//
//  PlayerNode.h
//  collector
//
//  Created by Kain Osterholt on 3/6/11.
//  Copyright 2011 C-Stick Run. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameObject.h"
#import "GameObjectDelegate.h"
#import "PlayerDelegate.h"
#import "cocos2d.h"

@class OrbitExplosionParticles;
@class PlayerTrailParticles;

@interface PlayerNode : GameObject <GameObjectDelegate>
{
    CCSprite* playerSprite;
    NSMutableArray* orbits;
    
    CGPoint desiredPos;
    
    id<PlayerDelegate> playerDelegate;
    
    CCNode* orbitParent;
    OrbitExplosionParticles* orbitExplosion;
    
    PlayerTrailParticles* playerTrail;
    
    bool isAlive;
    bool accelerometerControlled;
}

@property (nonatomic, assign) id<PlayerDelegate> playerDelegate;
@property (nonatomic, assign) CGPoint desiredPos;
@property (nonatomic, assign) bool isAlive;
@property (nonatomic, assign) bool accelerometerControlled;

-(void)initParticles;
-(void)removeParticles;
-(void)updatePlayer:(float)dt;
-(void)addOrbit;
-(int) numOrbits;
-(float)getGravity;
-(void) removeOrbit:(bool)explode;
-(void) setOrbits:(int)numOrbits;

-(bool)isInjured;

-(void) updateOrbitPositions;

@end
