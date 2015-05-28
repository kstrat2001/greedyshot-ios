//
//  TextInputView.h
//  Odyssey
//
//  Created by Kain Osterholt on 5/16/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TextInputView : UIView <UITextFieldDelegate>{
    
    UITextField* textInputField;
    UILabel* scoreLabel;
    UIImageView* bkgImage;
    
    int score;
}

@property (nonatomic, readonly) UITextField* textInputField;
@property (nonatomic, readonly) UILabel* dialogTitle;
@property (nonatomic, readonly) UILabel* scoreLabel;

-(void) hideSelf:(id)sender;

-(void)setScore:(int)score;

- (void)setupSubviews;
- (void)showKeyboard;
- (id)initWithFrame:(CGRect)frame;

@end

