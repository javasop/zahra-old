//
//  BuyProductsController.h
//  StoreModule
//
//  Created by AgilePc-100 on 4/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "shippingInformation.h"
#import "AppDelegate.h"
@class AppDelegate;
@class shippingInformation;
@interface BuyProductsController : UIViewController<UITextFieldDelegate>
{
    IBOutlet UITextField *fName,*lName,*eMail,*phnNumber, *address, *region, *city, *district ;
    IBOutlet UILabel *firstName,*lastName,*emaillable,*phone;
    NSMutableArray *arrInfo;
    NSString *phonenumber;
    AppDelegate *app;
}
-(IBAction)submitButton:(id)sender;
-(BOOL)NSStringIsValidEmail:(NSString *)checkString;
-(IBAction)completeOrder:(id)sender;

@end
