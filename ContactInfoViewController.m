//
//  ContactInfoViewController.m
//  Complete_Project
//
//  Created by adel alahmed on 11/24/12.
//  Copyright (c) 2012 nitin.gupta@ongraph.com. All rights reserved.
//

#import "ContactInfoViewController.h"

@interface ContactInfoViewController ()

@end

@implementation ContactInfoViewController
@synthesize image_placeholder, city_name,img;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) { // if iOS 7
        self.edgesForExtendedLayout = UIRectEdgeNone; //layout adjustements
    }
    // Do any additional setup after loading the view from its nib.
    
    if ([city_name  isEqual: @"Riyadh"]) {
        img = [UIImage imageNamed:@"TAEASUL_INFO_RIYADH_PHONE"];
    }
    if ([city_name  isEqual: @"Jeddah"]) {
        img = [UIImage imageNamed:@"TAEASUL_INFO_JEDDAH_PHONE"];
    }
    if ([city_name  isEqual: @"Abha"]) {
        img = [UIImage imageNamed:@"TAEASUL_INFO_ABHA_PHONE"];
    }
    if ([city_name  isEqual: @"Madinah"]) {
        img = [UIImage imageNamed:@"TAEASUL_INFO_MADINAH_PHONE"];
    }
    if([city_name  isEqual: @"ahsa"]){
                img = [UIImage imageNamed:@"TAEASUL_INFO_A7SAA_PHONE"];
        
    }
    image_placeholder.image = img;
    

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return interfaceOrientation == UIInterfaceOrientationPortrait;
}


@end
