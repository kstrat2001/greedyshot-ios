//
//  SettingsLayer.h
//  collector
//
//  Created by Kain Osterholt on 4/3/11.
//  Copyright 2011 C-Stick Run. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GreedyMenu.h"

@class PlayerNode;

@interface SettingsLayer : GreedyMenu {

    PlayerNode* player;
    CCMenu* settingsMenu;
    CCMenu* exitMenu;
}

+(id) scene;

-(void)zipPlayer;
-(void)initText;
-(void)createLabel:(NSString*)text atPosition:(CGPoint)pos;

@end
