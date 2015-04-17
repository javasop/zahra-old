//
//  CoverFlowViewController.m
//  StoreModule
//
//  Created by AgilePc-100 on 3/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CoverFlowViewController.h"
#import "AsyncImageView.h"
#import "CartPopOverViewController.h"
#import "CheckOutViewController.h"

#define NUMBER_OF_ITEMS ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)? 19: 12)
#define ITEM_SPACING 210

@implementation CoverFlowViewController

@synthesize carousel;
@synthesize popoverController;
@synthesize isLoading;
- (void)dealloc
{
    carousel.delegate = nil;
    carousel.dataSource = nil;
    [carousel release];
    [super dealloc];
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {         
        app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        imgArray=[[app.mainArray objectAtIndex:app.buttonSelected] objectForKey:@"product_images"];
        objpop = [[CartPopOverViewController alloc]initWithNibName:@"CartPopOverViewController" bundle:nil];
        objpop.cartObj = self;
    }
    return self;
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad
{

    objpop.cartObj = self;
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) { // if iOS 7
        self.edgesForExtendedLayout = UIRectEdgeNone; //layout adjustements
    }
    arr = [app.mainArray copy];
    carousel.type = iCarouselTypeCoverFlow2;
    NSString *strName=[[arr objectAtIndex:app.buttonSelected] objectForKey:@"product_name"];
    NSString *strPrice=[[arr objectAtIndex:app.buttonSelected] objectForKey:@"product_price"];
    NSString *strDesc=[[arr objectAtIndex:app.buttonSelected] objectForKey:@"product_description"];
    [ProductPrice setText:strPrice];
    ProductPrice.textColor = [UIColor whiteColor];
    ProductPrice.textAlignment = UITextAlignmentRight;
    
    [ProductDesc setText:strDesc];
    ProductDesc.textColor = [UIColor whiteColor];
    ProductDesc.textAlignment = UITextAlignmentRight;
    
    
    self.navigationItem.title=strName;
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(checkoutDone)
     name:@"checkoutDone"
     object:popoverController.contentViewController];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"سلة المشتريات" style:UIBarButtonItemStylePlain target:self action:@selector(AddToCart:)];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [isLoading setHidden:YES];
}

-(void)checkoutDone
{
    if ([app.cartArray count]>0) {
        if (app.device != 0) {
            [popoverController dismissPopoverAnimated:YES];
        }
        CheckOutViewController *obj = [[CheckOutViewController alloc]initWithNibName:@"CheckOutViewController" bundle:nil];
        [self.navigationController pushViewController:obj animated:YES];
    }
    else{
        UIAlertView *alertMsg= [[UIAlertView alloc] initWithTitle:@"التسوق" message:@"الرجاء إضافة منتجات للسلة" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertMsg show];
        [alertMsg release];
    }
}

-(IBAction)AddToCart:(id)sender{
    if (app.device == 0) {
        CartPopOverViewController* content = [[CartPopOverViewController alloc] initWithNibName:@"CartPopOverViewControllerPre" bundle:nil];
        [self.navigationController presentModalViewController:content animated:YES];
        [content release];
    }
    else{
        if ([popoverController isPopoverVisible]) {
            NSLog(@"PopOver is already visible");
        }
        else{
            CartPopOverViewController* content = [[CartPopOverViewController alloc] init];
            UIPopoverController* aPopover = [[UIPopoverController alloc]
                                     initWithContentViewController:content];
            aPopover.delegate = self;
            self.popoverController = aPopover;
            [self.popoverController setPopoverContentSize:CGSizeMake(400, 460)];
            [self.popoverController presentPopoverFromBarButtonItem:sender
                                   permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        }
    }
}
-(IBAction)AddProductToCart:(id)sender{
        NSMutableDictionary *dict= [arr objectAtIndex:app.buttonSelected];
        if (![app.cartArray containsObject:dict]) {
            [app.cartArray addObject:dict];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"التسوق" message:@"تم إضافة المنتج لسلة المشتريات" delegate:self cancelButtonTitle:nil otherButtonTitles:@"موافق", nil];
            [alert show];
            [alert release];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"التسوق" message:@"تم إضافة هذا المنتج مسبقا إلى سلة المشتريات" delegate:self cancelButtonTitle:nil otherButtonTitles:@"موافق", nil];
            [alert show];
            [alert release];
        }
   
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    self.carousel = nil;
}
-(void)viewWillAppear:(BOOL)animated{
    if (app.device != 0) { 
        if ([[UIApplication sharedApplication]statusBarOrientation]==UIInterfaceOrientationPortrait || [[UIApplication sharedApplication]statusBarOrientation]==UIInterfaceOrientationPortraitUpsideDown) {
            carousel.frame=CGRectMake(0, 0, 768, 569);
            //prdPrice.frame=CGRectMake(156, 611, 159, 35);
            //ProductPrice.frame=CGRectMake(323, 609, 289, 40);
            //prdDesc.frame=CGRectMake(156, 681, 159, 35);
            //ProductDesc.frame=CGRectMake(323, 668, 289, 72);
            //addCart.frame=CGRectMake(280, 765, 208, 57);
        }
        else
        {
            //carousel.frame=CGRectMake(0, 0, 1024, 400);
            //prdPrice.frame=CGRectMake(330, 450, 159, 35);
            //ProductPrice.frame=CGRectMake(514, 448, 289, 40);
            //prdDesc.frame=CGRectMake(330, 520, 159, 35);
            //ProductDesc.frame=CGRectMake(514, 507, 289, 72);
            //addCart.frame=CGRectMake(408, 604, 208, 57);
        } 

    }
    else{
        carousel.frame=CGRectMake(0, 0, 320, 255);
    }
}


