//
//  Projectile.m
//  collector
//
//  Created by Kain Osterholt on 3/6/11.
//  Copyright 2011 C-Stick Run. All rights reserved.
//

#import "ProjectileNode.h"
#import "AsteroidNode.h"

@implementation ProjectileNode

@synthesize isAlive;

-(id)initWithSpeed:(float)spd position:(CGPoint)pos destination:(CGPoint)dest
{
    self = [super init];
    
    if(self != nil)
    {
        objectType = PROJECTILE_OBJ;
        
        CCSprite* projSprite = [CCSprite spriteWithFile:@"laser.png"];
        [projSprite setPosition:ccp(0, 0)];
        [self addChild:projSprite];
        
        self.position = pos;
        
        radius = projSprite.textureRect.size.height / 2.0f;
        
        self.objectDelegate = self;
         
        destination = dest;
        direction = ccpNormalize(ccpSub(dest, pos));
        speed = spd;
        
        float angle = 0;
        
        if(direction.x > 0)
        {
            angle = acos(ccpDot(direction, ccp(1, 0))) * 57.3;
            
            if(direction.y > 0)
                angle = -angle;
        }
        else
        {
            angle = acos(ccpDot(direction, ccp(-1, 0))) * 57.3 + 180;
            
            if(direction.y < 0)
                angle = -angle;
        }
        
        [projSprite setRotation:angle];
        
        lifeSpan = 480 / spd;
        isAlive = true;
    }
    
    return self;
}
         
-(void)updateProjectile:(float)dt
 {
     CGPoint dPos = ccpMult(direction, speed * dt);
     [self setPosition:ccpAdd(dPos, self.position)];
     
     lifeSpan -= dt;
     
     if(lifeSpan < 0)
         isAlive = false;
 }

-(void)collide:(GameObject *)obj
{
    if (obj.objectType == ASTEROID_OBJ)
    {
        [obj shotByPlayer];
        isAlive = false;
    }
}

@end
