//
//  GameObject.h
//  collector
//
//  Created by Kain Osterholt on 3/6/11.
//  Copyright 2011 C-Stick Run. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameObjectDelegate.h"

@class PlayerNode;

typedef enum ObjectType {
    UNKOWN_OBJ,
    PLAYER_OBJ,
    COIN_OBJ,
    ORBIT_OBJ,
    FIERO_OBJ,
    ASTEROID_OBJ,
    PROJECTILE_OBJ
} ObjectType;

@interface GameObject : CCNode
{
    ObjectType objectType;
    float radius;
    
    id<GameObjectDelegate> objectDelegate;
}

@property (nonatomic, readonly) float radius;
@property (nonatomic, readonly) ObjectType objectType;
@property (nonatomic, assign) id<GameObjectDelegate> objectDelegate;

-(NSString*) getTextureName;

-(float) distanceToObjectSquared:(GameObject*)object;
-(float) distanceToObject:(GameObject*)object;

-(bool) collidesWithObject:(GameObject*)object;
-(void) performCollisionCallback:(GameObject*)object;

-(void)hitPlayer:(PlayerNode*)player;
-(void)shotByPlayer;

@end
