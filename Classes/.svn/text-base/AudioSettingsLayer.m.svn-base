//
//  AudioSettingsLayer.m
//  collector
//
//  Created by Kain Osterholt on 4/4/11.
//  Copyright 2011 C-Stick Run. All rights reserved.
//

#import "AudioSettingsLayer.h"
#import "GameSettings.h"
#import "MenuDefs.h"
#import "AudioManager.h"
#import "PlayerNode.h"
#import "MainMenuLayer.h"
#import "AudioDefs.h"

@implementation AudioSettingsLayer

+(id) scene
{
	CCScene *scene = [CCScene node];
	AudioSettingsLayer *layer = [AudioSettingsLayer node];
	[scene addChild: layer];
	return scene;
}

-(id)init
{
    self = [super init];
    
    if(self != nil)
    {
        [CCMenuItemFont setFontSize:30];
        [CCMenuItemFont setFontName:@"Futura"];
        
        CCLabelTTF* musicLabel = [CCLabelTTF labelWithString:[self getStatusStr:![GameSettings sharedInstance].musicOff withType:MUSIC_ON]
                                                    fontName:@"Futura" 
                                                    fontSize:30];
        
        music = [CCMenuItemLabel itemWithLabel:musicLabel
                                        target:self
                                      selector:@selector(toggleMusic:)];
        
        CCLabelTTF* effectsLabel = [CCLabelTTF labelWithString:[self getStatusStr:![GameSettings sharedInstance].effectsOff withType:EFFECTS_ON]
                                                    fontName:@"Futura" 
                                                    fontSize:30];
        
        effects = [CCMenuItemLabel itemWithLabel:effectsLabel
                                        target:self
                                      selector:@selector(toggleEffects:)];
        
        menu = [CCMenu menuWithItems: music, effects, nil];
        [menu alignItemsVerticallyWithPadding:30];
        [menu setPosition:ccp(240, 160)];
        [self addChild:menu]; 
        
        CCMenuItemSprite* exit = 
        [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:BACK_BTN] 
                                selectedSprite:[CCSprite spriteWithFile:BACK_BTN_PRESS]
                                        target:self
                                      selector:@selector(exit:)];
        
        
        CCMenu* exitMenu = [CCMenu menuWithItems:exit, nil];
        
        [exitMenu alignItemsVerticallyWithPadding:0];
        [exitMenu setPosition:ccp(240, 30)];
        
        [self addChild:exitMenu z:5];
        
        player = [[PlayerNode alloc] init];
        [self addChild:player z:200];
        player.desiredPos = ccp(35, 275);
        player.accelerometerControlled = false;
        player.position = ccp(35, 275);
        [player initParticles];
        [player setOrbits:[GameSettings sharedInstance].numOrbits];
        
        [self schedule:@selector(update:) interval:1.0f/60.0f];
    }
    
    return self;
}

-(void)update:(float)dt
{
    [player updatePlayer:dt];
}

-(NSString*)titleText
{
    return @"Audio Settings";
}

-(NSString*)getStatusStr:(bool)on withType:(AudioSettingType)type
{
    NSMutableString* statusStr = [NSMutableString stringWithFormat:@""];
    
    if(type == EFFECTS_ON)
    {
        [statusStr appendString:@"Effects: "];
    }
    else if(type == MUSIC_ON)
    {
        [statusStr appendString:@"Music: "];
    }
    
    if( !on )
    {
        [statusStr appendString:@"Off"];
    }
    else 
    {
        [statusStr appendString:@"On"];
    }
    
    return statusStr;
}

-(void)toggleMusic:(id)sender
{
    [GameSettings sharedInstance].musicOff = ![GameSettings sharedInstance].musicOff;
    [[GameSettings sharedInstance] save];
    
    [music setString:[self getStatusStr:![GameSettings sharedInstance].musicOff withType:MUSIC_ON]];
    PLAY_SOUND(MENU_SELECT_SND);
    
    if([GameSettings sharedInstance].musicOff == false)
    {
        [[AudioManager sharedInstance] resumeMusic];
    }
    else 
    {
        [[AudioManager sharedInstance] stopMusic];
    }

}

-(void)zipPlayer
{
    id action = [CCMoveTo actionWithDuration:0.5 position:ccp(500, -20)];
    id ease = [CCEaseBackIn actionWithAction:action];
    [player runAction: ease];
}

-(void)toggleEffects:(id)sender
{
    [GameSettings sharedInstance].effectsOff = ![GameSettings sharedInstance].effectsOff;
    [[GameSettings sharedInstance] save];
    
    [effects setString:[self getStatusStr:![GameSettings sharedInstance].effectsOff withType:EFFECTS_ON]];

    PLAY_SOUND(MENU_SELECT_SND);
}

-(void)exit:(id)sender
{
    [self zipPlayer];
    PLAY_SOUND(ORBIT_PICKUP_SND);
    CCScene* scene = [MainMenuLayer scene];
    
    [[CCDirector sharedDirector] replaceScene: 
     [CCTransitionFade transitionWithDuration:1.5f scene:scene]];
}

-(void)dealloc
{
    [player release];
    [super dealloc];
}

@end
