//
//  UIGameLayer.h
//  collector
//
//  Created by Kain Osterholt on 3/17/11.
//  Copyright 2011 C-Stick Run. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface UIGameLayer : CCLayer
{
    int goldGoal;

    CCLabelTTF* scoreLabel;
    CCLabelTTF* goalLabel;
    CCLabelTTF* livesLabel;
    CCLabelTTF* levelLabel;
    
}

+(CCLabelTTF*)createUILabel:(NSString*)text;

-(void)setGoldInLevel:(int)amount withGoal:(int)goal;

-(void)setScore:(int)score;
-(void)setLives:(int)lives;
-(void)setLevel:(int)level;

@end
