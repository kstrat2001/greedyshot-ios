//
//  ProjectileManager.m
//  collector
//
//  Created by Kain Osterholt on 3/6/11.
//  Copyright 2011 C-Stick Run. All rights reserved.
//

#import "ProjectileManager.h"

@interface ProjectileManager (hidden)

-(ProjectileNode*) createBasicBullet:(CGPoint)position dest:(CGPoint)destination withSpeed:(float)speed;

@end

@implementation ProjectileManager (hidden)

-(ProjectileNode*) createBasicBullet:(CGPoint)position dest:(CGPoint)destination withSpeed:(float)speed
{
    ProjectileNode* proj = [[ProjectileNode alloc] initWithSpeed:speed position:position destination:destination];
    return proj;
}

@end

@implementation ProjectileManager

@synthesize projectileDelegate;

-(id) init
{
    self = [super init];
    
    if(self != nil)
    {
        projectiles = [[NSMutableArray alloc] initWithCapacity:50];
        projectilesToKill = [[NSMutableArray alloc] initWithCapacity:50];
    }
    
    return self;
}

-(ProjectileNode*) createProjectile:(ProjectileType)type 
            withPosition:(CGPoint)position
           atDestination:(CGPoint)destination
               withSpeed:(float)speed
{
    ProjectileNode* projectile = nil;
    
    switch (type) 
    {
        case BASIC_BULLET:
        {
            projectile = [self createBasicBullet:position dest:destination withSpeed:speed];
        }   
        break;
            
        default:
        break;
    }
    
    assert(projectile != nil);
    [projectiles addObject:projectile];
    
    return projectile;
}

-(void)updateProjectiles:(float)dt
{
    for (ProjectileNode* proj in projectiles)
    {
        [proj updateProjectile:dt];
        
        if(proj.isAlive == false)
        {
            if(projectileDelegate != nil)
                [projectileDelegate projectileDied:proj];
            
            [projectilesToKill addObject:proj];
        }
    }
    
    for (ProjectileNode* proj in projectilesToKill)
    {
        [projectiles removeObject:proj];
        [proj release];
    }
    
    [projectilesToKill removeAllObjects];
}

-(NSMutableArray*) getProjectiles
{
    return projectiles;
}

-(void)dealloc
{
    [projectiles release];
    
    [super dealloc];
}

@end
