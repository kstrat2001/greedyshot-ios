//
//  TextInputView.m
//  Odyssey
//
//  Created by Kain Osterholt on 5/16/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "TextInputView.h"
#import "RootViewController.h"
#import "HSServer.h"

@implementation TextInputView

@synthesize textInputField, dialogTitle, scoreLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self != nil) {
        
        score = 0;
        
        [self setupSubviews];
    }
    return self;
}


-(void) hideSelf:(id)sender
{
    [self removeFromSuperview];
}

- (void)setupSubviews
{
    self.backgroundColor = [UIColor clearColor];
    
    // Add fringe background
    bkgImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"black.png"]];
    bkgImage.transform = CGAffineTransformMakeRotation(M_PI_2);
    bkgImage.center = CGPointMake(self.center.x, self.center.y);
    
    CGFloat textFieldWidth = 240.0;
    CGFloat textFieldX = self.center.x + 30;
    CGFloat textFieldY = self.center.y;
    CGFloat textFieldHeight = 28.0;
    
    CGRect fieldRect = CGRectMake(textFieldX, textFieldY, textFieldWidth, textFieldHeight);
    
    textInputField = [[UITextField alloc] initWithFrame:fieldRect];
    textInputField.transform = CGAffineTransformMakeRotation(M_PI_2);
    textInputField.center = CGPointMake(textFieldX, textFieldY);
    textInputField.font = [UIFont boldSystemFontOfSize:20.0];
    textInputField.textColor = [UIColor blackColor];
    textInputField.backgroundColor = [UIColor clearColor];
    textInputField.textAlignment = UITextAlignmentCenter;
    textInputField.borderStyle = UITextBorderStyleRoundedRect;
    textInputField.delegate = self;
    textInputField.returnKeyType = UIReturnKeyDone;
    //[textInputField becomeFirstResponder];
    
    CGFloat labelX = self.center.x + 90;
    CGFloat labelY = self.center.y;
    
    scoreLabel = [[UILabel alloc] init];
    scoreLabel.frame = CGRectMake(0, 0, 400, 100);
    scoreLabel.transform = CGAffineTransformMakeRotation(M_PI_2);
    scoreLabel.center = CGPointMake(labelX, labelY);
    scoreLabel.text = @"High Score: ";
    scoreLabel.font = [UIFont fontWithName:@"Helvetica" size:46.0];
    scoreLabel.backgroundColor = [UIColor clearColor];
    scoreLabel.textColor = [UIColor whiteColor];
    scoreLabel.textAlignment = UITextAlignmentCenter;
    scoreLabel.adjustsFontSizeToFitWidth = YES;
    
    
    [self addSubview:bkgImage];
    [self addSubview:textInputField];
    [self addSubview:scoreLabel];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    // Enter pressed
    if([string compare:@"\n"] == 0)
    {
        [textInputField resignFirstResponder];
    }
    
    // Do not allow the string to become infinite. Only if the strings length is zero (delete was pressed) we handle the key.
    if(textField.text.length > 12 && string.length != 0)
    {
        return NO;
    }
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [[HSServer sharedInstance] postScore:score forName:textInputField.text];
    [[RootViewController sharedInstance] hideTextInputDialog];
}

-(void)setScore:(int)sc
{
    score = sc;
    
    NSMutableString* scoreStr = [NSMutableString stringWithString:@"High Score: "];
    [scoreStr appendFormat:@"%d", sc];
    
    scoreLabel.text = scoreStr;
}

-(void)showKeyboard
{
    [textInputField becomeFirstResponder];
}

- (void)dealloc {
    [bkgImage release];
    [scoreLabel release];
    [textInputField release];
    [super dealloc];
}




@end
