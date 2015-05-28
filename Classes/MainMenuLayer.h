//
//  HelloWorldLayer.h
//  collector
//
//  Created by Kain Osterholt on 2/24/11.
//  Copyright C-Stick Run 2011. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

#import "GreedyMenu.h"

@class PlayerNode;

// HelloWorld Layer
@interface MainMenuLayer : GreedyMenu <UIAlertViewDelegate>
{
    CCMenu* mainMenu;
    
    UIAlertView* newGameAlert;
    
    PlayerNode* player;
}

+(id) scene;
-(void)zipPlayer;
-(void)startNewGame;

@end
