//
//  CartPopOverViewController.h
//  StoreModule
//
//  Created by AgilePc-100 on 3/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "CoverFlowViewController.h"

@class AppDelegate;
@class CoverFlowViewController;

@interface CartPopOverViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIPopoverControllerDelegate>
{
    CoverFlowViewController *cartObj;
    AppDelegate *app;
    IBOutlet UITableView *table;
    IBOutlet UIToolbar *toolbar;
    IBOutlet UIBarButtonItem *editbutton;
    IBOutlet UIBarButtonItem *checkOutbutton;
    IBOutlet UIButton *checkOutButton2;
    IBOutlet UILabel *lableTotal;
    float totalCost;
}
@property(nonatomic, retain) CoverFlowViewController *cartObj;
-(IBAction)editClicked:(id)sender;
-(IBAction)checkoutClicked:(id)sender;
-(IBAction)backButtonClicked:(id)sender;
@end
