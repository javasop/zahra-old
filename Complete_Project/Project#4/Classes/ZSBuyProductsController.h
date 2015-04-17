//
//  BuyProductsController.h
//  StoreModule
//
//  Created by AgilePc-100 on 4/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZSshippingInformation.h"
#import "AppDelegate.h"
#import "TPKeyboardAvoidingScrollView.h"

@class AppDelegate;
@class shippingInformation;

@interface ZSBuyProductsController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate>
{
    IBOutlet UITextField *fName,*lName,*eMail,*phnNumber, *address, *city, *region, *district;
    IBOutlet UILabel *firstName,*lastName,*emaillable,*phone;
    NSMutableArray *arrInfo;
    NSString *phonenumber;
    AppDelegate *app;
}
-(IBAction)completeOrder:(id)sender;
-(IBAction)submitButton:(id)sender;
-(BOOL)NSStringIsValidEmail:(NSString *)checkString;

@end
