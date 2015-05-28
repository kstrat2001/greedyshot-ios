//
//  ShotObject.h
//  collector
//
//  Created by Kain Osterholt on 3/28/11.
//  Copyright 2011 C-Stick Run. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ShotObject : NSObject 
{
    CGPoint target;
    UITouch* touch;
}

@property (nonatomic, assign) CGPoint target;
@property (nonatomic, assign) UITouch* touch;

@end
