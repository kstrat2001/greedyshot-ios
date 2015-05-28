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
#import "cocos2d.h"

@interface Reticle : GameObject
{
    CCSprite* reticleSprite;
    
    CGPoint desiredPos;
    
    bool accelerometerControlled;
}

@property (nonatomic, assign) CGPoint desiredPos;
@property (nonatomic, assign) bool accelerometerControlled;

-(void)updateReticle:(float)dt;

@end
