//
//  HelloWorldLayer.m
//  collector
//
//  Created by Kain Osterholt on 2/24/11.
//  Copyright C-Stick Run 2011. All rights reserved.
//

// Import the interfaces
#import "GameLayer.h"
#import "GameDefs.h"
#import "CollisionManager.h"
#import "ProjectileManager.h"
#import "CoinManager.h"
#import "AsteroidManager.h"
#import "PlayerNode.h"
#import "GameObject.h"
#import "CoinNode.h"
#import "AsteroidNode.h"
#import "MainMenuLayer.h"
#import "GameParticles.h"
#import "RootViewController.h"
#import "GameSettings.h"
#import "Reticle.h"
#import "GameOverLayer.h"
#import "SummaryLayer.h"
#import "AudioDefs.h"
#import "AudioManager.h"
#import "AccelerometerFilter.h"

// For vibration
#import "AudioToolbox/AudioServices.h"

// HelloWorld implementation
@implementation GameLayer

@synthesize suspended;

+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameLayer *layer = [GameLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
        
        srand((unsigned)([NSDate timeIntervalSinceReferenceDate]));
        
        // enable accelerometer
		self.isAccelerometerEnabled = YES;
        self.isTouchEnabled = YES;
        
        accFilter = [[LowpassFilter alloc] initWithSampleRate:60 cutoffFrequency:70];
        
        collisionMgr = [[CollisionManager alloc] init];
        projectileMgr = [[ProjectileManager alloc] init];
        coinManager = [[CoinManager alloc] init];
        asteroidManager = [[AsteroidManager alloc] init];
        
        player = [[PlayerNode alloc] init];
        [player setOrbits:[GameSettings sharedInstance].numOrbits];
        [self addChild:player z:10];
        [player setPosition:ccp(240, 160)];
        player.desiredPos = ccp(240, 160);
        [player initParticles];
        
        reticle = [[Reticle alloc] init];
        [reticle setPosition:ccp(200, 180)];
        reticle.desiredPos = ccp(200, 180);
        [reticle setVisible:NO];
        [self addChild:reticle z:1000];
        
        projectileMgr.projectileDelegate = self;
        coinManager.coinDelegate = self;
        asteroidManager.asteroidDelegate = self;
        player.playerDelegate = self;
        
        level = [GameSettings sharedInstance].level;
        goal = (level * 20) + 20;
        
        uiLayer = [UIGameLayer node];
        [self addChild:uiLayer z: 200];
        
        [uiLayer setLives:[GameSettings sharedInstance].lives];
        [uiLayer setScore:[GameSettings sharedInstance].gold];
        [uiLayer setGoldInLevel:[GameSettings sharedInstance].goldInLevel withGoal:goal];
        [uiLayer setLevel:level];
        
        [GameSettings sharedInstance].gameInProgress = true;
        [[GameSettings sharedInstance] save];
        
        shots = [[NSMutableArray alloc] initWithCapacity:5];
        fireTimer = 0;
        fireIndex = 0;
        
        self.suspended = true;
        [RootViewController sharedInstance].rootDelegate = self;
        
        orbitInPlay = false;
        fieroInPlay = false;
    
        fieroChance = (12.0f / (level + 1.0f)) + 2.5f;
        orbitChance = (10.0f / (level + 1.0f)) + 0.5f;
        
        [self performSelector:@selector(onStart:) withObject:nil afterDelay:0.8f];
	}
	return self;
}

-(void) onStart:(id)sender
{
    PLAY_MUSIC( GAMEPLAY_MUSIC);
    [reticle setVisible:YES];
}

-(void)rootViewWasSuspended:(BOOL)suspend
{
    self.suspended = suspend;
}

-(void)setSuspended:(_Bool)suspend
{
    suspended = suspend;
    
    if(suspend)
    {
        [self unschedule:@selector(asteroidSpawnFunction:)];
        [self unschedule:@selector(updateGame:)];
        [self schedule:@selector(updateReticle:) interval:1.0f/60.0f];
        
        [shots removeAllObjects];
        player.accelerometerControlled = false;
        [reticle setVisible:YES];
    }
    else 
    {
        [self unschedule:@selector(updateReticle:)];
        [self schedule:@selector(updateGame:) interval:1.0f/60.0f];
        [self schedule:@selector(asteroidSpawnFunction:) interval:1.0f];
        
        player.accelerometerControlled = true;
        [reticle setVisible:NO];
    }

}

