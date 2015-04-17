//
//  DonateViewController.m
//  Complete_Project
//
//  Created by adel alahmed on 11/8/12.
//  Copyright (c) 2012 nitin.gupta@ongraph.com. All rights reserved.
//

#import "DonateViewController.h"

@interface DonateViewController ()

@end

@implementation DonateViewController
@synthesize small_bright, small_dim, large_bright, large_dim;

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
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) { // if iOS 7
        self.edgesForExtendedLayout = UIRectEdgeNone; //layout adjustements
    }
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:15.0];
    [UIView setAnimationRepeatCount:20.0f];
    [UIView setAnimationRepeatAutoreverses:YES];
    CGPoint pos = small_bright.center; 
    pos.x = 400.0f;
    small_bright.center = pos;
    CGPoint pos2 = small_dim.center; 
    pos2.x = -10.0;
    small_dim.center = pos2;
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


- (IBAction)sms:(id)sender {
    
      [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"sms:5092"]];
    
}
@end
