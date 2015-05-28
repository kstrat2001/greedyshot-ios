//
//  AsteroidNode.h
//  collector
//
//  Created by Kain Osterholt on 3/6/11.
//  Copyright 2011 C-Stick Run. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameObject.h"
#import "cocos2d.h"

@interface AsteroidNode : GameObject 
{
    CCSprite* asteroidSprite;
    
    CGPoint direction;
    float speed;

    bool isAlive;
    bool isShot;
    
    bool hasBeenOnScreen;
    ObjectType pickupType;
}

@property (nonatomic, readonly) bool isAlive;
@property (nonatomic, assign) bool isShot;
@property (nonatomic, assign) ObjectType pickupType;
@property (nonatomic, readonly) float speed;
@property (nonatomic, readonly) CGPoint direction;

-(id) initWithSpeed:(float)speed direction:(CGPoint)direction position:(CGPoint)pos texture:(NSString*)tex;
-(void)updateAsteroid:(float)dt;

-(void)shotByPlayer;

-(int) numAsteroidSpawns;
-(bool)shouldSpawnPickup;

@end
