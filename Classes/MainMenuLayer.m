//
//  MainMenuScene.m
//  collector
//
//  Created by Kain Osterholt on 2/24/11.
//  Copyright C-Stick Run 2011. All rights reserved.
//

// Import the interfaces
#import "MainMenuLayer.h"
#import "GameSettings.h"
#import "StoreLayer.h"
#import "GameLayer.h"
#import "AudioDefs.h"
#import "RootViewController.h"
#import "PlayerNode.h"
#import "HighScoresLayer.h"
#import "SettingsLayer.h"
#import "MenuDefs.h"

// HelloWorld implementation
@implementation MainMenuLayer

+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	MainMenuLayer *layer = [MainMenuLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(NSString*)titleText
{
    return @"";
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) 
    {        
        CCMenuItemSprite* cont = 
        [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:CONTINUE] 
                                selectedSprite:[CCSprite spriteWithFile:CONTINUE_PRESS]
                                        target:self
                                      selector:@selector(continueGame:)];

        CCMenuItemSprite* play = 
        [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:NEW_GAME] 
                                selectedSprite:[CCSprite spriteWithFile:NEW_GAME_PRESS]
                                        target:self
                                      selector:@selector(play:)];
        

        CCMenuItemSprite* highScores = 
        [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:HONORS] 
                                selectedSprite:[CCSprite spriteWithFile:HONORS_PRESS]
                                        target:self
                                      selector:@selector(highScores:)];
        
        CCMenuItemSprite* store = 
        [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:UPGRADES] 
                                selectedSprite:[CCSprite spriteWithFile:UPGRADES_PRESS]
                                        target:self
                                      selector:@selector(store:)];
        
        CCMenuItemSprite* settings = 
        [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:SETTINGS_BTN] 
                                selectedSprite:[CCSprite spriteWithFile:SETTINGS_BTN_PRESS]
                                        target:self
                                      selector:@selector(settings:)];
        
        if([GameSettings sharedInstance].gameInProgress)
        {
            mainMenu = [CCMenu menuWithItems:cont, play, highScores, store, settings, nil];
        }
        else 
        {
            mainMenu = [CCMenu menuWithItems:play, highScores, store, settings, nil];
        }

        [mainMenu alignItemsVerticallyWithPadding:5];
        [mainMenu setPosition:ccp(350, 160)];
        
        [self addChild:mainMenu z:5];
        
        CCSprite* title = [CCSprite spriteWithFile:@"front_title.png"];
        [title setPosition:ccp(130, 205)];
        [self addChild:title z:10];
        
        player = [[PlayerNode alloc] init];
        [self addChild:player z:1000];
        player.desiredPos = ccp(130, 110);
        player.position = ccp(130, 110);
        player.accelerometerControlled = false;
        [player setOrbits:[GameSettings sharedInstance].numOrbits];
        [player initParticles];
        
        newGameAlert = [[UIAlertView alloc] initWithTitle:@"Start New Game?"
                                                        message: @"If you start over you will lose your progress and your lives will be reset to 3.  Other purchases such as Rapid Fire and Max Orbits will carry over to the new game."
                                                       delegate: self 
                                              cancelButtonTitle: nil
                                              otherButtonTitles: @"Cancel", @"OK", nil];
        
        [self schedule:@selector(update:) interval:1.0f/60.0f];
        
        [self performSelector:@selector(onStart:) withObject:nil afterDelay:0.8f];
	}
	return self;
}

-(void)onStart:(id)sender
{
    PLAY_MUSIC(MENU_MUSIC);
}

-(void)update:(float)dt
{
    [player updatePlayer:dt];
}

-(void)zipPlayer
{
    id action = [CCMoveTo actionWithDuration:0.5 position:ccp(500, 400)];
    id ease = [CCEaseBackIn actionWithAction:action];
    [player runAction: ease];
}

-(void)continueGame:(id)sender
{
    [self zipPlayer];
    PLAY_SOUND(MENU_SELECT_SND);
    CCScene* scene = [GameLayer scene];
    
    [[CCDirector sharedDirector] replaceScene: 
     [CCTransitionFade transitionWithDuration:2.0f scene:scene]];
}

-(void)play:(id)sender
{
    PLAY_SOUND(MENU_SELECT_SND);
    
    if([GameSettings sharedInstance].gameInProgress)
    {
        [self performSelector:@selector(showNewGameAlert:) withObject:nil afterDelay:1.0f];
    }
    else
    {
        [self startNewGame];
    }
}

-(void) showNewGameAlert:(id)sender
{
    [newGameAlert show];
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) 
    {
        [self startNewGame];
    }
}

-(void)startNewGame
{
    [self zipPlayer];
    [[GameSettings sharedInstance] startNewGame];
    CCScene* scene = [GameLayer scene];
    
    [[CCDirector sharedDirector] replaceScene: 
     [CCTransitionFade transitionWithDuration:2.0f scene:scene]];
}

-(void)highScores:(id)sender
{
    [self zipPlayer];
    PLAY_SOUND(MENU_SELECT_SND);
    CCScene* scene = [HighScoresLayer scene];
    
    [[CCDirector sharedDirector] replaceScene: 
     [CCTransitionFade transitionWithDuration:2.0f scene:scene]];
}

-(void)store:(id)sender
{
    [self zipPlayer];
    PLAY_SOUND(MENU_SELECT_SND);
    CCScene* scene = [StoreLayer scene];
    
    [[CCDirector sharedDirector] replaceScene: 
     [CCTransitionFade transitionWithDuration:2.0f scene:scene]];
}

-(void)settings:(id)sender
{
    [self zipPlayer];
    PLAY_SOUND(MENU_SELECT_SND);
    CCScene* scene = [SettingsLayer scene];
    
    [[CCDirector sharedDirector] replaceScene: 
     [CCTransitionFade transitionWithDuration:2.0f scene:scene]];
}


-(void)dealloc
{
    [newGameAlert release];
    [player release];
    [super dealloc];
}

@end
