//
//  RootViewController.h
//  collector
//
//  Created by Kain Osterholt on 2/24/11.
//  Copyright C-Stick Run 2011. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewDelegate.h"

@class TextInputView;

@interface RootViewController : UIViewController {

    TextInputView* dialogTextInput;
    UIActivityIndicatorView *   activityIndicator;
    
    id <RootViewDelegate> rootDelegate;
}

@property (nonatomic, assign) id <RootViewDelegate> rootDelegate;

- (void) suspend:(BOOL)suspend;

- (void) setHighScoreInfo:(int)score;
- (void) enterHighScore;

// Show hide the high score entry
- (void) hideTextInputDialog;
- (void) showTextInputDialog;

// Loading activity indication
- (void) animateActivityIndicator:(bool)active;

// Singleton
+ (RootViewController*)sharedInstance;

@end
