//
//  GameSettings.m
//  collector
//
//  Created by Kain Osterholt on 3/9/11.
//  Copyright 2011 C-Stick Run. All rights reserved.
//

#import "GameSettings.h"
#import "GameDefs.h"

static GameSettings *sharedInstance = nil;

@implementation GameSettings

@synthesize gameInProgress, maxOrbits, numOrbits, level, lives, gold, goldInLevel;
@synthesize rapidFire;
@synthesize calx, caly, flipx, flipy, sensitivity;
@synthesize musicOff, effectsOff;

-(id) init
{
    self = [super init];
    
    if(self != nil)
    {
        musicOff = false;
        effectsOff = false;
        
        calx = 0.0f;
        caly = 0.5f;
        flipx = false;
        flipy = false;
        sensitivity = 1.5f;
    }
    
    return self;
}

-(void)startNewGame
{
    level = 0;
    lives = 3;
    gold = 0;
    goldInLevel = 0;
    numOrbits = maxOrbits;
    gameInProgress = false;
    
    [self save];
}

-(void)load
{
    level = 0;
    lives = STARTING_LIVES;
    gold = 0;
    goldInLevel = 0;
    maxOrbits = STARTING_ORBITS;
    numOrbits = maxOrbits;
    gameInProgress = false;
    rapidFire = false;
    
    gameInProgress = [[NSUserDefaults standardUserDefaults] boolForKey:GAME_IN_PROGRESS_KEY];
    maxOrbits = [[NSUserDefaults standardUserDefaults] integerForKey:MAX_ORBITS_KEY];
    numOrbits = [[NSUserDefaults standardUserDefaults] integerForKey:NUM_ORBITS_KEY];
    level = [[NSUserDefaults standardUserDefaults] integerForKey:LEVEL_KEY];
    lives = [[NSUserDefaults standardUserDefaults] integerForKey:LIVES_KEY];
    gold = [[NSUserDefaults standardUserDefaults] integerForKey:GOLD_KEY];
    goldInLevel = [[NSUserDefaults standardUserDefaults] integerForKey:GOLD_IN_LEVEL_KEY];
    
    if(maxOrbits == 0)
        maxOrbits = STARTING_ORBITS;
    
    if(numOrbits == 0)
        numOrbits = STARTING_ORBITS;
    
    if(lives == 0)
        lives = STARTING_LIVES;
    
    // In app purchases
    rapidFire = [[NSUserDefaults standardUserDefaults] boolForKey:RAPID_FIRE_KEY];
    
    // Settings
    musicOff   = [[NSUserDefaults standardUserDefaults] boolForKey:MUSIC_ON_KEY];
    effectsOff = [[NSUserDefaults standardUserDefaults] boolForKey:EFFECTS_ON_KEY];
    
    calx = [[NSUserDefaults standardUserDefaults] floatForKey:CALX_KEY];
    caly = [[NSUserDefaults standardUserDefaults] floatForKey:CALY_KEY];
    flipx = [[NSUserDefaults standardUserDefaults] floatForKey:FLIPX_KEY];
    flipy = [[NSUserDefaults standardUserDefaults] floatForKey:FLIPY_KEY];
    sensitivity = [[NSUserDefaults standardUserDefaults] floatForKey:SENSITIVITY_KEY];
    
    if(sensitivity == 0)
        sensitivity = 1.5;
    
}

-(void)save
{
    [[NSUserDefaults standardUserDefaults] setBool:gameInProgress forKey:GAME_IN_PROGRESS_KEY];
    [[NSUserDefaults standardUserDefaults] setInteger:maxOrbits forKey:MAX_ORBITS_KEY];
    [[NSUserDefaults standardUserDefaults] setInteger:numOrbits forKey:NUM_ORBITS_KEY];
    [[NSUserDefaults standardUserDefaults] setInteger:level forKey:LEVEL_KEY];
    [[NSUserDefaults standardUserDefaults] setInteger:gold forKey:GOLD_KEY];
    [[NSUserDefaults standardUserDefaults] setInteger:goldInLevel forKey:GOLD_IN_LEVEL_KEY];
    [[NSUserDefaults standardUserDefaults] setInteger:lives forKey:LIVES_KEY];
    
    // In app purchases
    [[NSUserDefaults standardUserDefaults] setBool:rapidFire forKey:RAPID_FIRE_KEY];
    
    // SETTINGS
    [[NSUserDefaults standardUserDefaults] setBool:musicOff forKey:MUSIC_ON_KEY];
    [[NSUserDefaults standardUserDefaults] setBool:effectsOff forKey:EFFECTS_ON_KEY];
    
    [[NSUserDefaults standardUserDefaults] setFloat:calx forKey:CALX_KEY];
    [[NSUserDefaults standardUserDefaults] setFloat:caly forKey:CALY_KEY];
    [[NSUserDefaults standardUserDefaults] setBool:flipx forKey:FLIPX_KEY];
    [[NSUserDefaults standardUserDefaults] setBool:flipy forKey:FLIPY_KEY];
    [[NSUserDefaults standardUserDefaults] setFloat:sensitivity forKey:SENSITIVITY_KEY];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void) purchaseItem:(NSString*)productID
{
    if([productID compare:RAPID_FIRE_PURCHASE_ID] == NSOrderedSame)
    {
        self.rapidFire = true;
    }
    else if([productID compare:MAX_ORBITS_PURCHASE_ID] == NSOrderedSame)
    {
        self.maxOrbits = MAX_ORBITS;
    }
    else if([productID compare:ONE_UP_PURCHASE_ID] == NSOrderedSame)
    {
        self.lives++;
    }
    
    [self save];
}

-(bool) isItemPurchased:(NSString*)productID
{
    bool retval = false;
    
    if([productID compare:RAPID_FIRE_PURCHASE_ID] == NSOrderedSame)
    {
        retval = (self.rapidFire == true);
    }
    else if([productID compare:MAX_ORBITS_PURCHASE_ID] == NSOrderedSame)
    {
        retval = (self.maxOrbits == MAX_ORBITS);
    }
    
    return retval;
}

#pragma mark -
#pragma mark Singleton methods

+ (GameSettings*)sharedInstance
{
    @synchronized(self)
    {
        if (sharedInstance == nil)
            sharedInstance = [[GameSettings alloc] init];
    }
    return sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (sharedInstance == nil) {
            sharedInstance = [super allocWithZone:zone];
            return sharedInstance;  // assignment and return on first allocation
        }
    }
    return nil; // on subsequent allocation attempts return nil
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)retain
{
    return self;
}

- (unsigned)retainCount 
{
    return UINT_MAX;  // denotes an object that cannot be released
}

- (void)release 
{
}

- (id)autorelease {
    return self;
}

@end
