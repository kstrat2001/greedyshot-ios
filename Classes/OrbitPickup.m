//
//  OrbitPickup.m
//  collector
//
//  Created by Kain Osterholt on 3/30/11.
//  Copyright 2011 C-Stick Run. All rights reserved.
//

#import "OrbitPickup.h"
#import "GameParticles.h"


@implementation OrbitPickup

-(id) init
{
    self = [super init];
    
    if(self != nil)
    {
        objectType = ORBIT_OBJ;
        particles = [[OrbitPickupParticles alloc] init];
        [particles setPosition:ccp(0, 0)];
        [self addChild:particles];
    }
    
    return self;
}

-(NSString*)getTextureName
{
    return @"orbit.png";
}

-(void)updateCoin:(float)dt
{
    lifeSpan -= dt;
    
    [self updateBlink];
    
    if(lifeSpan < 0)
        isAlive = false;
}


@end
