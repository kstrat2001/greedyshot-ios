//
//  AudioManager.h
//  Time-Tap
//
//  Created by Kain Osterholt on 1/15/10.
//  Copyright 2010 AnalogPixels. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>


@interface AudioManager : NSObject
{
    NSString* currentMusic;
}

+ (AudioManager*)sharedInstance;
+ (id)allocWithZone:(NSZone *)zone;
- (id)copyWithZone:(NSZone *)zone;

- (void)loadSound:(NSString*)filename;
- (void)loadMusic:(NSString*)filename;

- (void)playSound:(NSString*)filename;
- (void)playSound:(NSString*)filename withGain:(float)gain;
- (void)stopSound:(NSString*)filename;

- (void)playMusic:(NSString*)filename;
- (void)stopMusic;

- (void)loadAllSounds;
- (void)setSoundVolume:(NSString*)filename :(float)volume;

- (void)resumeMusic;

@end
