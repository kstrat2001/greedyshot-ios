//
//  CollisionManager.h
//  collector
//
//  Created by Kain Osterholt on 3/6/11.
//  Copyright 2011 C-Stick Run. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GameObject;

@interface CollisionManager : NSObject
{
    NSMutableArray* objects;
    NSMutableArray* collidedObjects;
}

-(void) addObject:(GameObject*)object;
-(void) removeObject:(GameObject*)object;

-(void)performCollisionCheck:(GameObject*)object;
-(void)performArrayCollisionCheck:(NSMutableArray*)objects;

@end
