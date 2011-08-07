//
//  MyViewController.m
//  HelloWorld
//
//  Created by Yan X Lin on 13/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MyViewController.h"


@implementation MyViewController

@synthesize label;
@synthesize textField;
@synthesize userName;
@synthesize repeatingTimer;
@synthesize button;
@synthesize soundFileURLRef;
@synthesize soundFileObject;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) viewDidLoad {
    
    [super viewDidLoad];
    
    UIImage *img = [UIImage imageNamed:@"the-niagara-river.png"];
    UIImage *stretchedimg = [img stretchableImageWithLeftCapWidth:0 topCapHeight:412];
    //    UIImage* stretchedimg = [img drawInRect:(CGRectMake(0,0,640,960))];
    CGRect rect=CGRectMake(0,0,640,960);
    //    UIImage* stretchedimg = [img drawInRect:rect];
    //    UIImageView *img=[[UIImageView alloc]initWithFrame:rect];
    
    
    UIColor *imgcol = [[UIColor alloc] initWithPatternImage: stretchedimg];
    
    //    UIImage *img = [UIImage imageNamed:@"the-niagara-river.png"];
    self.view.backgroundColor = imgcol;
    [imgcol release];
    //    [self.UIView setBackgroundColor:[UIColor colorWithPatternImage:img]];
    UIImage *buttonBackgroundImage = [UIImage imageNamed:@"green-beer-bottle2.png"];
    
    UIImage *stretchedBackground = [buttonBackgroundImage stretchableImageWithLeftCapWidth:33 topCapHeight:0];
    
    //    [button setImage:stretchedBackground forState:UIControlStateNormal];
    
    //    [button setBackgroundImage:stretchedBackground forState:UIControlStateNormal];
    
    
    
    // Create the URL for the source audio file. The URLForResource:withExtension: method is
    //    new in iOS 4.0.
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"My Song 3.1"
                                                withExtension: @"aif"];
    
    // Store the URL as a CFURLRef instance
    self.soundFileURLRef = (CFURLRef) [tapSound retain];
    
    // Create a system sound object representing the sound file.
    AudioServicesCreateSystemSoundID (
                                      
                                      soundFileURLRef,
                                      &soundFileObject
                                      );
}


- (void)dealloc
{
    [textField release];
    [label release];
    [userName release];
    [button release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


- (void)viewDidUnload
{
    [self setTextField:nil];
    [self setLabel:nil];
    [self setButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if (theTextField == textField) {
        [textField resignFirstResponder];
    }
    return YES;
}

-(void)stopTimer{
    self. userName = textField.text;
    
    NSString * nameString = self.userName;
    if([nameString length] == 0) {
        nameString = @"World";
    }
    NSString * greeting = [[NSString alloc]initWithFormat:@"Hello, %@!", nameString];
    label.text = greeting;
    [greeting release];
    
    [repeatingTimer invalidate]; //Stops the Timer and removes from runloop
    NSLog(@"Countdown completed"); // Here u can add ur beep code to notify
    AudioServicesPlaySystemSound (soundFileObject);
    AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);
    
}



-(void)countdownMinutes{
    
    if(minutesValue == 0)
        [self stopTimer]; 
    else
        --minutesValue;
    
}

-(void)countdownSeconds{
    
    if(secondsValue == 0 )
    {
        [self countdownMinutes];
        secondsValue = 59;
    }
    else
    {
        --secondsValue;
    }
    currentSecondsValue = secondsValue%30;
    if(currentSecondsValue == 0 )
    {
        AudioServicesPlaySystemSound (soundFileObject);
        AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);
    }
    
}

-(void)countdown{
    
    NSLog(@"Countdown : %d:%d",minutesValue,secondsValue);//Use this value to display on your UI Screen
    //    NSString * greeting = [[NSString alloc]initWithFormat:@"Countdown : %d:%d",minutesValue,currentSecondsValue];
    NSString * greeting = [[NSString alloc]initWithFormat:@"Countdown : %d",currentSecondsValue];
    label.text = greeting;
    [self countdownSeconds];//Decrement the time by one second
}

- (NSDictionary *)userInfo { return [NSDictionary dictionaryWithObject:[NSDate date] forKey:@"StartDate"];
}

- (void)targetMethod:(NSTimer*)theTimer {
    NSDate *startDate = [[theTimer userInfo] objectForKey:@"StartDate"]; NSLog(@"Timer started on %@", startDate);
    
    self. userName = textField.text;
    
    NSString * nameString = self.userName;
    if([nameString length] == 0) {
        nameString = @"World";
    }
    NSString * greeting = [[NSString alloc]initWithFormat:@"Hello, %@!", nameString];
    label.text = greeting;
    [greeting release];
    
}

- (IBAction)changeGreeting:(id)sender {
    minutesValue = 2;
    secondsValue = 30;
    [repeatingTimer invalidate]; //Stops the Timer and removes from runloop
    repeatingTimer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(countdown) userInfo:nil repeats:YES];//Timer with interval of one second
    [[NSRunLoop mainRunLoop] addTimer:repeatingTimer forMode:NSDefaultRunLoopMode];
    
}
@end
