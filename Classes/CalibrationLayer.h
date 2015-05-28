//
//  CalibrationLayer.h
//  collector
//
//  Created by Kain Osterholt on 4/4/11.
//  Copyright 2011 C-Stick Run. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class Reticle;
@class LowpassFilter;

@interface CalibrationLayer : CCLayer
{
    Reticle* reticle;
    CCMenu* settingsMenu;
    
    CCLabelTTF* accOutput;
    
    LowpassFilter* accFilter;
    
    float currentX;
    float currentY;
}

+(id) scene;

-(void)initMenu;

@end
