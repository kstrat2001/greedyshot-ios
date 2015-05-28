//
//  StoreLayer.h
//  collector
//
//  Created by Kain Osterholt on 3/15/11.
//  Copyright 2011 C-Stick Run. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "cocos2d.h"
#import "PagedMenu.h"
#import "StoreManagerDelegate.h"

@class PlayerNode;
@class LoadingLayer;

@interface StoreLayer : PagedMenu <StoreManagerDelegate, UIAlertViewDelegate>
{
    LoadingLayer* cover;
    PlayerNode* player;
    CCMenu* exitMenu;
    
    CCLabelTTF* livesLabel;
    
    bool productPagesLoaded;
}

// returns a Scene that contains the StoreLayer as the only child
+ (id) scene;

-(void)zipPlayer;
-(void)alertNoProducts:(id)sender;

@end
