//
//  Projectile.h
//  collector
//
//  Created by Kain Osterholt on 3/6/11.
//  Copyright 2011 C-Stick Run. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameObject.h"

typedef enum ProjectileType {
    BASIC_BULLET,
    POWER_BULLET
    
} ProjectileType;

@interface ProjectileNode : GameObject <GameObjectDelegate>{

    CGPoint destination;
    CGPoint direction;
    float speed;
    
    float lifeSpan;
    bool isAlive;
}

@property (nonatomic, readonly) bool isAlive;

-(id)initWithSpeed:(float)spd position:(CGPoint)pos destination:(CGPoint)dest;

-(void)updateProjectile:(float)dt;

@end
