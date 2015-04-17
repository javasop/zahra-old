//
//  members.m
//  Complete_Project
//
//  Created by adel alahmed on 7/22/12.
//  Copyright (c) 2012 nitin.gupta@ongraph.com. All rights reserved.
//

#import "members.h"
//#import "register_for_membership.h"
//#import "DonateViewController.h"
#import "rfm_ViewController.h"
@implementation members

@synthesize large_dim,large_bright,small_bright,small_dim,r,reg, dict,iphone_scroll;



-(UIImageView *)scrollbarImageViewWithIndex:(int)indexOffset 
{
    int viewsCount = [[iphone_scroll subviews] count];
    UIImageView *scrollBar = [[iphone_scroll subviews] objectAtIndex:viewsCount - indexOffset - 1];
    return scrollBar;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) { // if iOS 7
        self.edgesForExtendedLayout = UIRectEdgeNone; //layout adjustements
    }
    
    // Do any additional setup after loading the view from its nib.
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
    
    // if iphone do scroll. 
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
        [iphone_scroll setScrollEnabled:YES];
        [iphone_scroll setContentSize:CGSizeMake(100, 1777)];
        [iphone_scroll flashScrollIndicators];
        
        //UIImageView *scrollBar = [self scrollbarImageViewWithIndex: UIScrollViewVerticalBarIndexOffset];
        
        //The try setting hidden property/ alpha value
        //scrollBar.hidden = NO;
        
        
        [iphone_scroll flashScrollIndicators];
    }

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


-(IBAction)register_for_membrship:(id)sender{

    NSString *msg;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {

        
                r = [[rfm_ViewController alloc] initWithNibName:@"rfm_ViewController_iphone" bundle:nil];
//        local_dictionary = [[NSMutableDictionary alloc] initWithCapacity:10];
        
    } else 
    { 
        msg = [NSString stringWithFormat:@"%@",@"iPad"];
                        r = [[rfm_ViewController alloc] initWithNibName:@"rfm_ViewController" bundle:nil];
    }
    [self.navigationController pushViewController:r animated:YES];

}

@end
