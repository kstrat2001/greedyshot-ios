//
//  AudioSettingsLayer.h
//  collector
//
//  Created by Kain Osterholt on 4/4/11.
//  Copyright 2011 C-Stick Run. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GreedyMenu.h"

typedef enum AudioSettingType
{
    MUSIC_ON,
    EFFECTS_ON
} AudioSettingType;

@class PlayerNode;

@interface AudioSettingsLayer : GreedyMenu
{

        PlayerNode* player;
    
    CCMenu* menu;
    CCMenuItemLabel* music;
    CCMenuItemLabel* effects;
}

+(id) scene;

-(void)zipPlayer;

-(NSString*)getStatusStr:(bool)on withType:(AudioSettingType)type;

@end
