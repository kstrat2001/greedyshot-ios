//
//  CollisionManager.m
//  collector
//
//  Created by Kain Osterholt on 3/6/11.
//  Copyright 2011 C-Stick Run. All rights reserved.
//

#import "CollisionManager.h"
#import "GameObject.h"

@implementation CollisionManager

-(id) init
{
    self = [super init];
    
    if(self != nil)
    {
        objects = [[NSMutableArray alloc] initWithCapacity:100];
        collidedObjects = [[NSMutableArray alloc] initWithCapacity:100];
    }
    
    return self;
}

-(void)addObject:(GameObject*)object
{
    [objects addObject:object];
}

-(void)removeObject:(GameObject*)object
{
    [objects removeObject:object];
}

-(void)performCollisionCheck:(GameObject*)object
{
    for(GameObject* obj in objects)
    {
        if(obj != object)
        {
            if([object collidesWithObject:obj])
            {
                [collidedObjects addObject:obj];
            }
        }
    }
    
    for(GameObject* obj in collidedObjects)
    {
        [object performCollisionCallback:obj];
    }
    
    [collidedObjects removeAllObjects];
}

-(void)performArrayCollisionCheck:(NSMutableArray*)objs
{
    for (GameObject* obj in objs)
    {
        [self performCollisionCheck:obj];
    }
}

-(void)dealloc
{
    [objects release];
    [collidedObjects release];
    [super dealloc];
}

@end