-(void)viewWillDisappear:(BOOL)animated
{
    if (self.popoverController.isPopoverVisible) {
        [self.popoverController dismissPopoverAnimated:YES];
    }
    
    [super viewWillDisappear:YES];
}


#pragma mark -
#pragma mark iCarousel methods

-(BOOL)carouselShouldWrap:(iCarousel *)carousel
{
    return NO;
}

-(NSUInteger)numberOfVisibleItemsInCarousel:(iCarousel *)carousel
{

    return [imgArray count];
    
}

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return [imgArray count];
}


- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{ 
    UIImageView *img;
    NSString *imgName = [imgArray objectAtIndex:index];
    NSURL *url = [NSURL URLWithString:imgName];
    view = [[[UIImageView alloc] init] autorelease];
    if (app.device ==0 ){
        view.frame=CGRectMake(0, 0, 250, 250);
        img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 250, 250)];
    }
    else{
        view.frame=CGRectMake(0, 0, 350, 350);
        img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 350, 350)];
    }
    [[AsyncImageLoader sharedLoader] cancelLoadingURL:url];
    img.imageURL = url;
    [view addSubview:img];
    return view;
}

- (CGFloat)carouselItemWidth:(iCarousel *)carousel
{
    return 240;
}
#pragma mark -
#pragma mark Tweet 

-(IBAction)tweet:(id)sender{

    if ([TWTweetComposeViewController canSendTweet]) {
        TWTweetComposeViewController *t = [[TWTweetComposeViewController alloc] init];
        [t setInitialText:@" انا الان اقوم بالتسوق بمتجر زهرة الالكتروني للهواتف الذكية"];
        [self presentModalViewController:t animated:YES];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"خطأ" message:@"لا يمكن الوصول لتويتر" delegate:nil cancelButtonTitle:@"موافق" otherButtonTitles:nil];
        [alert show];
    }

    }


#pragma mark -
#pragma mark Button tap event

- (void)buttonTapped:(UIButton *)sender
{
	NSInteger index = [carousel indexOfItemView:sender];
	
    [[[[UIAlertView alloc] initWithTitle:@"Button Tapped"
                                 message:[NSString stringWithFormat:@"You tapped button number %i", index]
                                delegate:nil
                       cancelButtonTitle:@"OK"
                       otherButtonTitles:nil] autorelease] show];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
 //   if (app.device==0) {
 //       return NO;
 //   }
 //   return YES;
    
    return interfaceOrientation == UIInterfaceOrientationPortrait;
}

/*
-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
        if (toInterfaceOrientation==UIInterfaceOrientationPortrait || toInterfaceOrientation==UIInterfaceOrientationPortraitUpsideDown) {
            carousel.frame=CGRectMake(0, 0, 768, 569);
            //prdPrice.frame=CGRectMake(156, 611, 159, 35);
            //ProductPrice.frame=CGRectMake(323, 609, 289, 40);
            //prdDesc.frame=CGRectMake(156, 681, 159, 35);
            //ProductDesc.frame=CGRectMake(323, 668, 289, 72);
            //addCart.frame=CGRectMake(280, 765, 208, 57);
        }
        else
        {
            carousel.frame=CGRectMake(0, 0, 1024, 400);
            //prdPrice.frame=CGRectMake(330, 450, 159, 35);
            //ProductPrice.frame=CGRectMake(514, 448, 289, 40);
            //prdDesc.frame=CGRectMake(330, 520, 159, 35);
            //ProductDesc.frame=CGRectMake(514, 507, 289, 72);
            //addCart.frame=CGRectMake(408, 604, 208, 57);
        } 
 
}
 */
@end
