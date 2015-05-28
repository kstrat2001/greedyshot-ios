//
//  GameObject.m
//  collector
//
//  Created by Kain Osterholt on 3/6/11.
//  Copyright 2011 C-Stick Run. All rights reserved.
//

#import "GameObject.h"
#import "PlayerNode.h"
#import "GameObjectDelegate.h"

@implementation GameObject

@synthesize radius, objectDelegate, objectType;

-(id) init
{
    self = [super init];
    
    if(self != nil)
    {
        objectType = UNKOWN_OBJ;
        radius = 0;
        objectDelegate = nil;
    }
    
    return self;
}

-(NSString*) getTextureName
{
    return @"black.png";
}

-(bool) collidesWithObject:(GameObject*)object
{
    bool retval = false;
    
    if( ( self.position.x - self.radius ) > ( object.position.x + object.radius ) ) 
    {
        retval = false;
    }
    else if( ( self.position.x + self.radius ) < ( object.position.x - object.radius ) )
    {
        retval = false;
    }
    else if( ( self.position.y + self.radius ) < ( object.position.y - object.radius ) )
    {
        retval = false;
    }
    else if( ( self.position.y - self.radius ) > ( object.position.y + object.radius ) )
    {
        retval = false;
    }
    else if(radius > 0)
    {
        float scaledRadius = self.radius * self.scale;
        float objScaledRadius = object.radius * object.scale;
        
        float sqDist = [self distanceToObjectSquared:object];
        float maxDist = scaledRadius + objScaledRadius;
        float maxDistSq = maxDist * maxDist;
        
        retval = (sqDist < maxDistSq);
    }
    
    return retval;
}

-(void) performCollisionCallback:(GameObject*)object
{
    if(objectDelegate != nil)
    {
        [objectDelegate collide:object];
    }   
}

-(void)hitPlayer:(PlayerNode*)player
{
    // Override this
}

-(void)shotByPlayer
{
    // Override this
}

-(float) distanceToObjectSquared:(GameObject*)object
{
    float dx = self.position.x - object.position.x;
    float dy = self.position.y - object.position.y;
    
    return (dx * dx) + (dy * dy);
}

-(float) distanceToObject:(GameObject*)object
{
    return sqrt([self distanceToObjectSquared:object]);
}

@end
