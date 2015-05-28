//
//  PlayerNode.m
//  collector
//
//  Created by Kain Osterholt on 3/6/11.
//  Copyright 2011 C-Stick Run. All rights reserved.
//

#import "PlayerNode.h"
#import "CoinNode.h"
#import "GameDefs.h"
#import "GameSettings.h"
#import "GameParticles.h"
#import "OrbitNode.h"

#define M_PI_X_2 (float)M_PI * 2.0f

@implementation PlayerNode

@synthesize desiredPos, playerDelegate, isAlive, accelerometerControlled;

-(id) init
{
    self = [super init];
    
    if(self != nil)
    {
        objectType = PLAYER_OBJ;
        
        playerSprite = [CCSprite spriteWithFile:@"player.png"];
        [playerSprite setPosition:ccp(0, 0)];
        [self addChild:playerSprite];
        
        orbitParent = [CCNode node];
        [self addChild:orbitParent];
        
        desiredPos = ccp(240, 160);
        
        orbits = [[NSMutableArray alloc] init];
        
        radius = (playerSprite.textureRect.size.width / 2.0f) - 3;
        
        [self setOrbits:[GameSettings sharedInstance].numOrbits];
        
        self.objectDelegate = self;
        
        orbitExplosion = nil;
        playerTrail = nil;
        
        isAlive = true;
        accelerometerControlled = true;
    }
    
    return self;
}

-(void)initParticles
{
    playerTrail = [[PlayerTrailParticles alloc] init];
    [self.parent addChild:playerTrail z:5];
}

-(void)removeParticles
{
    [self.parent removeChild:playerTrail cleanup:YES];
}

-(void) setOrbits:(int)numOrbits
{
    bool add = numOrbits > [orbits count];
    int dif = abs(numOrbits - [orbits count]);
    
    for(int i = 0; i < dif; ++i)
    {
        if(add)
            [self addOrbit];
        else
            [self removeOrbit:false];
    }
}

-(float)getGravity
{
    return ORBITAL_PULL * (1 + [self numOrbits]);
}

-(void)updatePlayer:(float)dt
{
    if(accelerometerControlled)
    {
        CGPoint pos = self.position;
        float spd = 10;
        CGPoint newPos = ccp(pos.x + ((desiredPos.x - pos.x) * dt * spd), pos.y + ((desiredPos.y - pos.y) * dt * spd));
        [self setPosition:newPos];
    }
    
    if(playerTrail != nil)
        [playerTrail setPosition:self.position];
    
    for(OrbitNode* node in orbits)
    {
        [node updateOrbit:dt];
    }
    
    float degPerSecond = (90.0f) * [orbits count];
    [orbitParent setRotation:[orbitParent rotation] + (dt * degPerSecond)];
}

-(void)addOrbit
{
    if([orbits count] < [GameSettings sharedInstance].maxOrbits)
    {
        OrbitNode* orbit = [OrbitNode node];
        [orbits addObject:orbit];
        [orbitParent addChild:orbit];
        
        [self updateOrbitPositions];
    }
}

-(int)numOrbits
{
    return [orbits count];
}

-(bool)isInjured
{
    return ([orbits count] < [GameSettings sharedInstance].maxOrbits);
}

-(void)removeOrbit:(bool)explode
{
    if([orbits count] > 0)
    {
        OrbitNode* orbit = [orbits objectAtIndex:0];
        CGPoint pos = [orbit convertToWorldSpace:CGPointZero];
        
        if(orbitExplosion != nil)
        {
            [[self parent] removeChild:orbitExplosion cleanup:YES];
            [orbitExplosion release];
        }
        
        orbitExplosion = [[OrbitExplosionParticles alloc] init];
        [orbitExplosion setPosition:pos];
        [[self parent] addChild:orbitExplosion];
        
        [orbitParent removeChild:orbit cleanup:YES];
        [orbits removeObjectAtIndex:0];
        
        [self updateOrbitPositions];
    }
}

-(void) updateOrbitPositions
{
    int numOrbits = [orbits count];
    float dAngle;
    if(numOrbits > 0)
       dAngle = M_PI_X_2 / numOrbits;
    else 
        dAngle = 0;

    float angle = 0;
    for(OrbitNode* node in orbits)
    {
        node.angleOffset = angle;
        angle += dAngle;
    }
}

#pragma mark GameObject delegate impl

-(void)collide:(GameObject*)object
{
    if(object.objectType == ASTEROID_OBJ)
    {
        [playerDelegate playerHitAsteroid];
    }
    
    [object hitPlayer:self];
}
                  
-(void)dealloc
{
    [orbits removeAllObjects];
    
    if(playerTrail != nil)
        [playerTrail release];
    
    [orbits release];
    
    [super dealloc];
}

@end
