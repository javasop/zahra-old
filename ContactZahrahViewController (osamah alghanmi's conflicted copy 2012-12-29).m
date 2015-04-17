//
//  ContactZahrahViewController.m
//  Complete_Project
//
//  Created by adel alahmed on 11/13/12.
//  Copyright (c) 2012 nitin.gupta@ongraph.com. All rights reserved.
//

#import "ContactZahrahViewController.h"

@interface ContactZahrahViewController ()

@end

@implementation ContactZahrahViewController
@synthesize info;

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
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

-(IBAction)displayInfo:(id)sender{

    UIButton *b = (UIButton *)sender;
    
    NSString *l = @"";
    
    switch (b.tag) {

        case 100:
            l = @"Riyadh";
            break;
        case 200:
           l = @"Madinah";
            break;
        case 300:
             l = @"Jeddah";
            break;
        case 400:
            l = @"Abha";
            break;
            
        default:
            break;
    }
    
info.text =l;
    
}

-(IBAction)openSite:(id)sender{
    
    
    UIButton *b = (UIButton *)sender;
    
    NSString *l = @"";
    
    switch (b.tag) {
        case 0:
            l = @"http://www.zahrah.org.sa";
            break;
        case 1:
            l = @"http://www.flickr.com";
            break;
        case 2:
            l = @"http://www.facebook.com";
            break;
        case 3:
            l = @"http://wwww.youtube.com";
            break;
        case 4:
            l = @"http://www.twitter.com";
            break;
            
        default:
            break;
    }
    
    NSURL *url = [NSURL URLWithString:l];
    [[UIApplication sharedApplication] openURL:url];
}

@end
