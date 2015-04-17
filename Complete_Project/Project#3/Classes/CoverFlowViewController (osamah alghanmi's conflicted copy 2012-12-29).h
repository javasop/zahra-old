//
//  CoverFlowViewController.h
//  StoreModule
//
//  Created by AgilePc-100 on 3/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import "CartPopOverViewController.h"
#import <Twitter/Twitter.h>

@class AppDelegate;
@class CartPopOverViewController;
@interface CoverFlowViewController : UIViewController <iCarouselDataSource, iCarouselDelegate,UIPopoverControllerDelegate>
{
    CartPopOverViewController *objpop;
    AppDelegate *app;
    NSString *strLable;
    IBOutlet UILabel *ProductPrice,*ProductDesc,*prdDesc,*prdPrice;
    IBOutlet UIButton *addCart;
    NSMutableArray *arr;
    NSArray *imgArray;
    UIPopoverController *popoverController;
}
@property (nonatomic, retain) IBOutlet iCarousel *carousel;
@property (nonatomic, retain) UIPopoverController *popoverController;
-(IBAction)AddToCart:(id)sender;
-(IBAction)AddProductToCart:(id)sender;
-(void)checkoutDone;
-(IBAction)tweet:(id)sender;
@end
