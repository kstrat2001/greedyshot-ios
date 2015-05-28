//
//  HelloWorldScene.h
//  collector
//
//  Created by Kain Osterholt on 2/24/11.
//  Copyright C-Stick Run 2011. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

#import "ProjectileDelegate.h"
#import "CoinDelegate.h"
#import "AsteroidDelegate.h"
#import "PlayerDelegate.h"
#import "RootViewDelegate.h"
#import "UIGameLayer.h"

@class CollisionManager;
@class ProjectileManager;
@class CoinManager;
@class AsteroidManager;
@class PlayerNode;
@class LowpassFilter;
@class Reticle;

// HelloWorld Layer
@interface GameLayer : CCLayer <ProjectileDelegate,
                                CoinDelegate,
                                AsteroidDelegate,
                                PlayerDelegate,
                                RootViewDelegate>
{
    CollisionManager* collisionMgr;
    ProjectileManager* projectileMgr;
    CoinManager* coinManager;
    AsteroidManager* asteroidManager;
    
    LowpassFilter* accFilter;
    
    Reticle* reticle;
    
    PlayerNode* player;
    
    UIGameLayer* uiLayer;
    
    float fireTimer;
    int fireIndex;
    NSMutableArray* shots;
    
    bool suspended;
    
    bool orbitInPlay;
    bool fieroInPlay;
    
    int level;
    int goal;
    
    float fieroChance;
    float orbitChance;
}

@property (nonatomic, assign) bool suspended;

// returns a Scene that contains the HelloWorld as the only child
+(id) scene;

-(bool) checkEndOfLevelScenario;

-(void)spawnAsteroid;
-(void)genAsteroid:(CGPoint)position direction:(CGPoint)dir speed:(float)spd scale:(float)scl;

-(void)fireProjectile:(CGPoint)target;
-(void) updateRapidFire:(float)dt;

@end
