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
@synthesize image1, image2, image3, image4;

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
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:15.0];
    [UIView setAnimationRepeatCount:20.0f];
    [UIView setAnimationRepeatAutoreverses:YES];
    CGPoint pos = image1.center; 
    pos.x = 400.0f;
    image1.center = pos;
    CGPoint pos2 = image2.center; 
    pos2.x = -10.0;
    image2.center = pos2;
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

@end
