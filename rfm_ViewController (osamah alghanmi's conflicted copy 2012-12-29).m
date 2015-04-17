//
//  rfm_ViewController.m
//  Complete_Project
//
//  Created by adel alahmed on 11/9/12.
//  Copyright (c) 2012 nitin.gupta@ongraph.com. All rights reserved.
//

#import "rfm_ViewController.h"

@interface rfm_ViewController ()

@end


@implementation rfm_ViewController
@synthesize fn,sn,tn,ln,account,issue_city,date_of_issue,dob,mobile,email,type;

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
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}
- (IBAction)send_request:(id)sender{
        
    NSString *type_index = [NSString stringWithFormat:@"%i",[type selectedSegmentIndex]];
    NSString *urlstr = [NSString stringWithFormat:@"http://www.galamr.com/services/index.php/welcome/place_new_membership?fn=%@&sn=%@&tn=%@&ln=%@&mobile=%@&email=%@&account=%@&type=%@&dob=%@&national_id_city=%@&national_id_date=%@&",[fn text],[sn text],[tn text],[ln text],[mobile text],[email text],[account text],type_index,[dob text],[issue_city text],[date_of_issue text] ];
    urlstr = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlstr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",responseString);
}

@end
