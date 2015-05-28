//
//  SummaryLayer.h
//  collector
//
//  Created by Kain Osterholt on 3/17/11.
//  Copyright 2011 C-Stick Run. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#import "GreedyMenu.h"

@class PlayerNode;

@interface SummaryLayer : GreedyMenu {

    PlayerNode* player;
}

+(CCScene*) scene;
-(void)zipPlayer;

@end
