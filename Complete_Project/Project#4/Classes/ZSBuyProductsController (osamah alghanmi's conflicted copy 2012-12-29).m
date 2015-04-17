//
//  BuyProductsController.m
//  StoreModule
//
//  Created by AgilePc-100 on 4/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ZSBuyProductsController.h"
#import "ZSCheckOutViewController.h"

@implementation ZSBuyProductsController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Submit" style:UIBarButtonItemStylePlain target:self action:@selector(submitButton:)];
    
    arrInfo=[[NSMutableArray alloc] init];
    fName.delegate=self;
    lName.delegate=self;
    eMail.delegate=self;
    phnNumber.delegate=self;
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [lName resignFirstResponder];
    [fName resignFirstResponder];
    [phnNumber resignFirstResponder];
    [eMail resignFirstResponder];
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (app.device==0) {
        if (textField == eMail || textField ==phnNumber || textField ==lName) {
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDuration:0.25];
            self.view.transform = CGAffineTransformMakeTranslation(0, -100);
            [UIView commitAnimations];
        }
    }
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if (app.device == 0) {
        if (textField == eMail || textField ==phnNumber || textField == fName || textField ==lName) {
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDuration:0.25];
            self.view.transform = CGAffineTransformMakeTranslation(0, 0);
            [UIView commitAnimations];
        }
    }
    return YES;
}
-(IBAction)submitButton:(id)sender{
    NSString *firstname=fName.text;
    NSString *lastname=lName.text;
    NSString *emailinfo=eMail.text;
    phonenumber=phnNumber.text;
    if ([firstname length] <= 0) 
    {
        UIAlertView *alertFname = [[UIAlertView alloc]initWithTitle:@"Store Module" message:@"Firt name is required." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        
        [alertFname show];
        [alertFname release];
    }
    else if ([lastname length] <= 0) 
    {
        UIAlertView *alertLname = [[UIAlertView alloc]initWithTitle:@"Store Module" message:@"Last name is required." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertLname show];
        [alertLname release];
    }
    else if ([self NSStringIsValidEmail:emailinfo] != TRUE ) 
    {
        UIAlertView *alertEmail = [[UIAlertView alloc]initWithTitle:@"Store Module" message:@"Please enter vaild Email address." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertEmail show];
        [alertEmail release];
    }
    else if([phonenumber length] <= 0)
    {
        UIAlertView *alertPhn = [[UIAlertView alloc]initWithTitle:@"Store Module" message:@"Please enter contact number." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertPhn show];
        [alertPhn release];

    }
    else if([phonenumber length]<=0)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Store Module" message:@"Please Enter correct contact no." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
        [alert show];
        [alert release];
    }
   
    else
    { 
        app.fnameInfo=firstname;
        app.lnameInfo=lastname;
        app.emailInfo=emailinfo;
        app.phnInfo=phonenumber;
        ZSshippingInformation *shippingView=[[ZSshippingInformation alloc] initWithNibName:@"ZSshippingInformation" bundle:nil];
        [self.navigationController pushViewController:shippingView animated:YES];
        [shippingView release];
    }
}

-(BOOL)NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = YES; 
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
}

-(void)viewWillAppear:(BOOL)animated{
    if (app.device != 0) {
        if ([[UIApplication sharedApplication] statusBarOrientation]==UIInterfaceOrientationPortrait || [[UIApplication sharedApplication] statusBarOrientation]==UIInterfaceOrientationPortraitUpsideDown) {
            firstName.frame=CGRectMake(172, 275, 122, 39);
            lastName.frame=CGRectMake(172, 370, 122, 39);
            emaillable.frame=CGRectMake(172, 465, 122, 39);
            phone.frame=CGRectMake(172, 560, 187, 46);
            fName.frame=CGRectMake(381, 279, 216, 31);
            lName.frame=CGRectMake(381, 374, 216, 31);
            eMail.frame=CGRectMake(381, 469, 216, 31);
            phnNumber.frame=CGRectMake(381, 567, 216, 31);
        }
        else
        {
            firstName.frame=CGRectMake(300, 203, 122, 39);
            lastName.frame=CGRectMake(300, 298, 122, 39);
            emaillable.frame=CGRectMake(300, 393, 122, 39);
            phone.frame=CGRectMake(300, 488, 187, 46);
            fName.frame=CGRectMake(509, 207, 216, 31);
            lName.frame=CGRectMake(509, 302, 216, 31);
            eMail.frame=CGRectMake(509, 397, 216, 31);
            phnNumber.frame=CGRectMake(509, 492, 216, 31);
        }
    }
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
        firstName.frame=CGRectMake(172, 275, 122, 39);
        lastName.frame=CGRectMake(172, 370, 122, 39);
        emaillable.frame=CGRectMake(172, 465, 122, 39);
        phone.frame=CGRectMake(172, 560, 187, 46);
        fName.frame=CGRectMake(381, 279, 216, 31);
        lName.frame=CGRectMake(381, 374, 216, 31);
        eMail.frame=CGRectMake(381, 469, 216, 31);
        phnNumber.frame=CGRectMake(381, 567, 216, 31);
    }
    else
    {
        firstName.frame=CGRectMake(300, 203, 122, 39);
        lastName.frame=CGRectMake(300, 298, 122, 39);
        emaillable.frame=CGRectMake(300, 393, 122, 39);
        phone.frame=CGRectMake(300, 488, 187, 46);
        fName.frame=CGRectMake(509, 207, 216, 31);
        lName.frame=CGRectMake(509, 302, 216, 31);
        eMail.frame=CGRectMake(509, 397, 216, 31);
        phnNumber.frame=CGRectMake(509, 492, 216, 31);
    }
}
@end
