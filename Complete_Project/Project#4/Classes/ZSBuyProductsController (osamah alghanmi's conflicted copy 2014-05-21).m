//
//  BuyProductsController.m
//  StoreModule
//
//  Created by AgilePc-100 on 4/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import "ZSBuyProductsController.h"
#import "ZSCheckOutViewController.h"
#import "SBJson.h"

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

-(IBAction)submitButton:(id)sender{

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
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"إرسال" style:UIBarButtonItemStylePlain target:self action:@selector(completeOrder:)];
    
    arrInfo=[[NSMutableArray alloc] init];
    fName.delegate=self;
    lName.delegate=self;
    eMail.delegate=self;
    phnNumber.delegate=self;
    address.delegate = self;
    region.delegate = self;
    city.delegate = self;
    district.delegate = self;
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [lName resignFirstResponder];
    [fName resignFirstResponder];
    [phnNumber resignFirstResponder];
    [eMail resignFirstResponder];
    [address resignFirstResponder];
    [region resignFirstResponder];
    [city resignFirstResponder];
    [district resignFirstResponder];
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (app.device==0) {
        if (textField == eMail || textField ==phnNumber || textField ==lName || textField == address || textField == region || textField == city || textField == district) {
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDuration:0.25];
            self.view.transform = CGAffineTransformMakeTranslation(0, -100);
            [UIView commitAnimations];
        }
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return (newLength > 14) ? NO : YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if (app.device == 0) {
        if (textField == eMail || textField ==phnNumber || textField == fName || textField ==lName || textField == address || textField == region || textField == city || textField == district) {
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDuration:0.25];
            self.view.transform = CGAffineTransformMakeTranslation(0, 0);
            [UIView commitAnimations];
        }
    }
    return YES;
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
           // firstName.frame=CGRectMake(172, 275, 122, 39);
           // lastName.frame=CGRectMake(172, 370, 122, 39);
           // emaillable.frame=CGRectMake(172, 465, 122, 39);
           // phone.frame=CGRectMake(172, 560, 187, 46);
           // fName.frame=CGRectMake(381, 279, 216, 31);
           // lName.frame=CGRectMake(381, 374, 216, 31);
           // eMail.frame=CGRectMake(381, 469, 216, 31);
           // phnNumber.frame=CGRectMake(381, 567, 216, 31);
        }
        else
        {
           // firstName.frame=CGRectMake(300, 203, 122, 39);
           // lastName.frame=CGRectMake(300, 298, 122, 39);
           // emaillable.frame=CGRectMake(300, 393, 122, 39);
           // phone.frame=CGRectMake(300, 488, 187, 46);
           // fName.frame=CGRectMake(509, 207, 216, 31);
           // lName.frame=CGRectMake(509, 302, 216, 31);
           // eMail.frame=CGRectMake(509, 397, 216, 31);
           // phnNumber.frame=CGRectMake(509, 492, 216, 31);
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

/*
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
*/    

-(BOOL)validate{
    NSString *zs_name = @"متجر زهرة";
    NSString *ok = @"موافق";
    NSString *firstname = fName.text;
    NSString *lastname  = lName.text;
    NSString *emailinfo = eMail.text;
    NSString *address_string = address.text;
    NSString *phonenumber_string = phnNumber.text;
    NSString *region_string = region.text;
    NSString *city_string = city.text;
    NSString *district_string = district.text;
    
    if ([firstname length] <= 0) {
        
        UIAlertView *alertFname = [[UIAlertView alloc]initWithTitle:zs_name message:@"الاسم الأول مطلوب" delegate:self cancelButtonTitle:nil otherButtonTitles:ok, nil];
        
        [alertFname show];
        [alertFname release];
        return NO; 
    }
    else if ([lastname length] <= 0) 
    {
        UIAlertView *alertLname = [[UIAlertView alloc]initWithTitle:zs_name message:@"الاسم الأخير مطلوب" delegate:self cancelButtonTitle:nil otherButtonTitles:ok, nil];
        [alertLname show];
        [alertLname release];
         return NO; 
    }
    else if ([self NSStringIsValidEmail:emailinfo] != TRUE ) 
    {
        UIAlertView *alertEmail = [[UIAlertView alloc]initWithTitle:zs_name message:@"تأكد من إدخال البريد الالكتروني بصورة صحيحة" delegate:self cancelButtonTitle:nil otherButtonTitles:ok, nil];
        [alertEmail show];
        [alertEmail release];
         return NO; 
    }
    else if([phonenumber_string length] <= 0)
    {
        UIAlertView *alertPhn = [[UIAlertView alloc]initWithTitle:zs_name message:@"رقم الهاتف مطلوب" delegate:self cancelButtonTitle:nil otherButtonTitles:ok, nil];
        [alertPhn show];
        [alertPhn release];
         return NO; 
        
    }
    else if([address_string length]<=0)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:zs_name message:@"العنوان مطلوب" delegate:self cancelButtonTitle:nil otherButtonTitles:ok,nil];
        [alert show];
        [alert release];
         return NO; 
    }
    else if([region_string length]<=0)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:zs_name message:@"احقل المنطقة مطلوب" delegate:self cancelButtonTitle:nil otherButtonTitles:ok,nil];
        [alert show];
        [alert release];
         return NO; 
    }
    else if ([city_string length]<=0) {
        [self messageWithTiltle:@"حقل المدينة مطلوب" andBody:@""];
         return NO; 
    }
    else if ([district_string length] <= 0) {
        [self messageWithTiltle:@"حقل الحي مطلوب" andBody:@""];
         return NO; 
    }

        
        // remove these lines. 
        // replace them with function of send. 
        
        app.fnameInfo=firstname;
        app.lnameInfo=lastname;
        app.emailInfo=emailinfo;
        app.phnInfo=phonenumber_string;
        app.addressInfo = address_string;
        app.region_string = region_string;
        app.district_string = district_string;
        app.city_string = city_string;
 
    return YES;
}



