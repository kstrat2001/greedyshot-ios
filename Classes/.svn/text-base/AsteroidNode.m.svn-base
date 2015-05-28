//
//  AsteroidNode.m
//  collector
//
//  Created by Kain Osterholt on 3/6/11.
//  Copyright 2011 C-Stick Run. All rights reserved.
//

#import "AsteroidNode.h"

@implementation AsteroidNode

@synthesize isAlive, isShot, speed, direction, pickupType;

-(id) initWithSpeed:(float)spd direction:(CGPoint)dir position:(CGPoint)pos texture:(NSString*)tex;
{
    self = [super init];
    
    if(self != nil)
    {
        objectType = ASTEROID_OBJ;
        
        asteroidSprite = [CCSprite spriteWithFile:tex];
        [asteroidSprite setPosition:ccp(0, 0)];
        [self addChild:asteroidSprite];
        
        radius = asteroidSprite.textureRect.size.width / 2.0f;

        isAlive = true;
        
        speed = spd;
        direction = ccpNormalize(dir);
        self.position = pos;
        
        hasBeenOnScreen = false;
        
        pickupType = COIN_OBJ;
    }
    
    return self;
}

-(void) shotByPlayer
{
    isShot = true;
}

-(void) hitPlayer:(PlayerNode*)player
{
    isAlive = false;
}

-(void)updateAsteroid:(float)dt
{
    [self setPosition:ccpAdd(self.position, ccpMult(direction, dt * speed))];
    
    float size = self.radius * self.scale;
    bool left = self.position.x < (size);
    bool right = self.position.x > (size + 480);
    bool top = self.position.y > (size + 320);
    bool bot = self.position.y < size;

    bool outsideScreen = (left || right || top || bot);
    hasBeenOnScreen |= !outsideScreen;
    
    if(hasBeenOnScreen && outsideScreen)
        isAlive = false;
    
    if(ccpDistance(self.position, ccp(240, 160)) > 300 + size)
        isAlive = false;
}

-(int) numAsteroidSpawns
{
    float randScale = (rand() % 1000 - 500) / 5000.0f;
    float newScale = self.scale * (0.5f + randScale);
    
    return (int)(newScale * 5);
}

-(bool)shouldSpawnPickup
{
    return self.scale > 0.4;
}

@end
