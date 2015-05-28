//
//  AsteroidManager.h
//  collector
//
//  Created by Kain Osterholt on 3/6/11.
//  Copyright 2011 C-Stick Run. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AsteroidDelegate.h"

@class AsteroidNode;

@interface AsteroidManager : NSObject {
    
    NSMutableArray* asteroids;
    NSMutableArray* asteroidsToKill;
    NSMutableArray* asteroidsShot;
    
    id<AsteroidDelegate> asteroidDelegate;
    
    int killed;
    int shot;
    int spawned;
}

@property (nonatomic, assign) id<AsteroidDelegate> asteroidDelegate;

-(AsteroidNode*)createAsteroid:(NSString*)texture
                      position:(CGPoint)location 
                     direction:(CGPoint)dir
                      speed:(float)speed;

-(void)updateAsteroids:(float)dt;

-(void)shootAllAsteroids;
-(int)numAsteroids;

@end
    
