//
//  MyViewController.h
//  HelloWorld
//
//  Created by Yan X Lin on 13/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


#import <UIKit/UIKit.h>
#include <AudioToolbox/AudioToolbox.h>


@interface MyViewController : UIViewController <UITextFieldDelegate> {
    
    UITextField *textField;
    UILabel *label;
    NSString *userName;
    NSTimer *repeatingTimer;
    NSUInteger minutesValue;
    NSUInteger secondsValue;
    NSUInteger currentSecondsValue;
    CFURLRef		soundFileURLRef;
    SystemSoundID	soundFileObject;
    UIView*myView;
    UIColor *imgcol;
    UIImage *img;
    UIImage *stretchedimg;
    CGRect *rect;
    UIImage *buttonBackgroundImage;
    UIImage *stretchedBackground;
    UIButton *button;
}
@property (nonatomic, retain) IBOutlet UIButton *button;

@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;


@property (nonatomic, retain) IBOutlet UILabel *label;

@property (nonatomic, retain) IBOutlet UITextField *textField;

@property (nonatomic, copy) NSString *userName;

@property (assign) NSTimer *repeatingTimer;

- (IBAction)changeGreeting:(id)sender;
- (NSDictionary *)userInfo;

@end
