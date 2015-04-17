//
//  LamsatZaharahIntroductionViewController.m
//  Complete_Project
//
//  Created by adel alahmed on 1/6/13.
//  Copyright (c) 2013 nitin.gupta@ongraph.com. All rights reserved.
//

#import "LamsatZaharahIntroductionViewController.h"
#import "SMViewController.h"

@interface LamsatZaharahIntroductionViewController ()

@end

@implementation LamsatZaharahIntroductionViewController

@synthesize large_dim, large_bright, small_dim, small_bright, scroll, img;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;

}

-(IBAction)goToStore:(id)sender{

    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
    
        sm = [[SMViewController alloc] initWithNibName:@"SMViewController" bundle:nil];
    }else {
    sm = [[SMViewController alloc] initWithNibName:@"SMViewController~ipad" bundle:nil];
    }
    

    [self.navigationController pushViewController:sm animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) { // if iOS 7
        self.edgesForExtendedLayout = UIRectEdgeNone; //layout adjustements
    }
    
    // Do any additional setup after loading the view from its nib.
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
        [scroll setContentSize:self.img.image.size];
        self.img.frame = CGRectMake(0, 0, 280, self.img.image.size.height);
        [scroll setScrollEnabled:YES];
        
    }

    
    
    // do animation; 
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
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end
