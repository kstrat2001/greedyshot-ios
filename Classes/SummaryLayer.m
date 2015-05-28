//
//  SummaryLayer.m
//  collector
//
//  Created by Kain Osterholt on 3/17/11.
//  Copyright 2011 C-Stick Run. All rights reserved.
//

#import "SummaryLayer.h"
#import "MenuDefs.h"
#import "GameLayer.h"
#import "StoreLayer.h"
#import "HSServer.h"
#import "GameSettings.h"
#import "GameDefs.h"
#import "AudioDefs.h"
#import "PlayerNode.h"

@implementation SummaryLayer

+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	SummaryLayer *layer = [SummaryLayer node];
	
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
	if( (self=[super init] )) 
    {
        
        player = [[PlayerNode alloc] init];
        [self addChild:player z:200];
        player.desiredPos = ccp(35, 290);
        player.accelerometerControlled = false;
        player.position = ccp(35, 290);
        [player setOrbits:[GameSettings sharedInstance].numOrbits];
        [player initParticles];
    
        CCMenuItemSprite* store = 
        [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:UPGRADES] 
                                selectedSprite:[CCSprite spriteWithFile:UPGRADES_PRESS]
                                        target:self
                                      selector:@selector(store:)];
        
        CCMenuItemSprite* cont = 
        [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:CONTINUE] 
                                selectedSprite:[CCSprite spriteWithFile:CONTINUE_PRESS]
                                        target:self
                                      selector:@selector(continueGame:)];
        
        CCMenu* mainMenu = [CCMenu menuWithItems:store, cont, nil];
        
        [mainMenu alignItemsHorizontallyWithPadding:50];
        [mainMenu setPosition:ccp(240, 55)];
        
        [self addChild:mainMenu z:5];
        
        CCLabelTTF* savedProgress = [CCLabelTTF labelWithString:@"Your progress has been saved." fontName:@"Futura" fontSize:20];
        [savedProgress setPosition:ccp(240, 215)];
        [savedProgress setColor:ccWHITE];
        [self addChild:savedProgress];
        
        CCLabelTTF* scoreLabel = [CCLabelTTF labelWithString:@"Total Gold Collected:" fontName:@"Futura" fontSize:20];
        [scoreLabel setPosition:ccp(240, 175)];
        [scoreLabel setColor:ccWHITE];
        [self addChild:scoreLabel];
        
        [scoreLabel setString:[NSString stringWithFormat:@"Total Gold Collected: %d", [GameSettings sharedInstance].gold]];
        
        
        CCLabelTTF* hsEligibility = [CCLabelTTF labelWithString:@"" fontName:@"Futura" fontSize:20];
        [hsEligibility setPosition:ccp(240, 135)];
        [hsEligibility setColor:ccWHITE];
        [self addChild:hsEligibility];
        
        int eligiblilty = (HS_ELIGIBLE_LVL - [GameSettings sharedInstance].level);
        
        if(eligiblilty == 1)
        {
            [hsEligibility setString:[NSString stringWithFormat:@"Eligible for High Scores in %d level", eligiblilty]];
            [hsEligibility setColor:ccORANGE];
        }
        else if(eligiblilty > 0)
        {
            [hsEligibility setString:[NSString stringWithFormat:@"Eligible for High Scores in %d levels", eligiblilty]];
            [hsEligibility setColor:ccORANGE];
        }
        else
        {
            [hsEligibility setString:@"Eligible for High Scores!"];
            [hsEligibility setColor:ccGREEN];
        }
        
        [self schedule:@selector(update:) interval:1/60.0f];
        
        [titleSprite setPosition:ccp(240, 270)];
        
        
        [self performSelector:@selector(onStart:) withObject:nil afterDelay:0.9f];
	}
	return self;
}

-(void)onStart:(id)sender
{
    PLAY_MUSIC( SUMMARY_MUSIC );
}

-(void)update:(float)dt
{
    [player updatePlayer:dt];
}

-(void)zipPlayer
{
    id action = [CCMoveTo actionWithDuration:0.5 position:ccp(500, -50)];
    id ease = [CCEaseBackIn actionWithAction:action];
    [player runAction: ease];
}

-(NSString*)titleText
{
    return [NSString stringWithFormat:@"Level %d Complete!", ([GameSettings sharedInstance].level)];
}

-(void)continueGame:(id)sender
{
    [self zipPlayer];
    PLAY_SOUND(MENU_SELECT_SND);
    CCScene* scene = [GameLayer scene];
    
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

-(void)dealloc
{
    [player release];
    [super dealloc];
}


@end
