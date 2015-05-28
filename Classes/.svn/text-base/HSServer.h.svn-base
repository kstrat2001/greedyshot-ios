//
//  HSServer.h
//  Time-Tap
//
//  Created by Kain Osterholt on 3/19/10.
//  Copyright 2010 AnalogPixels. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLScoreServerPost.h"
#import "CLScoreServerRequest.h"
#import "HSServerDelegate.h"

#define LOCAL_HS_KEY_PREFIX @"LOCAL_HS_"
#define PERSONAL_INFO_DISCLAIMER @"Congratulations!  You have achieved a global high score!  Will you allow Greedy Shot to record your personal information in our global high scores database?"
#define COMM_LOSS_MSG @"High scores could not be retrieved at this time.  This is most likely due to a lost internet conneciton."
#define MAX_SHOWN_SCORES 3

#define HS_CATEGORY @"Classic"
#define HS_GAME_NAME @"Greedy Shot"

@interface HSServer : NSObject <CLPostDelegate, CLRequestDelegate, UIAlertViewDelegate>
{
    bool waitingForRequest;
    
    id <HSServerDelegate> serverDelegate;
}

@property (nonatomic, assign) id <HSServerDelegate> serverDelegate;

// Post scores to cocos live
-(void) postScore:(int)score forName:(NSString*)name;
-(void) requestScores;

-(void) attemptEntry:(NSArray*)scores newScore:(int)newScore;
-(void) showPersonalInfoDisclaimer;

// Singleton
+ (HSServer*)sharedInstance;
+ (id)allocWithZone:(NSZone *)zone;
- (id)copyWithZone:(NSZone *)zone;

@end
