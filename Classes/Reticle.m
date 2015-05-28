//
//  PlayerNode.m
//  collector
//
//  Created by Kain Osterholt on 3/6/11.
//  Copyright 2011 C-Stick Run. All rights reserved.
//

#import "Reticle.h"

@implementation Reticle

@synthesize desiredPos, accelerometerControlled;

-(id) init
{
    self = [super init];
    
    if(self != nil)
    {
        objectType = UNKOWN_OBJ;
        
        reticleSprite = [CCSprite spriteWithFile:@"reticle.png"];
        [reticleSprite setPosition:ccp(0, 0)];
        [self addChild:reticleSprite];
        
        desiredPos = ccp(240, 160);

        radius = reticleSprite.textureRect.size.width / 2.0f;
        
        accelerometerControlled = true;
    }
    
    return self;
}

-(void)updateReticle:(float)dt
{
    if(accelerometerControlled)
    {
        CGPoint pos = self.position;
        float spd = 10;
        CGPoint newPos = ccp(pos.x + ((desiredPos.x - pos.x) * dt * spd), pos.y + ((desiredPos.y - pos.y) * dt * spd));
        [self setPosition:newPos];
    }
}

@end
