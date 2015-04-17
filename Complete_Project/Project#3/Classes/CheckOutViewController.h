//
//  CheckOutViewController.h
//  StoreModule
//
//  Created by AgilePc-100 on 3/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "customcheckout.h"
#import "AppDelegate.h"

@class AppDelegate;
@interface CheckOutViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIAlertViewDelegate>
{
    AppDelegate *app;
    IBOutlet UITableView *tabView;
    IBOutlet UITableViewCell *customCell;
    IBOutlet UILabel *totalLable,*tot,*couponLable,*dollar;
    IBOutlet UITextField *couponText;
    IBOutlet UIButton *butBuy;
    NSMutableArray *qtyArr;
    NSMutableArray *arrGiftBtn;
    NSMutableArray *arrGiftWrapBtn;
    NSMutableArray *arrProdInfo;
    NSMutableDictionary *dictProduct; 
    NSString *strCost;
    float totalCost;
    int rotateI,is_gift,has_wrap;
}
@property (nonatomic,retain) NSString *strCost;
-(void)reloadTheTotal;
-(IBAction)buyButtonClicked:(id)sender;
-(IBAction)giftbtnClicked:(id)sender;
-(IBAction)giftwarpbtnClicked:(id)sender;
-(IBAction)removebtnClicked:(id)sender;
-(IBAction)qtybtnClickedDown:(id)sender;
-(IBAction)qtybtnClickedUp:(id)sender;

   
@end