-(void)updateReticle:(float)dt
{
    [reticle updateReticle:dt];
    [player updatePlayer:dt];
    
    if([reticle distanceToObject:player] < 5.0)
    {
        self.suspended = false;
    }
}

-(void)updateGame:(float)dt
{
    bool levelOver = [self checkEndOfLevelScenario];
    
    if(levelOver && [coinManager numCoins] == 0 && [asteroidManager numAsteroids] == 0)
    {
        [self unschedule:@selector(updateGame:)];
        [self unschedule:@selector(asteroidSpawnFunction:)];
        
        [GameSettings sharedInstance].numOrbits = [player numOrbits];
        [GameSettings sharedInstance].level++;
        [GameSettings sharedInstance].goldInLevel = 0;
        [[GameSettings sharedInstance] save];
        
        [[CCDirector sharedDirector] replaceScene:
         [CCTransitionFade transitionWithDuration:2.0f scene:[SummaryLayer scene]]];
    }
    
    [player updatePlayer:dt];
    
    [self updateRapidFire:dt];
    
    [projectileMgr updateProjectiles:dt];
    [asteroidManager updateAsteroids:dt];
    
    [coinManager applyGravity:player];
    [coinManager updateCoins:dt];
    
    [collisionMgr performArrayCollisionCheck:[projectileMgr getProjectiles]];
    [collisionMgr performCollisionCheck:player];
}

-(void)asteroidSpawnFunction:(float)dt
{
    if(!suspended)
    {
        bool levelOver = [self checkEndOfLevelScenario];
        static float spawnAccum = 0;
        
        if(!levelOver)
        {
            float astPerSecond = 0.2 + ([GameSettings sharedInstance].level / 3.0f);
            spawnAccum += astPerSecond;
            
            int maxAsteroids = 10 + ([GameSettings sharedInstance].level / 5);
            
            while(spawnAccum > 1.0f)
            {
                if([asteroidManager numAsteroids] < maxAsteroids)
                {
                    [self spawnAsteroid];
                }
                
                spawnAccum -= 1.0f;
            }
        }
    }
}

-(bool) checkEndOfLevelScenario
{
    return [GameSettings sharedInstance].goldInLevel >= goal;
}

-(void) updateRapidFire:(float)dt
{
    if([GameSettings sharedInstance].rapidFire)
    {
        fireTimer += dt;
        
        if(fireTimer > RAPID_FIRE_PERIOD)
        {
            fireTimer = 0.0f;
            fireIndex++;
            
            if([shots count] > 0)
            {
                if(fireIndex >= [shots count])
                    fireIndex = 0;
                
                UITouch* shot = [shots objectAtIndex:fireIndex];
                CGPoint location = [shot locationInView: [shot view]];
                location = [[CCDirector sharedDirector] convertToGL:location];
                [self fireProjectile: location];
            }
        }
    }
}

-(void)fireProjectile:(CGPoint)target
{
    if(player.isAlive && !suspended)
    {
        PLAY_SOUND(SHOOT_SND);
        ProjectileNode* proj = [projectileMgr createProjectile:BASIC_BULLET withPosition:player.position atDestination:target withSpeed:500];
        
        [collisionMgr addObject:proj];
        [self addChild:proj];
    }
}

-(void) spawnAsteroid
{
    int randAngle = rand() % 1000 + 1;
    float angle = (randAngle / 1000.0f) * M_PI * 2.0f;
    float x = cosf(angle);
    float y = sinf(angle);
    
    float Xfactor = fabs(260 / x);
    float Yfactor = fabs(180 / y);
    
    float factor = fmin(Xfactor, Yfactor);
    x = factor * x + 240;
    y = factor * y + 160;
    
    CGPoint dir = ccpSub(ccp(240, 160), ccp(x, y));
    float turn = ((rand() % 40) - 20) * 0.0174520069f;
    
    float boost = clampf((rand() % 100) * 0.01f * [GameSettings sharedInstance].level, 0, 25);
    float scaleBump = (rand() % 100) * 0.004f;
    
    [self genAsteroid:ccp(x, y)
            direction:ccpRotateByAngle(dir, ccp(0, 0), turn)
                speed:(25 + boost)
                scale:(1.00f + scaleBump)];
}

#pragma mark ProjectileDelegate

-(void) projectileDied:(ProjectileNode*)proj
{
    //NSLog(@"Killed Projectile");
    [collisionMgr removeObject:proj];
    [self removeChild:proj cleanup:YES];
}

#pragma mark AsteroidDelegate

