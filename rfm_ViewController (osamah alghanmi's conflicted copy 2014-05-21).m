//
//  rfm_ViewController.m
//  Complete_Project
//
//  Created by adel alahmed on 11/9/12.
//  Copyright (c) 2012 nitin.gupta@ongraph.com. All rights reserved.
//

#import "rfm_ViewController.h"
#import "rfm_choose_type.h"

@interface rfm_ViewController ()
@end


@implementation rfm_ViewController
@synthesize fn,sn,tn,ln,account,issue_city,date_of_issue,dob,mobile,email,type,sub_type,large_bright,large_dim,small_dim,small_bright,vc;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //self.navigationController.navigationBarHidden = YES;

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    thedelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    
   
    if(thedelegate.isNetworkAvailable){

    
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            
            // add the button for proceed
            UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithTitle:@"متابعة" style:UIBarButtonItemStylePlain target:self action:@selector(send_request:)];
            self.navigationItem.rightBarButtonItem = btn;
            
            
        }else{
            
            sub_type.hidden = YES;
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:15.0];
            [UIView setAnimationRepeatCount:20.0f];
            [UIView setAnimationRepeatAutoreverses:YES];
            CGPoint pos = large_bright.center; 
            pos.x = 400.0f;
            large_bright.center = pos;
            CGPoint pos2 = large_dim.center; 
            pos2.x = -10.0;
            large_dim.center = pos2;
            [UIView commitAnimations];
        }
    }
    else{
        
        return;
        
    }
    
        
    // if iphone do scroll. 
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return NO;
}


- (IBAction)send_request:(id)sender{
    
    NSMutableDictionary *local_dic = [[NSMutableDictionary alloc] initWithCapacity:20];
    [local_dic setObject:[fn text] forKey:@"first_name"];
    [local_dic setObject:[sn text] forKey:@"second_name"];
    [local_dic setObject:[tn text] forKey:@"third_name"];
    [local_dic setObject:[ln text] forKey:@"last_name"];
    [local_dic setObject:[email text] forKey:@"email"];
    [local_dic setObject:[account text] forKey:@"national_id"];
    [local_dic setObject:[issue_city text] forKey:@"issue_city"];
    [local_dic setObject:[date_of_issue text] forKey:@"date_of_issue"];
    [local_dic setObject:[dob text] forKey:@"date_of_birth"];
    [local_dic setObject:[mobile text] forKey:@"mobile"];
    [local_dic setObject:[NSString stringWithFormat:@"%i",[type selectedSegmentIndex]] forKey:@"selected_type"];    
    
    
    // test the values
    
   NSArray *kz = [local_dic allKeys];
    
    
    for (int i = 0; i < [kz count]; i++) {
        NSString *str = [local_dic objectForKey:[kz objectAtIndex:i]];
        if ([str length] <= 0) {
            UIAlertView *alrt = [[UIAlertView alloc] initWithTitle:@"خطأ" message:@"الرجاء التأكد من إدخال جميع الحقول" delegate:nil cancelButtonTitle:@"موافق" otherButtonTitles:nil];
            [alrt show];
            return;
        }
    }
    
    
    
    // if it is iphone, redirect the user to 
    // select the type of membership ..
    // else send the request.
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
    
        vc = [[rfm_choose_type alloc] initWithNibName:@"rfm_choose_type" bundle:nil];
        vc.dic = local_dic;
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        
    
    

        NSString *type_index = [NSString stringWithFormat:@"%i",[type selectedSegmentIndex]];

    NSString *urlstr = [NSString stringWithFormat:@"http://www.galamr.com/services/index.php/welcome/register_a_member?fn=%@&sn=%@&tn=%@&ln=%@&mobile=%@&email=%@&account=%@&type=%@&dob=%@&national_id_city=%@&national_id_date=%@",[local_dic objectForKey:@"first_name"],[local_dic objectForKey:@"second_name"],[local_dic objectForKey:@"third_name"],[local_dic objectForKey:@"last_name"],[local_dic objectForKey:@"mobile"],[local_dic objectForKey:@"email"],[local_dic objectForKey:@"account"],type_index,[local_dic objectForKey:@"date_of_birth"],[local_dic objectForKey:@"issue_city"],[local_dic objectForKey:@"date_of_issue"]];
    urlstr = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlstr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",responseString);
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"تم إرسال الطلب" message:@"سيتم التواصل معك من قبل الجمعية" delegate:nil cancelButtonTitle:@"موافق" otherButtonTitles:nil];
    [alert show];
        
       // NSLog(@"%@", last_index);
        
   [self.navigationController popToRootViewControllerAnimated:YES];
    }  
    
    
    }

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}

@end
