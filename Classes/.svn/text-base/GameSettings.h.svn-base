//
//  GameSettings.h
//  collector
//
//  Created by Kain Osterholt on 3/9/11.
//  Copyright 2011 C-Stick Run. All rights reserved.
//

#import <Foundation/Foundation.h>

#define GAME_IN_PROGRESS_KEY @"GAME_IN_PROGRESS"
#define LEVEL_KEY @"LEVEL"
#define LIVES_KEY @"LIVES"
#define GOLD_KEY @"GOLD_KEY"
#define GOLD_IN_LEVEL_KEY @"GOLD_IN_LEVEL_KEY"
#define NUM_ORBITS_KEY @"NUM_ORBITS_KEY"
#define MAX_ORBITS_KEY @"MAX_ORBITS_KEY"

#define RAPID_FIRE_KEY @"RAPID_FIRE_KEY"

#define MUSIC_ON_KEY @"MUSIC_ON_KEY"
#define EFFECTS_ON_KEY @"EFFECTS_ON_KEY"

#define CALX_KEY @"CALX_KEY"
#define CALY_KEY @"CALY_KEY"
#define FLIPX_KEY @"FLIPX_KEY"
#define FLIPY_KEY @"FLIPY_KEY"
#define SENSITIVITY_KEY @"SENSITIVITY_KEY"

@interface GameSettings : NSObject 
{
    bool gameInProgress;
    int maxOrbits;
    int numOrbits;
    int level;
    int lives;
    int gold;
    int goldInLevel;
    
    // In app purchased abilities
    
    bool rapidFire;
    
    // Calibration settings
    float calx;
    float caly;
    bool flipx;
    bool flipy;
    float sensitivity;
    
    // Audio settings
    bool musicOff;
    bool effectsOff;
}

@property (nonatomic, assign) bool gameInProgress;
@property (nonatomic, assign) int maxOrbits;
@property (nonatomic, assign) int numOrbits;
@property (nonatomic, assign) int level;
@property (nonatomic, assign) int lives;
@property (nonatomic, assign) int gold;
@property (nonatomic, assign) int goldInLevel;

@property (nonatomic, assign) bool rapidFire;

@property (nonatomic, assign) float calx;
@property (nonatomic, assign) float caly;
@property (nonatomic, assign) bool flipx;
@property (nonatomic, assign) bool flipy;
@property (nonatomic, assign) float sensitivity;

@property (nonatomic, assign) bool musicOff;
@property (nonatomic, assign) bool effectsOff;

-(bool) isItemPurchased:(NSString*)productID;
-(void) purchaseItem:(NSString*)productID;
-(void) startNewGame;
-(void) load;
-(void) save;

+ (GameSettings*)sharedInstance;
+ (id)allocWithZone:(NSZone *)zone;
- (id)copyWithZone:(NSZone *)zone;

@end
