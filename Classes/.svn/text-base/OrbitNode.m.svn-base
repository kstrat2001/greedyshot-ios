//
//  OrbitNode.m
//  collector
//
//  Created by Kain Osterholt on 3/12/11.
//  Copyright 2011 C-Stick Run. All rights reserved.
//

#import "OrbitNode.h"
#import "GameParticles.h"
#import "GameDefs.h"

@implementation OrbitNode

@synthesize angleOffset, positionalAngle;

-(id) init
{
    self = [super init];
    
    if(self != nil)
    {
        //particles = [[OrbitTrailParticles alloc] init];
        //[particles setPosition:CGPointZero];
        
        CCSprite* orbit = [CCSprite spriteWithFile:@"orbit.png"];
        [self addChild:orbit z:1];
        
        positionalAngle = 0;
        angleOffset = 0;
    }
    
    return self;
}

-(void)setParticlePosition:(CGPoint)pos
{
    //[particles setPosition:pos];
}

-(void)updateOrbit:(float)dt
{
    float dAngle = (angleOffset - positionalAngle);
    positionalAngle += (dAngle * dt * 10.0f);
    
    CGPoint pos = ccp( cosf(positionalAngle) * ORBIT_RADIUS,
                      sinf(positionalAngle) * ORBIT_RADIUS );
    
    [self setPosition: pos];
}

-(void)dealloc
{
    //[particles removeFromParentAndCleanup:YES];
    //[particles release];
    [super dealloc];
}

@end
