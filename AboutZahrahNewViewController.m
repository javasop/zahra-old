//
//  AboutZahrahNewViewController.m
//  Complete_Project
//
//  Created by adel alahmed on 1/6/13.
//  Copyright (c) 2013 nitin.gupta@ongraph.com. All rights reserved.
//

#import "AboutZahrahNewViewController.h"

@interface AboutZahrahNewViewController ()

@end

@implementation AboutZahrahNewViewController
@synthesize scroll, img, small_dim, small_bright,large_dim, large_bright;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) { // if iOS 7
        self.edgesForExtendedLayout = UIRectEdgeNone; //layout adjustements
    }
    
    
                if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
    [scroll setContentSize:self.img.image.size];
    self.img.frame = CGRectMake(0, 0, 280, self.img.image.size.height);
                }    
                    
        // do animation.. 
              
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:15.0];
    [UIView setAnimationRepeatCount:20.0f];
    [UIView setAnimationRepeatAutoreverses:YES];
    CGPoint pos = large_bright.center; 
    pos.x = 400.0f;
    large_bright.center = pos;
    CGPoint pos2 = large_dim.center; 
    pos2.x = -10.0;
    large_dim.center = pos2;
    [UIView commitAnimations];
                
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return NO;
}

-(IBAction)playVideo:(id)sender{

    // add a video player .. 
    
//NSString *path = [[NSBundle mainBundle] pathForResource:@"zahrah_movie" ofType:@"3gp"];
  //  NSURL *videoURL = [NSURL fileURLWithPath:path];
  
    // MPMoviePlayerController * moviePlayerController = [[MPMoviePlayerController alloc] initWithContentURL:videoURL];  
     
     /*
     [[NSNotificationCenter defaultCenter] addObserver:self  
     selector:@selector(moviePlaybackDidFinish:)  
     name:MPMoviePlayerPlaybackDidFinishReasonUserInfoKey
     object:moviePlayerController];  
     */
    
    // moviePlayerController.fullscreen = YES;
    // moviePlayerController.scalingMode = MPMovieScalingModeAspectFit;
    //[moviePlayerController play]; 
   // UIAlertView *alrt = [[UIAlertView alloc] initWithTitle:@"Video Clicked" message:@"" delegate:nil cancelButtonTitle:@"Ok!" otherButtonTitles:nil];
   // [alrt show];
    
    //[moviePlayerController play];

    
    NSString *url_string = @"https://www.youtube.com/watch?v=-p3TFqIFpP4";
    NSURL *url = [NSURL URLWithString:url_string];
    [[UIApplication sharedApplication] openURL:url];
    
}



@end
