//
//  GameOverLayer.m
//  collector
//
//  Created by Kain Osterholt on 3/17/11.
//  Copyright 2011 C-Stick Run. All rights reserved.
//

#import "GameOverLayer.h"
#import "MainMenuLayer.h"
#import "HSServer.h"
#import "GameSettings.h"
#import "GameDefs.h"

@implementation GameOverLayer


+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameOverLayer *layer = [GameOverLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}


-(id)init
{
    self = [super init];
    
    if(self != nil)
    {
        
        screenTime = 6.0f;
        
        CCLabelTTF* gameOver = [CCLabelTTF labelWithString:@"Game Over" fontName:@"Helvetica" fontSize:50];
        [self addChild:gameOver z:100];
        [gameOver setPosition:ccp(240, 160)];
        
        finalLevel = [GameSettings sharedInstance].level;
        finalScore = [GameSettings sharedInstance].gold;
        
        [[GameSettings sharedInstance] startNewGame];
        [[GameSettings sharedInstance] save];
        
        [HSServer sharedInstance].serverDelegate = self;
        [self performSelector:@selector(checkScore:) withObject:nil afterDelay:4.0f];
    }
    
    return self;
}

-(void)checkScore:(id)sender
{
    [[HSServer sharedInstance] requestScores];
}

-(void)scoreRequestComplete:(bool)success withScores:(NSArray *)scores
{
    if(success)
    {
        if(finalLevel >= HS_ELIGIBLE_LVL)
        {
            [[HSServer sharedInstance] attemptEntry:scores newScore:finalScore];
        }
        else 
        {
            [self finishGame];
        }
    }
    else 
    {
        [self finishGame];
    }

}

-(void)scoreEntryComplete:(bool)success
{
    [self finishGame];
}

-(void)finishGame
{
    [self schedule:@selector(updateTime:) interval:1/30.0f];
}

-(void)updateTime:(float)dt
{
    screenTime -= dt;
    
    if(screenTime < 0.0f)
    {
        [self unschedule:@selector(updateTime:)];
        
        CCScene* scene = [MainMenuLayer scene];
        [[CCDirector sharedDirector] replaceScene: 
         [CCTransitionFade transitionWithDuration:3.0f scene:scene]];
    }
}


@end
