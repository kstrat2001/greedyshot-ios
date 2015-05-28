//
//  UIGameLayer.m
//  collector
//
//  Created by Kain Osterholt on 3/17/11.
//  Copyright 2011 C-Stick Run. All rights reserved.
//

#import "UIGameLayer.h"
#import "GameSettings.h"


@implementation UIGameLayer

-(id)init
{
    self = [super init];
    
    if(self != nil)
    {
        int x = 90;
        int y = 305;
        
        scoreLabel = [UIGameLayer createUILabel:@"Gold"];
        [scoreLabel setPosition:ccp(x, y)];
        [scoreLabel setColor:ccWHITE];
        [self addChild:scoreLabel z:100];
    
        x+=120;
        goalLabel = [UIGameLayer createUILabel:@"Goal"];
        [goalLabel setPosition:ccp(x, y)];
        [goalLabel setColor:ccWHITE];
        [self addChild:goalLabel z:100];
        
        x+=160;
        livesLabel = [UIGameLayer createUILabel:@"Lives"];
        [livesLabel setPosition:ccp(x, y)];
        [livesLabel setColor:ccWHITE];
        [self addChild:livesLabel z:100];
        
        x+=90;
        levelLabel = [UIGameLayer createUILabel:@"Level"];
        [levelLabel setPosition:ccp(x, y)];
        [levelLabel setColor:ccWHITE];
        [self addChild:levelLabel z:100];
    }
    
    return self;
}

+(CCLabelTTF*)createUILabel:(NSString*)text
{
    CGSize labelSize = CGSizeMake(150, 30);
    return [CCLabelTTF labelWithString:text dimensions:labelSize alignment:CCTextAlignmentLeft fontName:@"Futura" fontSize:18];
}

-(void)setGoldInLevel:(int)amount withGoal:(int)goal
{
    if(amount <= goal)
        [goalLabel setString:[NSString stringWithFormat:@"Goal: %d/%d", amount, goal]];
}

-(void)setScore:(int)score
{
    [scoreLabel setString:[NSString stringWithFormat:@"Gold: %d", score]];
}

-(void)setLives:(int)lives
{
    [livesLabel setString:[NSString stringWithFormat:@"Lives: %d", lives]];
}

-(void)setLevel:(int)level
{
    [levelLabel setString:[NSString stringWithFormat:@"Level: %d", (level + 1)]];
}

#pragma mark Update Labels


-(void)goldChanged:(int)amount
{
    [self setScore:amount];
}

@end
