//
//  PageLayer.m
//  collector
//
//  Created by Kain Osterholt on 3/15/11.
//  Copyright 2011 C-Stick Run. All rights reserved.
//

#import "PageLayer.h"


@implementation PageLayer

@synthesize pageName;

-(id)init
{
    self = [super init];
    
    if(self != nil)
    {
        bg = [CCSprite spriteWithFile:@"item_bg.png"];
        [self addChild:bg z:1];
        [bg setPosition:ccp(240, 158)];
    }
    
    return self;
}

@end
