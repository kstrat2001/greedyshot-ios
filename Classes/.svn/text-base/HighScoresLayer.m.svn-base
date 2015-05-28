//
//  HighScoresLayers.m
//  Time-Tap
//
//  Created by Kain Osterholt on 3/19/10.
//  Copyright 2010 AnalogPixels. All rights reserved.
//

#import "HighScoresLayer.h"
#import "HSServer.h"
#import "MenuDefs.h"
#import "MainMenuLayer.h"
#import "AudioDefs.h"
#import "GameSettings.h"
#import "LoadingLayer.h"
#import "PlayerNode.h"

@implementation HighScoresLayer

@synthesize scoresLoaded;

+(id) scene
{
	CCScene *scene = [CCScene node];
	HighScoresLayer *layer = [HighScoresLayer node];
	[scene addChild: layer];
	return scene;
}

- (id) init {
    self = [super init];
    if (self != nil) 
    {
        CCMenu* exitMenu;
        CCMenuItemSprite* exit = 
        [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:BACK_BTN] 
                                selectedSprite:[CCSprite spriteWithFile:BACK_BTN_PRESS]
                                        target:self
                                      selector:@selector(exit:)];
        
        
        exitMenu = [CCMenu menuWithItems:exit, nil];
        
        [exitMenu alignItemsVerticallyWithPadding:0];
        [exitMenu setPosition:ccp(240, 30)];
        [self addChild:exitMenu];
        
        player = [[PlayerNode alloc] init];
        [self addChild:player z:200];
        player.desiredPos = ccp(35, 290);
        player.accelerometerControlled = false;
        player.position = ccp(35, 290);
        [player setOrbits:[GameSettings sharedInstance].maxOrbits];
        [player initParticles];
        
        scoresLoaded = false;
        
        cover = [[LoadingLayer alloc] initWithText:@"Loading High Scores..."];
        [self addChild:cover z:500];
        
        [self loadScores];
        
        [self schedule:@selector(update:) interval:1/60.0f];
    }
                      
    return self;
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

-(void)loadScores
{
    [HSServer sharedInstance].serverDelegate = self;
    [[HSServer sharedInstance] requestScores];
}

-(NSString*)titleText
{
    return @"Honors";
}

- (void) displayHighScores:(NSArray*)scores
{
    float yOff = 0;
    float startY = 230;
    float labelX = 240;
    float fontSize = 24.0f;
    float labelWidth = 400;
    float labelHeight = fontSize + 15;
    float separation = labelHeight + 5;
    
    for(int i = 0; i < [scores count] ; ++i)
    {
        NSDictionary* score = [scores objectAtIndex:i];
        CCLabelTTF* label = [CCLabelTTF labelWithString:[[score objectForKey:@"cc_score"] stringValue] dimensions:CGSizeMake(labelWidth, labelHeight) alignment:UITextAlignmentRight fontName:HS_FONT fontSize:fontSize];
        [self addChild:label z: 200];
        [label setColor:ccWHITE];
        [label setPosition:ccp(labelX, startY - yOff)];
        
        NSString* name = [score objectForKey:@"cc_playername"];
        if([name compare:@""] == NSOrderedSame) { name = @"<anonymous>"; }
        CCLabelTTF* nameLabel = [CCLabelTTF labelWithString:name dimensions:CGSizeMake(labelWidth, labelHeight) alignment:UITextAlignmentLeft fontName:HS_FONT fontSize:fontSize];
        [self addChild:nameLabel z: 200];
        [nameLabel setPosition:ccp(labelX, startY - yOff)];
        [nameLabel setColor:ccWHITE];
        
        yOff += separation;
    }
    
    for(int i = 0; i < MAX_SHOWN_SCORES - [scores count] ; ++i)
    {
        CCLabelTTF* label = [CCLabelTTF labelWithString:@"---" dimensions:CGSizeMake(labelWidth, labelHeight) alignment:UITextAlignmentRight fontName:HS_FONT fontSize:fontSize];
        [self addChild:label z: 200];
        [label setColor:ccWHITE];
        [label setPosition:ccp(labelX, startY - yOff)];
        
        CCLabelTTF* nameLabel = [CCLabelTTF labelWithString:@"---" dimensions:CGSizeMake(labelWidth, labelHeight) alignment:UITextAlignmentLeft fontName:HS_FONT fontSize:fontSize];
        [self addChild:nameLabel z: 200];
        [nameLabel setColor:ccWHITE];
        [nameLabel setPosition:ccp(labelX, startY - yOff)];
        
        yOff += separation;
    }
    
}

-(void) displayUpdateTimeStamp
{
     NSDate *today = [NSDate date];
     NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
     [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
     [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
     NSMutableString* dateString = [[NSMutableString alloc] init];
     [dateString appendString:@"Scores updated "];
     [dateString appendString:[dateFormatter stringFromDate:today]];
     
     CCLabelTTF* label = [CCLabelTTF labelWithString:[NSString stringWithString:dateString] dimensions:CGSizeMake(400, 35) alignment:UITextAlignmentCenter fontName:HS_FONT fontSize:16];
     [self addChild:label z: 200];
     [label setPosition:ccp(240, 80)];
     [label setColor:ccWHITE];
     
     [dateFormatter release];
     [dateString release];
}

-(void) displayConnectionError
{
    CCLabelTTF* description = [CCLabelTTF labelWithString:COMM_LOSS_MSG dimensions:CGSizeMake(325, 150) alignment:UITextAlignmentCenter fontName:HS_FONT fontSize:18];
    [description setPosition:ccp(240, 160)];
    [description setColor:ccWHITE];
    [self addChild:description z:1000];
}

-(void)exit:(id)sender
{
    [self zipPlayer];
    PLAY_SOUND(ORBIT_PICKUP_SND);
    CCScene* scene = [MainMenuLayer scene];
    
    [[CCDirector sharedDirector] replaceScene: 
     [CCTransitionFade transitionWithDuration:2.0f scene:scene]];
}

#pragma mark Delegate Handling

-(void)scoreRequestComplete:(bool)success withScores:(NSArray*)scores
{
    if(success)
    {
        [self displayHighScores:scores];
        [self displayUpdateTimeStamp];
    }
    else 
    {
        NSLog(@"Score Request Failed");
        [self displayConnectionError];
    }
    
    scoresLoaded = true;
    
    [cover runAction:[CCFadeOut actionWithDuration:0.5f]];
}

-(void) scoreRequestRankOk:(id)sender
{
}

-(void)dealloc
{
    [HSServer sharedInstance].serverDelegate = nil;
    [cover release];
    [player release];
    [super dealloc];
}

@end
