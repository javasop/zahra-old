//
//  rfm_choose_type.m
//  Complete_Project
//
//  Created by adel alahmed on 12/10/12.
//  Copyright (c) 2012 nitin.gupta@ongraph.com. All rights reserved.
//

#import "rfm_choose_type.h"

@interface rfm_choose_type (){
    NSMutableArray *aa;
    int i;
}

@end

@implementation rfm_choose_type
@synthesize picker, dic;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    i = -1;

    
    // add a bar button item. 
    
    UIBarButtonItem *send_btn = [[UIBarButtonItem alloc] initWithTitle:@"ارسل" style:UIBarButtonItemStylePlain target:self action:@selector(send_request:)];
    self.navigationItem.rightBarButtonItem = send_btn;
    
    // populate the aa array with values of 
    // dic
    
    aa = [[NSMutableArray alloc] init];
    
    [aa addObject:[NSString stringWithString:@"داعم ماسي ١٠٠,٠٠٠ ريال"]];
    [aa addObject:[NSString stringWithString:@"داعم ذهبي ٧٥,٠٠٠ ريال"]];
    [aa addObject:[NSString stringWithString:@"داعم فضي ٥٠,٠٠٠ ريال"]];
    [aa addObject:[NSString stringWithString:@"داعم برونزي ٢٥,٠٠٠ ريال"]];
    [aa addObject:[NSString stringWithString:@"عضو عامل ١٠٠٠ ريال"]];
    [aa addObject:[NSString stringWithString:@"عضو منتسب ٥٠٠ ريال"]];
    [aa addObject:[NSString stringWithString:@"عضو مشارك ٢٥٠ ريال"]];
}

- (IBAction)send_request:(id)sender{
    NSString *type_index;
    
    // check if the device was an iPhone take the value from the picker view. 
    
    if (i == -1) {
        // User did not choose anything ! 
    }
    
    type_index = [NSString stringWithFormat:@"%i",i];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
    }else{
        // else, take it from segmented. 
    }
    
    // here you just use value from the passed dictionary. 
    
    
    NSString *urlstr = [NSString stringWithFormat:@"http://www.galamr.com/services/index.php/welcome/register_a_member?fn=%@&sn=%@&tn=%@&ln=%@&mobile=%@&email=%@&account=%@&type=%@&dob=%@&national_id_city=%@&national_id_date=%@&",[dic objectForKey:@"first_name"],[dic objectForKey:@"second_name"],[dic objectForKey:@"third_name"],[dic objectForKey:@"last_name"],[dic objectForKey:@"mobile"],[dic objectForKey:@"email"],[dic objectForKey:@"account"],type_index,[dic objectForKey:@"date_of_birth"],[dic objectForKey:@"issue_city"],[dic objectForKey:@"date_of_issue"]];
    urlstr = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlstr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",responseString);
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"تم إرسال الطلب" message:@"سيتم التواصل معك من قبل الجمعية" delegate:nil cancelButtonTitle:@"موافق" otherButtonTitles:nil];
    [alert show];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
     
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [aa count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSString *str = [NSString stringWithString:[aa objectAtIndex:row]];
    return str;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    i = row;
    NSLog(@"the chosen is %@",  aa[i]);
    NSString *type = @"";
    switch (i) {
        case 0:
            type = @"داعم ماسي";
            break;
        case 1:
            type = @"داعم ذهبي";
            break;
        case 2:
            type=@"داعم فضي";
            break;
        case 3:
            type=@"داعم برونزي";
            break;
        case 4:
            type=@"العامل";
            break;
        case 5:
            type=@"المنتسب";
            break;
        case 6:
            type=@"المشارك";
            break;
        default:
            break;
    }
    [dic setObject:type forKey:@"type"];
    
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




@end
