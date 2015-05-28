//
//  collectorAppDelegate.m
//  collector
//
//  Created by Kain Osterholt on 2/24/11.
//  Copyright C-Stick Run 2011. All rights reserved.
//

#import "cocos2d.h"

#import "collectorAppDelegate.h"
#import "GameConfig.h"
#import "MainMenuLayer.h"
#import "GameSettings.h"
#import "RootViewController.h"
#import "StoreManager.h"
#import "AudioDefs.h"

@implementation collectorAppDelegate

@synthesize window;

- (void) applicationDidFinishLaunching:(UIApplication*)application
{
    [[AudioManager sharedInstance] loadAllSounds];
    
	// Init the window
	window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	if( ! [CCDirector setDirectorType:kCCDirectorTypeDisplayLink] )
		[CCDirector setDirectorType:kCCDirectorTypeDefault];
	
	CCDirector *director = [CCDirector sharedDirector];
	
	// Init the View Controller
	viewController = [[RootViewController alloc] initWithNibName:nil bundle:nil];
	viewController.wantsFullScreenLayout = YES;
	
	EAGLView *glView = [EAGLView viewWithFrame:[window bounds]
								   pixelFormat:kEAGLColorFormatRGB565	// kEAGLColorFormatRGBA8
								   depthFormat:0						// GL_DEPTH_COMPONENT16_OES
						];
	[glView setMultipleTouchEnabled:YES];
    
	// attach the openglView to the director
	[director setOpenGLView:glView];
	
//	// Enables High Res mode (Retina Display) on iPhone 4 and maintains low res on all other devices
//	if( ! [director enableRetinaDisplay:YES] )
//		CCLOG(@"Retina Display Not supported");
	
	[director setDeviceOrientation:kCCDeviceOrientationLandscapeLeft];
	
	[director setAnimationInterval:1.0/60];
	//[director setDisplayFPS:YES];
	
	
	// make the OpenGLView a child of the view controller
	[viewController setView:glView];
	
	// make the View Controller a child of the main window
	[window addSubview: viewController.view];
	
	[window makeKeyAndVisible];
	
	// Default texture format for PNG/BMP/TIFF/JPEG/GIF images
	// It can be RGBA8888, RGBA4444, RGB5_A1, RGB565
	// You can change anytime.
	[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];

	CC_ENABLE_DEFAULT_GL_STATES();
	CGSize size = [[CCDirector sharedDirector] winSize];
	CCSprite *sprite = [CCSprite spriteWithFile:@"Default.png"];
	sprite.position = ccp(size.width/2, size.height/2);
	sprite.rotation = -90;
	[sprite visit];
	[glView swapBuffers];
	CC_ENABLE_DEFAULT_GL_STATES();
    
    [[GameSettings sharedInstance] load];
    
    // Restore the in app purchase shop
    [StoreManager sharedInstance];
	
	// Run the intro Scene
	[[CCDirector sharedDirector] runWithScene:
     [CCTransitionFade transitionWithDuration:1.0f scene:[MainMenuLayer scene]]];
}


- (void)applicationWillResignActive:(UIApplication *)application 
{
	[[CCDirector sharedDirector] pause];
    [[RootViewController sharedInstance] suspend:true];
}

- (void)applicationDidBecomeActive:(UIApplication *)application 
{
	[[CCDirector sharedDirector] resume];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application 
{
	[[CCDirector sharedDirector] purgeCachedData];
}

-(void) applicationDidEnterBackground:(UIApplication*)application 
{
	[[CCDirector sharedDirector] stopAnimation];
    [[RootViewController sharedInstance] suspend:true];
}

-(void) applicationWillEnterForeground:(UIApplication*)application 
{
	[[CCDirector sharedDirector] startAnimation];
}

- (void)applicationWillTerminate:(UIApplication *)application 
{
	CCDirector *director = [CCDirector sharedDirector];
	[[director openGLView] removeFromSuperview];
	[director end];	
}

- (void)applicationSignificantTimeChange:(UIApplication *)application 
{
	[[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
}

- (void)dealloc 
{
	[[CCDirector sharedDirector] release];
    [viewController release];
    [window release];
	[super dealloc];
}

@end
