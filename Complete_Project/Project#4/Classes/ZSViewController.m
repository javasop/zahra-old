
//  ViewController.m
//  StoreModule
//
//  Created by AgilePc-100 on 3/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ZSViewController.h"
#import "ZSCoverFlowViewController.h"
#import "AsyncImageView.h"

@implementation ZSViewController
@synthesize  isLoading;


- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    

    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) { // if iOS 7
        self.edgesForExtendedLayout = UIRectEdgeNone; //layout adjustements
    }
    
    app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    app.isNetworkAvailable;
    NSString *strurl = [NSString stringWithFormat:@"http://www.galamr.com/services/index.php/welcome/products_list_json"];
    app.cartArray = [[NSMutableArray alloc]init];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString:strurl]];
    [request setHTTPMethod: @"GET"];
    NSData *returnData = [NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil ];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding: NSUTF8StringEncoding];
    arrProjects = [returnString JSONValue];
    [arrProjects retain];
    mode = @"potrait";
    app.mainArray = [arrProjects copy];
    [app.mainArray retain];
    [self loadtheContents];
}
-(void)loadtheContents
{
    CGFloat x,y,w,h;
    if (app.device == 0) {
        x = 20;
        y = 20;
        w = 80;
        h = 90;
    }
    else{
        x = 49;
        y = 32;
        w = 170;
        h = 180;
    }
    for (UIView *view in [scroll subviews]) {
        [view removeFromSuperview];
    }
    for (int i=0; i<[arrProjects count]; i++) {
        NSString *imgUrl=[[arrProjects objectAtIndex:i] objectForKey:@"featured_image"];
        imgUrl = [imgUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:imgUrl];
        UIImageView *imageview = [UIImageView new];
        [imageview setFrame:CGRectMake(x,y,w,h)];
        [[AsyncImageLoader sharedLoader] cancelLoadingURL:url];
        imageview.imageURL = url;
        imgButton = [UIButton new];
        imgButton=[UIButton buttonWithType:(UIButtonTypeCustom)];
        [imgButton setFrame:CGRectMake(x,y,w,h)];
        [imgButton addTarget:self action:@selector(coverFlowView:) forControlEvents:UIControlEventTouchDown];
        [imgButton setTag:i];        
        
        UILabel *lblName = [UILabel new];
        lblName.text = [[arrProjects objectAtIndex:i] objectForKey:@"product_name"];
        if (app.device==0) {
            lblName.frame = CGRectMake(x, y+92, w, 20);
            lblName.font = [UIFont systemFontOfSize:12];
        }
        else{
            lblName.frame = CGRectMake(x, y+185, w, 20);
            lblName.font = [UIFont systemFontOfSize:20];
        }
        lblName.textColor = [UIColor whiteColor];
        lblName.backgroundColor = [UIColor clearColor];
        lblName.textAlignment = UITextAlignmentCenter;
        
        [scroll addSubview:lblName];
        [scroll addSubview:imageview];
        [scroll addSubview:imgButton];
        [imgUrl retain];
        if (app.device==0)
        {
            x = x+w+20;
            if (i>0) 
            {
                if (x>260) 
                {
                    y=y+h+20;
                    x = 20;
                }
                if (y>460) {
                    [scroll setContentSize:CGSizeMake(320, y+200)];
                }
            }
        }
        else
        {
            x = x+w+80;
        
                if (i>0) {
                    if ([mode isEqualToString:@"landscape"]) {
                        if (x>920) {
                            y=y+h+80;
                            x = 49;
                        }
                
                    }
                    else if ([mode isEqualToString:@"potrait"])
                    {
                        if (x>620) {
                            y=y+h+80;
                            x = 49;
                        }
                    
                    }
                        if (y>1000) {
                            [scroll setContentSize:CGSizeMake(768, y+200)];
                        }   
                }
        }
    }
     
}
-(IBAction)coverFlowView:(id)sender{
    UIButton *temp=(UIButton *)sender;
    app.buttonSelected = temp.tag;
    ZSCoverFlowViewController *coverView=[[ZSCoverFlowViewController alloc] initWithNibName:@"ZSCoverFlowViewController" bundle:nil];
    [self.navigationController pushViewController:coverView animated:YES];
    [coverView release];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (app.device != 0) {
        if ([[UIApplication sharedApplication] statusBarOrientation]==UIInterfaceOrientationPortrait || [[UIApplication sharedApplication] statusBarOrientation]==UIInterfaceOrientationPortraitUpsideDown) {
            mode=@"potrait";
            scroll.frame = CGRectMake(0, 0, 768, 1024);
        }
        else
        {
            mode=@"landscape";
            scroll.frame = CGRectMake(0, 0, 1024, 768);
        }
    }
    [self loadtheContents];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [isLoading setHidden:YES];

}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (app.device==0) {
        return NO;
    }
    return YES;
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (toInterfaceOrientation==UIInterfaceOrientationPortrait || toInterfaceOrientation==UIInterfaceOrientationPortraitUpsideDown) {
            mode=@"potrait";
            scroll.frame = CGRectMake(0, 0, 768, 1024);
    }
    else
    {
        mode=@"landscape";
        scroll.frame = CGRectMake(0, 0, 1024, 768);
    }
    [self loadtheContents];
    
}
@end