-(void) asteroidDied:(AsteroidNode*)asteroid
{
    if(asteroid.pickupType == FIERO_OBJ)
        fieroInPlay = false;
    
    if(asteroid.pickupType == ORBIT_OBJ)
        orbitInPlay = false;
    
    [collisionMgr removeObject:asteroid];
    [self removeChild:asteroid cleanup:YES];
}

-(void)asteroidWasShot:(AsteroidNode*)asteroid
{
    PLAY_SOUND(ASTEROID_EXP_SND);
    AsteroidExplodeParticles* p = [[[AsteroidExplodeParticles alloc] init] autorelease];
    [p setPosition:asteroid.position];
    [p setScale:asteroid.scale];
    [self addChild:p];
    
    if([asteroid shouldSpawnPickup])
    {
        float turn = ((rand() % 120) - 60) * 0.0174520069f;
        CGPoint pos = ccpRotateByAngle(ccp(10, 0), ccp(0, 0), turn);
        CoinNode* coin = [coinManager createCoin:asteroid.pickupType
                                        location:ccpAdd(pos, asteroid.position) 
                                        lifeSpan:10];   
        [self addChild:coin];
        [collisionMgr addObject:coin];
    }

    int numSpawns = [asteroid numAsteroidSpawns];
    
    if(numSpawns > 0.3f)
    {
        float   newSpd = (asteroid.speed + 0.2);
        
        for(int i = 0; i < numSpawns; ++i)
        {
            float turn = ((rand() % 120) - 60) * 0.0174520069f;
            
            [self genAsteroid:asteroid.position
                    direction:ccpRotateByAngle(asteroid.direction, ccp(0, 0), turn)
                        speed:newSpd
                        scale:asteroid.scale * 0.5f];
        }
    }
    
    [collisionMgr removeObject:asteroid];
    [self removeChild:asteroid cleanup:YES];
}

-(void)genAsteroid:(CGPoint)pos direction:(CGPoint)dir speed:(float)spd scale:(float)scl
{
    ObjectType pickupType = COIN_OBJ;
    NSString* texture = @"asteroid.png";
    
    if(scl >= 1.0f)
    {
        int drop = rand() % 100000;
        float pct = drop * 0.001f;
        
        if(pct > (100.0f - orbitChance) && [player isInjured] && !orbitInPlay)
        {
            pickupType = ORBIT_OBJ;
            orbitInPlay = true;
            texture = @"asteroid_blue.png";
        }
        else if(pct > (100.0f - fieroChance) && !fieroInPlay)
        {
            pickupType = FIERO_OBJ;
            fieroInPlay = true;
            texture = @"asteroid_red.png";
        }
    }
    
    AsteroidNode* asteroid = [asteroidManager createAsteroid:texture
                                                    position:pos 
                                                   direction:dir 
                                                       speed:spd];
    asteroid.scale = scl;
    asteroid.pickupType = pickupType;
    [self addChild:asteroid];
    [collisionMgr addObject:asteroid];
}

#pragma mark PlayerDelegate

-(void) playerHitAsteroid
{
    if(player.isAlive)
    {
        if([player numOrbits] > 0)
        {
            PLAY_SOUND(LOSE_ORBIT_SND);
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
            [player removeOrbit:true];
        }
        else 
        {
            [self playerDied];
        }
    }
}

-(void) playerDied
{
    PLAY_SOUND(SHIP_EXP_SND);
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
    player.isAlive = false;
    
    [GameSettings sharedInstance].lives--;
    [uiLayer setLives:[GameSettings sharedInstance].lives];
    
    self.isAccelerometerEnabled = NO;

    PlayerExplosionParticles* playerExplosion = [[[PlayerExplosionParticles alloc] init] autorelease];
    [playerExplosion setPosition:player.position];
    [self addChild:playerExplosion];
    
    [player removeParticles];
    
    [collisionMgr removeObject:player];
    [self removeChild:player cleanup:YES];
    
    if([GameSettings sharedInstance].lives == 0)
    {
        // Run the intro Scene
        [[CCDirector sharedDirector] replaceScene:
         [CCTransitionFade transitionWithDuration:5.0f scene:[GameOverLayer scene]]];	
    }
    else
    {
        [GameSettings sharedInstance].numOrbits = [GameSettings sharedInstance].maxOrbits;
        [[CCDirector sharedDirector] replaceScene:
         [CCTransitionFade transitionWithDuration:4.0f scene:[GameLayer scene]]];	
    }
}

#pragma mark CoinDelegate

