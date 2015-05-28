//
//  RootViewController.m
//  Jerkit
//
//  Created by Kain Osterholt on 1/17/11.
//  Copyright C-Stick Run 2011. All rights reserved.
//

//
// RootViewController + iAd
// If you want to support iAd, use this class as the controller of your iAd
//

#import "cocos2d.h"
#import "RootViewController.h"
#import "TextInputView.h"

static RootViewController *sharedInstance = nil;

@implementation RootViewController

@synthesize rootDelegate;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        sharedInstance = self;
        
        activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
        activityIndicator.center = CGPointMake(applicationFrame.size.width/2, applicationFrame.size.height/2);
        dialogTextInput = [[TextInputView alloc] initWithFrame: applicationFrame];
        
        activityIndicator.hidden = YES;
        
        dialogTextInput.alpha = 0.0;
	}
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

+(RootViewController*) sharedInstance
{
    return sharedInstance;
}

- (void) suspend:(BOOL)suspend
{
    [rootDelegate rootViewWasSuspended:suspend];
}

- (void) animateActivityIndicator:(bool)active
{
    if(active)
    {
        [[[CCDirector sharedDirector] openGLView] addSubview:activityIndicator];
        [activityIndicator startAnimating];
    }
    else 
    {
        [activityIndicator stopAnimating];
        [activityIndicator removeFromSuperview];
    }
    
}

-(void) setHighScoreInfo:(int)score
{
    [dialogTextInput setScore:score];
}

- (void) enterHighScore
{
    [self showTextInputDialog];
}

- (void) showTextInputDialog
{
    [[[CCDirector sharedDirector] openGLView] addSubview:dialogTextInput];
    
    dialogTextInput.textInputField.text = @"";
    dialogTextInput.textInputField.placeholder = @"Please enter a name";
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.7];
    dialogTextInput.alpha = 1.0;
    [UIView commitAnimations];
    
    [dialogTextInput showKeyboard];
}

- (void) hideTextInputDialog
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.7];
    [UIView setAnimationDidStopSelector:@selector(hideSelf:)];
    [UIView setAnimationDelegate:dialogTextInput];
    dialogTextInput.alpha = 0.0;
    
    [UIView commitAnimations];
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self showTextInputDialog];
    }
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [dialogTextInput release];
    [activityIndicator release];
    [super dealloc];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return NO;
}


@end


