//
//  AudioManager.m
//  Time-Tap
//
//  Created by Kain Osterholt on 1/15/10.
//  Copyright 2010 AnalogPixels. All rights reserved.
//
#import <AVFoundation/AVFoundation.h>

#import "CocosDenshion.h"
#import "SimpleAudioEngine.h"
#import "AudioManager.h"
#import "GameSettings.h"
#import "AudioDefs.h"

static AudioManager *sharedInstance = nil;

@implementation AudioManager

-(id)init
{
    if (self == [super init]) 
    {
        currentMusic = @"";
    }
    
    return self;
}

- (void)loadAllSounds
{
    LOAD_SOUND(ASTEROID_EXP_SND);
    LOAD_SOUND(SHOOT_SND);
    LOAD_SOUND(GOLD_PICKUP_SND);
    LOAD_SOUND(SHIP_EXP_SND);
    LOAD_SOUND(MENU_SELECT_SND);
    LOAD_SOUND(LOSE_ORBIT_SND);
    LOAD_SOUND(ORBIT_PICKUP_SND);
    
    LOAD_MUSIC(MENU_MUSIC);
    LOAD_MUSIC(GAMEPLAY_MUSIC);
    LOAD_MUSIC(SUMMARY_MUSIC);
    LOAD_MUSIC(STORE_MUSIC);
}

#pragma mark -
#pragma mark Audio Player Load functions

-(void)loadSound:(NSString*)filename
{
    [[SimpleAudioEngine sharedEngine] preloadEffect:filename];
}

-(void)loadMusic:(NSString*)filename
{
    [[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:filename];
}

#pragma mark -
#pragma mark Audio Player Play functions

-(void)playSound:(NSString*)filename
{
    [self playSound:filename withGain:1.0f];
}

- (void)playSound:(NSString*)filename withGain:(float)gain
{
    // defaults pitch:1.0f pan:0.0f gain:1.0f
    
    if( ![GameSettings sharedInstance].effectsOff )
    {
        [[SimpleAudioEngine sharedEngine] playEffect:filename pitch:1.0f pan:0.0f gain:gain];
    }
}

- (void)stopSound:(NSString*)filename
{
    //[[SimpleAudioEngine sharedEngine] stopEffect:filename];
}

- (void)playMusic:(NSString*)filename
{
    if( [currentMusic compare:filename] != NSOrderedSame )
    {
        currentMusic = [NSString stringWithString:filename];
        
        if( ![GameSettings sharedInstance].musicOff )
        {
            [[SimpleAudioEngine sharedEngine] playBackgroundMusic:filename];
        }
    }
}

- (void)resumeMusic
{
    if( [currentMusic compare:@""] != NSOrderedSame )
    {
        [self playMusic:currentMusic];
    }
}

- (void)stopMusic
{
    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    currentMusic = @"";
}

#pragma mark -
#pragma mark Audio Player Param Control
- (void)setSoundVolume:(NSString*)filename :(float)volume
{  
}

#pragma mark -
#pragma mark Singleton methods

+ (AudioManager*)sharedInstance
{
    @synchronized(self)
    {
        if (sharedInstance == nil)
            sharedInstance = [[AudioManager alloc] init];
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

- (id)retain {
    return self;
}

- (unsigned)retainCount {
    return UINT_MAX;  // denotes an object that cannot be released
}

- (void)release {
}

- (id)autorelease {
    return self;
}


@end