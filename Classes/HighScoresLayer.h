//
//  HighScoresLayer.h
//  Time-Tap
//
//  Created by Kain Osterholt on 3/19/10.
//  Copyright 2010 AnalogPixels. All rights reserved.
//

#import "cocos2d.h"
#import "CLScoreServerPost.h"
#import "CLScoreServerRequest.h"
#import "HSServerDelegate.h"
#import "GreedyMenu.h"

#import <Foundation/Foundation.h>

@class LoadingLayer;
@class PlayerNode;

@interface HighScoresLayer : GreedyMenu <HSServerDelegate>
{
    LoadingLayer* cover;
    PlayerNode* player;
    bool scoresLoaded;
}

@property (nonatomic, readonly) bool scoresLoaded;

+ (id) scene;

-(void)loadScores;
-(void) displayHighScores:(NSArray*)scores;
-(void) displayUpdateTimeStamp;
-(void) displayConnectionError;

-(void)zipPlayer;

@end
