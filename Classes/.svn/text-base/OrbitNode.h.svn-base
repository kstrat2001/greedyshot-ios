//
//  OrbitNode.h
//  collector
//
//  Created by Kain Osterholt on 3/12/11.
//  Copyright 2011 C-Stick Run. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class OrbitTrailParticles;

@interface OrbitNode : CCNode {

    CCSprite* orbitSprite;
    //OrbitTrailParticles* particles;
    
    float angleOffset;
    float positionalAngle;
}

//@property (nonatomic, readonly) OrbitTrailParticles* particles;
@property (nonatomic, assign) float angleOffset;
@property (nonatomic, readonly) float positionalAngle;

-(void)updateOrbit:(float)dt;
//-(void)setParticlePosition:(CGPoint)pos;

@end
