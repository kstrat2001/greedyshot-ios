//
//  PagedMenu.h
//  collector
//
//  Created by Kain Osterholt on 3/15/11.
//  Copyright 2011 C-Stick Run. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#import "GreedyMenu.h"

@class PageLayer;

@interface PagedMenu : GreedyMenu 
{
    int currentPage;
    int totalPages;
    
    CCMenu* nav;
    
    NSMutableDictionary* pages;
    NSMutableArray* keys;
}

@property (nonatomic, readonly) int currentPage;
@property (nonatomic, readonly) int totalPages;

-(void)setupNav;
-(void)addPage:(PageLayer*)page;

-(PageLayer*)pageForKey:(NSString*)key;

-(void)nextPage:(id)sender;
-(void)previousPage:(id)sender;

-(void)goToPage:(int)toPage fromPage:(int)fromPage inDirection:(bool)forward;

-(void)loadPages:(id)sender;
-(void)enablePages:(bool)enable;

@end