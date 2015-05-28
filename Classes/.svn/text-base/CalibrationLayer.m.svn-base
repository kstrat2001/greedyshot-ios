//
//  CalibrationLayer.m
//  collector
//
//  Created by Kain Osterholt on 4/4/11.
//  Copyright 2011 C-Stick Run. All rights reserved.
//

#import "CalibrationLayer.h"
#import "SettingsLayer.h"
#import "MenuDefs.h"
#import "AudioDefs.h"
#import "AccelerometerFilter.h"
#import "GameSettings.h"
#import "Reticle.h"

@implementation CalibrationLayer

+(id) scene
{
	CCScene *scene = [CCScene node];
	CalibrationLayer *layer = [CalibrationLayer node];
	[scene addChild: layer];
	return scene;
}


-(id)init
{
    self = [super init];
    
    if(self != nil)
    {
        // enable accelerometer
		self.isAccelerometerEnabled = YES;
        self.isTouchEnabled = YES;
        
        accFilter = [[LowpassFilter alloc] initWithSampleRate:60 cutoffFrequency:70];
        
        reticle = [[Reticle alloc] init];
        [reticle setPosition:ccp(200, 180)];
        reticle.desiredPos = ccp(200, 180);
        [reticle setVisible:NO];
        [self addChild:reticle z:1000];
        
        //accOutput = [CCLabelTTF labelWithString:@"acc x: y:" fontName:@"Futura" fontSize:16];
        //[accOutput setPosition:ccp(240, 20)];
        //[self addChild:accOutput z:10];
        
        [self initMenu];
        
        [self schedule:@selector(update:) interval:1.0f/60.0f];
        
        [self performSelector:@selector(onStart:) withObject:nil afterDelay:2.0f];
    }
    
    return self;
}

-(void)onStart:(id)sender
{
    [reticle setVisible:YES];
}

-(void)initMenu
{
    CCMenuItemSprite* center = 
    [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:CENTER_BTN] 
                            selectedSprite:[CCSprite spriteWithFile:CENTER_BTN_PRESS]
                                    target:self
                                  selector:@selector(center:)];
    
    CCMenuItemSprite* flipxbtn = 
    [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:FLIPX_BTN] 
                            selectedSprite:[CCSprite spriteWithFile:FLIPX_BTN_PRESS]
                                    target:self
                                  selector:@selector(flipx:)];
    
    CCMenuItemSprite* flipybtn = 
    [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:FLIPY_BTN] 
                            selectedSprite:[CCSprite spriteWithFile:FLIPY_BTN_PRESS]
                                    target:self
                                  selector:@selector(flipy:)];
    

    
    settingsMenu = [CCMenu menuWithItems:center, flipxbtn, flipybtn, nil];
    
    [settingsMenu alignItemsHorizontallyWithPadding:15];
    [settingsMenu setPosition:ccp(240, 290)];
    
    [self addChild:settingsMenu z:5];

    
    CCMenuItemSprite* back = 
    [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:BACK_BTN] 
                            selectedSprite:[CCSprite spriteWithFile:BACK_BTN_PRESS]
                                    target:self
                                  selector:@selector(exit:)];

    CCMenu* backMenu = [CCMenu menuWithItems:back, nil];
    [backMenu setPosition:ccp(240, 30)];
    [self addChild:backMenu z:10];
}

-(void)center:(id)sender
{
        PLAY_SOUND(MENU_SELECT_SND);
    [GameSettings sharedInstance].calx = currentX;
    [GameSettings sharedInstance].caly = currentY;
    
    [[GameSettings sharedInstance] save];
}

-(void)flipx:(id)sender
{
        PLAY_SOUND(MENU_SELECT_SND);
    [GameSettings sharedInstance].flipx = ![GameSettings sharedInstance].flipx;
    [[GameSettings sharedInstance] save];
}

-(void)flipy:(id)sender
{
        PLAY_SOUND(MENU_SELECT_SND);
    [GameSettings sharedInstance].flipy = ![GameSettings sharedInstance].flipy;
    
    [[GameSettings sharedInstance] save];
}

-(void)exit:(id)sender
{
    PLAY_SOUND(ORBIT_PICKUP_SND);
    CCScene* scene = [SettingsLayer scene];
    
    [[CCDirector sharedDirector] replaceScene: 
     [CCTransitionFade transitionWithDuration:2.0f scene:scene]];
}

-(void) update:(float)dt
{
    [reticle updateReticle:dt];
}

- (void)accelerometer:(UIAccelerometer*)accelerometer didAccelerate:(UIAcceleration*)acceleration
{
    [accFilter addAcceleration:acceleration];
    
    float xformY = accFilter.x;
    float xformX = accFilter.y * -1.0f;
    
    if( [GameSettings sharedInstance].flipx )
        xformX = -xformX;
    
    if( [GameSettings sharedInstance].flipy )
        xformY = -xformY;
    
    //[accOutput setString:[NSString stringWithFormat:@"Acc: x: %f,  y: %f", xformX, xformY]];
    
    currentX = -xformX;
    currentY = -xformY;
    
    float maxX = 480 * [GameSettings sharedInstance].sensitivity;
    float maxY = 320 * [GameSettings sharedInstance].sensitivity;
    
    float xOffset = clampf( ( (xformX + [GameSettings sharedInstance].calx ) * maxX) + 240, 0, 480);
    float yOffset = clampf( ( (xformY + [GameSettings sharedInstance].caly ) * maxY) + 160, 0, 320);
    
    reticle.desiredPos = ccp(xOffset, yOffset);
}

-(void)dealloc
{
    [accFilter release];
    [reticle release];
    [super dealloc];
}

@end