-(void) coinDied:(CoinNode*)coin
{
    if(coin.objectType == ORBIT_OBJ)
        orbitInPlay = false;
    
    if(coin.objectType == FIERO_OBJ)
        fieroInPlay = false;
    
    [collisionMgr removeObject:coin];
    [self removeChild:coin cleanup:YES];
}

-(void) coinCollected:(CoinNode*)coin
{
    if(coin.objectType == COIN_OBJ)
    {
        PLAY_SOUND_GAIN(GOLD_PICKUP_SND, 0.25f);
        [GameSettings sharedInstance].gold++;
        [GameSettings sharedInstance].goldInLevel++;
        
        [uiLayer setScore:[GameSettings sharedInstance].gold];
        [uiLayer setGoldInLevel:[GameSettings sharedInstance].goldInLevel withGoal:goal];
    }
    else if(coin.objectType == ORBIT_OBJ)
    {
        PLAY_SOUND(ORBIT_PICKUP_SND);
        [player addOrbit];
        orbitInPlay = false;
    }
    else if(coin.objectType == FIERO_OBJ)
    {
        PLAY_SOUND(SHIP_EXP_SND);
        FieroParticles* exp = [[[FieroParticles alloc] init] autorelease];
        [exp setPosition:player.position];
        [self addChild:exp z:5000];
        
        id waves = [CCRipple3D actionWithPosition:coin.position radius:300 waves:5 amplitude:30 grid:ccg(32, 24) duration:1];
        id waves2 = [CCRipple3D actionWithPosition:coin.position radius:200 waves:5 amplitude:10 grid:ccg(32, 24) duration:1];
        [self runAction:[CCSequence actions:waves,waves2, [CCStopGrid action], nil]];

        [self performSelector:@selector(blowAllAsteroids:) withObject:nil afterDelay:0.5f];
        [self performSelector:@selector(blowAllAsteroids:) withObject:nil afterDelay:0.8f];
        [self performSelector:@selector(blowAllAsteroids:) withObject:nil afterDelay:1.0f];
        
        fieroInPlay = false;
    }
    
    [collisionMgr removeObject:coin];
    [self removeChild:coin cleanup:YES];
}

-(void)blowAllAsteroids:(id)sender
{
    [asteroidManager shootAllAsteroids];
}

#pragma mark Event Callbacks

-(void) ccTouchesBegan:(NSSet*)touches withEvent:(UIEvent *)event
{
    UITouch* lastTouch = nil;
    
    NSLog(@"Touches Began: %d", [touches count]);
    
    for(UITouch *touch in touches)
    {
        [shots addObject:touch];
        lastTouch = touch;
    }
    
    NSLog(@"Total shots: %d", [shots count]);
    
    fireTimer = 0;
    
    if(!suspended)
    {
        if( lastTouch != nil )
        {
            CGPoint location = [lastTouch locationInView: [lastTouch view]];
            location = [[CCDirector sharedDirector] convertToGL:location];
            [self fireProjectile:location];
        }
    }
    
}

-(void) ccTouchesMoved:(NSSet*)touches withEvent:(UIEvent *)event
{
}

-(void) ccTouchesEnded:(NSSet*)touches withEvent:(UIEvent *)event
{
    for(UITouch* touch in touches)
    {
        [shots removeObject:touch];
    }
}

- (void)accelerometer:(UIAccelerometer*)accelerometer didAccelerate:(UIAcceleration*)acceleration
{
    [accFilter addAcceleration:acceleration];
    
    float xformY = accFilter.x;
    float xformX = accFilter.y * -1.0f;
    
    if( [GameSettings sharedInstance].flipx )
        xformX = -xformX;
    
    if( [GameSettings sharedInstance].flipy )
        xformY = -xformY;
    
    float maxX = 480 * [GameSettings sharedInstance].sensitivity;
    float maxY = 320 * [GameSettings sharedInstance].sensitivity;
    
    float x = clampf( ( (xformX + [GameSettings sharedInstance].calx ) * maxX) + 240, 0, 480);
    float y = clampf( ( (xformY + [GameSettings sharedInstance].caly ) * maxY) + 160, 0, 320);

    reticle.desiredPos = ccp(x, y);
    player.desiredPos = ccp(x, y);
}

#pragma mark Cleanup methods

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
    [RootViewController sharedInstance].rootDelegate = nil;
    
    [collisionMgr release];
    [projectileMgr release];
    [coinManager release];
    [asteroidManager release];
    [player release];
    [reticle release];
    [accFilter release];
    [shots release];
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