-(IBAction)completeOrder:(id)sender{
    BOOL f = [self validate]; 
    
    if (!f) {
        return;
    }
    
    app.orderArray=[[NSMutableArray alloc] init];
    NSString *pay=@"XYZ";
    NSMutableDictionary *dictOrder=[[NSMutableDictionary alloc] init];
    [dictOrder setObject:app.fnameInfo forKey:@"first_name"];
    [dictOrder setObject:app.lnameInfo forKey:@"last_name"];
    [dictOrder setObject:app.emailInfo forKey:@"email"];
    [dictOrder setObject:app.costInfo forKey:@"total"];
    [dictOrder setObject:pay forKey:@"payment_method"];
    [dictOrder setObject:app.addressInfo forKey:@"address"];
    [dictOrder setObject:app.region_string forKey:@"region"];
    [dictOrder setObject:app.city_string forKey:@"city"];
    [dictOrder setObject:app.phnInfo forKey:@"phone"];
    [dictOrder setObject:app.district_string forKey:@"district"];
    
    [app.orderArray addObject:dictOrder];
    NSLog(@"%@",[app.orderArray description]);
    [app.orderArray retain];
    
    SBJsonWriter *writer = [SBJsonWriter new];
    NSString *str = [writer stringWithObject:app.orderArray];
    [str  retain];
    NSLog(@"Order Array : %@",str);
    
    SBJsonWriter *writer2 = [SBJsonWriter new];
    NSString *str2 = [writer2 stringWithObject:app.productsArray];
    [str2 retain];
    NSLog(@"Products Arrat : %@",str2);
    
    NSString *urlstr = [NSString stringWithFormat:@"http://www.galamr.com/services/index.php/welcome/place_new_order?order=%@&product=%@",str,str2];
    urlstr = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [urlstr retain];
    NSURL *url = [NSURL URLWithString:urlstr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",responseString);
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"متجر زهرة" message:@"تم إرسال الطلب" delegate:nil cancelButtonTitle:@"موافق" otherButtonTitles:nil];
    [alert show];
    [self.navigationController popToRootViewControllerAnimated:YES];
     
    }

-(void) messageWithTiltle:(NSString *)title andBody:(NSString *)body{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:body delegate:nil cancelButtonTitle:@"موافق" otherButtonTitles:nil];
    [alert show];
    [alert release];
}

@end
