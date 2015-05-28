//
//  HSServer.m
//  Time-Tap
//
//  Created by Kain Osterholt on 3/19/10.
//  Copyright 2010 AnalogPixels. All rights reserved.
//

#import "RootViewController.h"
#import "HSServerDelegate.h"
#import "Gamedefs.h"
#import "MenuDefs.h"
#import "HSServer.h"

static HSServer *sharedInstance = nil;

@implementation HSServer

@synthesize serverDelegate;

-(void) requestScores
{
    // create a Request object for the game "DemoGame" 
    // You need to implement the Score Request Delegate
    CLScoreServerRequest *request = [[CLScoreServerRequest alloc] initWithGameName:HS_GAME_NAME delegate:self];
    
    /* use kQueryFlagIgnore to request World scores */
    tQueryFlags flags = kQueryFlagIgnore;
    
    /* or use kQueryFlagCountry to request the best scores of your country */
    // tQueryFlags flags = kQueryFlagByCountry;
    
    // request the first 10 scores ( offset:0 limit:10)
    // request AllTime best scores (this is the only supported option in v0.1
    // request the scores for the category "easy"
    [request requestScores:kQueryAllTime limit:MAX_SHOWN_SCORES offset:0 flags:flags category:HS_CATEGORY];
    
    // Release. It won't be freed from memory until the connection fails or suceeds
    [request release];
}

// ScoreRequest delegate
-(void) scoreRequestOk: (id) sender
{
    NSArray* scores = [sender parseScores];
    [serverDelegate scoreRequestComplete:true withScores:scores];
}

-(void) scoreRequestFail: (id) sender
{
    // request failed. Display an error message.
    [serverDelegate scoreRequestComplete:false withScores:nil];
}

-(void) postScore:(int)score forName:(NSString*)name
{
    // Create que "post" object for the game "DemoGame"
    // The gameKey is the secret key that is generated when you create you game in cocos live.
    // This secret key is used to prevent spoofing the high
    CLScoreServerPost *server = [[CLScoreServerPost alloc] initWithGameName:HS_GAME_NAME gameKey:@"a234b9ef0c08c833b981e5c6da39491b" delegate:self];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:4];
    
    [dict setObject:name forKey:@"cc_playername"];
    [dict setObject: [NSNumber numberWithInt: score ] forKey:@"cc_score"];
    
    // cc_ are fields that cannot be modified. cocos fields
    // set category... it can be "easy", "medium", whatever you want.
    [dict setObject:HS_CATEGORY forKey:@"cc_category"];
    
    [server sendScore:dict];
    
    // Release. It won't be freed from memory until the connection fails or suceeds
    [server release];
}

// PostScore Delegate
-(void) scorePostOk: (id) sender
{
    // Score post successful
    NSLog(@"Post successful");
    [serverDelegate scoreEntryComplete:true];
}

-(void) scorePostFail: (id) sender
{
    // score post failed
    tPostStatus status = [sender postStatus];
    if( status == kPostStatusPostFailed ) {
        // an error with the server ?
        // try again
        NSLog(@"Post failed: Server");
    }
    else if( status == kPostStatusConnectionFailed )
    {
        // a error establishing the connection ?
        // turn-on wifi, and then try again
        NSLog(@"Post failed: Connection");
    }
    else
    {
        NSLog(@"Post failed: General");
    }
    
    [serverDelegate scoreEntryComplete:false];
}

-(void) scoreRequestRankOk:(id)sender
{
}

-(void)showPersonalInfoDisclaimer
{
    UIAlertView* alert = [[[UIAlertView alloc] initWithTitle: @"Global High Score!"
                                                     message: PERSONAL_INFO_DISCLAIMER
                                                    delegate: self 
                                           cancelButtonTitle: nil
                                           otherButtonTitles: @"No", @"Yes", nil] autorelease];
    
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) 
    {
        [[RootViewController sharedInstance] enterHighScore];
    }
    else 
    {
        [serverDelegate scoreEntryComplete:false];
    }

}

-(void) attemptEntry:(NSArray*)scores newScore:(int)newScore
{
    bool shouldRecordNewHigh = false;
    
    if([scores count] >= MAX_SHOWN_SCORES)
    {
        NSDictionary* score = [scores objectAtIndex:([scores count] - 1)];
        int lowestInTop = [[score objectForKey:@"cc_score"] integerValue];
        
        if(newScore > lowestInTop)
        {
            shouldRecordNewHigh = true;
        }
    }
    else 
    {
        shouldRecordNewHigh = true;
    }

    if(shouldRecordNewHigh)
    {
        [[RootViewController sharedInstance] setHighScoreInfo:newScore];
        [self showPersonalInfoDisclaimer];
    }
    else
    {
        [serverDelegate scoreEntryComplete:false];
    }
}

#pragma mark -
#pragma mark Singleton methods

-(id)init
{
    if(self == [super init])
    {
    }
    
    return self;
}

+ (HSServer*)sharedInstance
{
    @synchronized(self)
    {
        if (sharedInstance == nil)
            sharedInstance = [HSServer alloc];
        sharedInstance = [sharedInstance init];
    }
    return sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (sharedInstance == nil) {
            sharedInstance = [super allocWithZone:zone];
            return sharedInstance;  // assignment and return on first allocation
        }
    }
    return nil; // on subsequent allocation attempts return nil
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)retain {
    return self;
}

- (unsigned)retainCount {
    return UINT_MAX;  // denotes an object that cannot be released
}

- (void)release {
    //
}

- (id)autorelease {
    return self;
}

@end

