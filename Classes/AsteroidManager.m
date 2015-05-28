//
//  AsteroidManager.m
//  collector
//
//  Created by Kain Osterholt on 3/6/11.
//  Copyright 2011 C-Stick Run. All rights reserved.
//

#import "AsteroidManager.h"
#import "AsteroidNode.h"
#import "ProjectileNode.h"

@implementation AsteroidManager

@synthesize asteroidDelegate;

-(id) init
{
    self = [super init];
    
    if(self != nil)
    {
        asteroids = [[NSMutableArray alloc] initWithCapacity:100];
        asteroidsToKill = [[NSMutableArray alloc] initWithCapacity:100];
        asteroidsShot = [[NSMutableArray alloc] initWithCapacity:100];
        
        asteroidDelegate = nil;
        
        killed = 0;
        shot = 0;
        spawned = 0;
    }
    
    return self;
}

-(void)shootAllAsteroids
{
    for(AsteroidNode* ast in asteroids)
    {
        [ast shotByPlayer];
    }
}

-(int)numAsteroids
{
    return [asteroids count];
}

-(AsteroidNode*)createAsteroid:(NSString*)texture
                      position:(CGPoint)location 
                     direction:(CGPoint)dir
                      speed:(float)speed
{
    AsteroidNode* asteroid = [[AsteroidNode alloc] initWithSpeed:speed 
                                                       direction:dir 
                                                        position:location
                                                         texture:texture];
    [asteroids addObject:asteroid];
    
    ++spawned;
    //NSLog(@"Adding asteroid. num: %d, shot: %d, killed: %d, spawned: %d", [self numAsteroids], shot, killed, spawned);
    
    return asteroid;
}

-(void)updateAsteroids:(float)dt
{
    for(AsteroidNode* asteroid in asteroids)
    {
        [asteroid updateAsteroid:dt];
        
        if(asteroid.isShot == true)
        {
            [asteroidsShot addObject:asteroid];
        }
        else if(asteroid.isAlive == false)
        {
            [asteroidsToKill addObject:asteroid];
        }
    }
    
    for(AsteroidNode* ast in asteroidsShot)
    {
        if(asteroidDelegate != nil)
            [asteroidDelegate asteroidWasShot:ast];
        
        [ast release];
        [asteroids removeObject: ast];
        
        ++shot;
        //NSLog(@"Shot asteroid. num: %d, shot: %d, killed: %d, spawned: %d", [self numAsteroids], shot, killed, spawned);
    }
    
    for (AsteroidNode* ast in asteroidsToKill)
    {
        if(asteroidDelegate != nil)
            [asteroidDelegate asteroidDied:ast];
        
        [ast release];
        [asteroids removeObject:ast];
        
        killed++;
        //NSLog(@"Killed asteroid. num: %d, shot: %d, killed: %d, spawned: %d", [self numAsteroids], shot, killed, spawned);
    }
    
    [asteroidsToKill removeAllObjects];
    [asteroidsShot removeAllObjects];
}

-(void)dealloc
{
    [asteroids release];
    [asteroidsShot release];
    [asteroidsToKill release];
    [super dealloc];
}

@end
