//
//  ProjectileManager.h
//  collector
//
//  Created by Kain Osterholt on 3/6/11.
//  Copyright 2011 C-Stick Run. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProjectileNode.h"
#import "ProjectileDelegate.h"

@interface ProjectileManager : NSObject 
{
    NSMutableArray* projectiles;
    NSMutableArray* projectilesToKill;
    
    id<ProjectileDelegate> projectileDelegate;
}

@property (nonatomic, assign) id<ProjectileDelegate> projectileDelegate;

-(ProjectileNode*) createProjectile:(ProjectileType)type 
            withPosition:(CGPoint)position
           atDestination:(CGPoint)destination
               withSpeed:(float)speed;

-(void)updateProjectiles:(float)dt;

-(NSMutableArray*) getProjectiles;
                      
@end
