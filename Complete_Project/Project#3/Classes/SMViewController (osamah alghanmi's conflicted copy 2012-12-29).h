//
//  ViewController.h
//  StoreModule
//
//  Created by AgilePc-100 on 3/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSON.h"
#import "AppDelegate.h"

@class AppDelegate;

@interface SMViewController : UIViewController<UIScrollViewDelegate>
{
    AppDelegate *app;
    UIButton *but1,*imgButton;
    NSMutableArray *arrProjects;
    IBOutlet UIScrollView *scroll;
    NSString *mode,*urlArray;
}

-(IBAction)coverFlowView:(id)sender;
-(void)loadtheContents;


@end
