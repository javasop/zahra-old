//
//  ContactZahrahViewController.m
//  Complete_Project
//
//  Created by adel alahmed on 11/13/12.
//  Copyright (c) 2012 nitin.gupta@ongraph.com. All rights reserved.
//

#import "ContactZahrahViewController.h"
#import "ContactInfoViewController.h"

@interface ContactZahrahViewController (){

    UIButton  *current_btn;
}

@end

@implementation ContactZahrahViewController
@synthesize info,cc,image_place_holder,large_dim,large_bright,small_dim,small_bright;

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
    

    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
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
    
    }else {
        // do animation for ipad
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
    
    if (b.tag == current_btn.tag) {
        
        image_place_holder.hidden = !image_place_holder.hidden;
        
    }else {
        image_place_holder.hidden = NO;
    }
        
    NSString *l = @"";
    
    
    NSString *ipad_img_name = @"";
    
    

    
    switch (b.tag) {
            
        case 100:
            l = @"Riyadh";
            ipad_img_name = @"TAWASUL_INFO_RIYADH_PAD";
            break;
        case 200:
           l = @"Madinah";
            //ipad_img_name = @"com_madinah_ipad";
            ipad_img_name  = @"TAWASUL_INFO_MADINAH_PAD";
            break;
        case 300:
             l = @"Jeddah";
            ipad_img_name = @"TAWASUL_INFO_JEDAH_PAD";
            //ipad_img_name = @"com_Jeddah_ipad";
            break;
        case 400:
            l = @"Abha";
            //ipad_img_name = @"com_Abha_ipad";
            ipad_img_name = @"TAWASUL_INFO_ABHA_PAD";
            break;
        case 0:
            l=@"ahsa";
            ipad_img_name = @"TAWASUL_INFO_A7SAA_PAD";
            break;
        default:
            break;
            
    }
    
    current_btn = b;

    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
    
            cc = [[ContactInfoViewController alloc] initWithNibName:@"ContactInfoViewController" bundle:nil];
        cc.city_name = l;
           [self.navigationController pushViewController:cc animated:YES];  
    }else {
        
        image_place_holder.image = [UIImage imageNamed:ipad_img_name];   
    }
    

}

-(IBAction)openSite:(id)sender{
    
    
    UIButton *b = (UIButton *)sender;
    
    NSString *l = @"";
    
    switch (b.tag) {
        case 0:
            case 10:
            l = @"http://www.Zahra.org.sa";
            break;
        case 1:
        case 11:
            l = @"http://instagram.com/ZAHRA_KSA";
            break;
        case 2:
        case 12:
            l = @"https://www.facebook.com/groups/ZahraAssociation/";
            break;
        case 3:
        case 13:
            l = @"http://www.youtube.com/user/ZahraAssociaChannel";
            break;
        case 4:
        case 14:
            l = @"https://twitter.com/zahra_ksa";
            break;
            
        default:
            break;
    }
    
    NSURL *url = [NSURL URLWithString:l];
    [[UIApplication sharedApplication] openURL:url];
}

@end
