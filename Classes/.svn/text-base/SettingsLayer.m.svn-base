//
//  SettingsLayer.m
//  collector
//
//  Created by Kain Osterholt on 4/3/11.
//  Copyright 2011 C-Stick Run. All rights reserved.
//

#import "SettingsLayer.h"
#import "PlayerNode.h"
#import "GameSettings.h"
#import "MainMenuLayer.h"
#import "CalibrationLayer.h"
#import "AudioDefs.h"
#import "AudioSettingsLayer.h"
#import "MenuDefs.h"


@implementation SettingsLayer

+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	SettingsLayer *layer = [SettingsLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init
{
    self = [super init];
    
    if(self != nil)
    {

        CCMenuItemSprite* cal = 
        [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:CALIBRATE_BTN] 
                                selectedSprite:[CCSprite spriteWithFile:CALIBRATE_BTN_PRESS]
                                        target:self
                                      selector:@selector(calibrate:)];
        
        CCMenuItemSprite* audio = 
        [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:AUDIO_BTN] 
                                selectedSprite:[CCSprite spriteWithFile:AUDIO_BTN_PRESS]
                                        target:self
                                      selector:@selector(audio:)];
        
        CCMenuItemSprite* back = 
        [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:BACK_BTN] 
                                selectedSprite:[CCSprite spriteWithFile:BACK_BTN_PRESS]
                                        target:self
                                      selector:@selector(exit:)];

        settingsMenu = [CCMenu menuWithItems:cal, audio, back, nil];
        
        [settingsMenu alignItemsVerticallyWithPadding:5];
        [settingsMenu setPosition:ccp(360, 150)];
        
        [self addChild:settingsMenu z:5];
        
        player = [[PlayerNode alloc] init];
        [self addChild:player z:200];
        player.desiredPos = ccp(35, 275);
        player.accelerometerControlled = false;
        player.position = ccp(35, 275);
        [player initParticles];
        [player setOrbits:[GameSettings sharedInstance].numOrbits];
        
        [self initText];
        
        [self schedule:@selector(update:) interval:1.0f/60.0f];
	}
	return self;
}

-(NSString*)titleText
{
    return @"Settings";
}

-(void)initText
{
    float x = 140;
    float y = 180;
    
    float dy = 30;
    
    [self createLabel:@"Credits" atPosition:ccp(x, y)];
    
    y -= dy;
    [self createLabel:@"Music by: Aaron Solomon" atPosition:ccp(x, y)];
    
    y -= dy;
    [self createLabel:@"Everything Else: Kain Osterholt" atPosition:ccp(x, y)];
    
    [self createLabel:@"For more info visit www.greedyshot.com" atPosition:ccp(240, 20)];
}

-(void)createLabel:(NSString*)text atPosition:(CGPoint)pos
{
    CCLabelTTF* label = [CCLabelTTF labelWithString:text fontName:@"Futura" fontSize:16];
    [label setPosition:pos];
    [self addChild:label];
}

-(void)update:(float)dt
{
    [player updatePlayer:dt];
}

-(void)zipPlayer
{
    id action = [CCMoveTo actionWithDuration:0.5 position:ccp(500, -20)];
    id ease = [CCEaseBackIn actionWithAction:action];
    [player runAction: ease];
}

-(void)exit:(id)sender
{
    [self zipPlayer];
    PLAY_SOUND(ORBIT_PICKUP_SND);
    CCScene* scene = [MainMenuLayer scene];
    
    [[CCDirector sharedDirector] replaceScene: 
     [CCTransitionFade transitionWithDuration:2.0f scene:scene]];
}


-(void)audio:(id)sender
{
    [self zipPlayer];
    PLAY_SOUND(MENU_SELECT_SND);
    CCScene* scene = [AudioSettingsLayer scene];
    
    [[CCDirector sharedDirector] replaceScene: 
     [CCTransitionFade transitionWithDuration:2.0f scene:scene]];
}

-(void)calibrate:(id)sender
{
    [self zipPlayer];
    PLAY_SOUND(MENU_SELECT_SND);
    CCScene* scene = [CalibrationLayer scene];
    
    [[CCDirector sharedDirector] replaceScene: 
     [CCTransitionFade transitionWithDuration:2.0f scene:scene]];
}

@end
