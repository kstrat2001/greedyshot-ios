//
//  LoadingLayer.m
//  collector
//
//  Created by Kain Osterholt on 3/26/11.
//  Copyright 2011 C-Stick Run. All rights reserved.
//

#import "LoadingLayer.h"
#import "MainMenuLayer.h"
#import "MenuDefs.h"
#import "AudioDefs.h"

@implementation LoadingLayer

-(id)initWithText:(NSString*)text
{
    self = [super init];
    
    if(self != nil)
    {
        loadingLabel = [CCLabelTTF labelWithString:text fontName:@"Futura" fontSize:30];
        [self addChild:loadingLabel z:10];
        [loadingLabel setPosition:ccp(240, 160)];
        
        black = [CCSprite spriteWithFile:@"black.png"];
        [black setPosition:ccp(240, 160)];
        [self addChild:black z:1];
    }
    
    return self;
}

-(void) setOpacity: (GLubyte) opacity
{
    for( CCNode *node in [self children] )
    {
        if( [node conformsToProtocol:@protocol( CCRGBAProtocol )] )
        {
            [ (id<CCRGBAProtocol>) node setOpacity: opacity];
        }
    }
}

-(void) displayError:(NSString*)error
{
    [loadingLabel runAction:[CCFadeOut actionWithDuration:0.3]];
    
    CCMenu* exitMenu;
    CCMenuItemSprite* exit = 
    [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:BACK_BTN] 
                            selectedSprite:[CCSprite spriteWithFile:BACK_BTN_PRESS]
                                    target:self
                                  selector:@selector(exit:)];
    
    
    exitMenu = [CCMenu menuWithItems:exit, nil];
    
    [exitMenu alignItemsVerticallyWithPadding:0];
    [exitMenu setPosition:ccp(240, 70)];
    [self addChild:exitMenu z:1000];
    
    CCLabelTTF* description = [CCLabelTTF labelWithString:error dimensions:CGSizeMake(325, 150) alignment:UITextAlignmentCenter fontName:@"Futura" fontSize:18];
    [description setPosition:ccp(240, 160)];
    [description setColor:ccWHITE];
    [self addChild:description z:1000];
}

-(void)exit:(id)sender
{
    PLAY_SOUND(ORBIT_PICKUP_SND);
    CCScene* scene = [MainMenuLayer scene];
    
    [[CCDirector sharedDirector] replaceScene: 
     [CCTransitionFade transitionWithDuration:1.5f scene:scene]];
}


@end
