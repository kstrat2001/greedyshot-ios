//
//  PagedMenu.m
//  collector
//
//  Created by Kain Osterholt on 3/15/11.
//  Copyright 2011 C-Stick Run. All rights reserved.
//

#import "PagedMenu.h"
#import "PageLayer.h"
#import "AudioDefs.h"

#define PAGE_Y 8
#define OFF_DISTANCE 430

@implementation PagedMenu

@synthesize currentPage, totalPages;

-(void)loadPages:(id)sender
{
    NSAssert(false, @"Override this method");
}

-(id)init
{
    self = [super init];
    
    if(self != nil)
    {
        currentPage = 0;
        totalPages = 0;
        
        pages = [[NSMutableDictionary alloc] initWithCapacity:10];
        keys = [[NSMutableArray alloc] initWithCapacity:10];
        
        [self setupNav];
        [self loadPages:self];
    }
    
    return self;
}

-(void)addPage:(PageLayer*)page
{
    [self addChild:page z:2];
    
    if([pages count] != 0)
    {
        [page setPosition:ccp(OFF_DISTANCE, PAGE_Y)];
    }
    else {
        [page setPosition:ccp(0, PAGE_Y)];
    }

    
    [pages setObject:page forKey:page.pageName];
    [keys addObject:page.pageName];
    
    totalPages++;
}

-(void)nextPage:(id)sender
{
    if([pages count] > 0)
    {
        PLAY_SOUND(GOLD_PICKUP_SND);
        int lastPage = currentPage;
        
        if(currentPage < (totalPages - 1))
        {
            // do stuff;
            currentPage++;
        }
        else 
        {
            // go to first page
            currentPage = 0;
        }
        
        [self goToPage:currentPage fromPage:lastPage inDirection:true];
    }
}

-(void)previousPage:(id)sender
{
    if([pages count] > 0)
    {
        PLAY_SOUND(GOLD_PICKUP_SND);
        int lastPage = currentPage;
        
        if(currentPage > 0)
        {
            currentPage--;
        }
        else
        {
            currentPage = (totalPages - 1);
        }
        
        [self goToPage:currentPage fromPage:lastPage inDirection:false];
    }
}

-(void)goToPage:(int)toPage fromPage:(int)fromPage inDirection:(bool)forward
{
    NSLog(@"goToPage: %d from page: %d numPages: %d", toPage, fromPage, [pages count]);
    
    PageLayer* fromLayer = [pages objectForKey:[keys objectAtIndex:fromPage]];
    PageLayer* toLayer = [pages objectForKey:[keys objectAtIndex:toPage]];
    
    if(!forward)
    {
        [toLayer setPosition:ccp(-OFF_DISTANCE, PAGE_Y)];
        id moveIn = [CCMoveTo actionWithDuration:0.4 position:ccp(0, PAGE_Y)];
        id ease1 = [CCEaseInOut actionWithAction:moveIn rate:3.0];
        [toLayer runAction: ease1];
        
        id moveOut = [CCMoveTo actionWithDuration:0.3 position:ccp(OFF_DISTANCE, PAGE_Y)];
        id ease2 = [CCEaseInOut actionWithAction:moveOut rate:3.0];
        [fromLayer runAction: ease2];
    }
    else 
    {
        [toLayer setPosition:ccp(OFF_DISTANCE, PAGE_Y)];
        id moveIn = [CCMoveTo actionWithDuration:0.4 position:ccp(0, PAGE_Y)];
        id ease1 = [CCEaseInOut actionWithAction:moveIn rate:3.0];
        [toLayer runAction: ease1];
        
        id moveOut = [CCMoveTo actionWithDuration:0.3 position:ccp(-OFF_DISTANCE, PAGE_Y)];
        id ease2 = [CCEaseInOut actionWithAction:moveOut rate:3.0];
        [fromLayer runAction: ease2];
    }
    
}

-(void)enablePages:(bool)enable
{
    for(PageLayer* page in pages)
    {
        page.isTouchEnabled = enable;
    }
}

-(PageLayer*)pageForKey:(NSString*)key
{
    return [pages objectForKey:key];
}

-(void)setupNav
{
    
    CCMenuItemSprite* previousPageBtn = 
    [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:@"arrow_btn_left.png"] 
                            selectedSprite:[CCSprite spriteWithFile:@"arrow_btn_left_pressed.png"]
                                  target:self
                                selector:@selector(previousPage:)];
    
    CCMenuItemSprite* nextPageBtn = 
    [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:@"arrow_btn.png"] 
                            selectedSprite:[CCSprite spriteWithFile:@"arrow_btn_pressed.png"]
                                  target:self
                                selector:@selector(nextPage:)];
    
    nav = [CCMenu menuWithItems:previousPageBtn, nextPageBtn, nil];
    [nav alignItemsHorizontallyWithPadding:360];
    [nav setPosition:ccp(240, 160 + PAGE_Y)];

    [self addChild:nav z:5];
}

-(void)dealloc
{
    [pages release];
    [keys release];
    
    [super dealloc];
}

@end
