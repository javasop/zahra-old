//
//  CartPopOverViewController.m
//  StoreModule
//
//  Created by AgilePc-100 on 3/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ZSCartPopOverViewController.h"
#import "ZSCheckOutViewController.h"

@implementation ZSCartPopOverViewController
@synthesize cartObj;

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
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) { // if iOS 7
        self.edgesForExtendedLayout = UIRectEdgeNone; //layout adjustements
    }
    app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    app.isNetworkAvailable;
    if (app.device ==0) 
    {
//        self.contentSizeForViewInPopover = CGSizeMake(320, 480);
//        toolbar.frame = CGRectMake(0, 0, 320,44);
    }
    else
    {
//         self.contentSizeForViewInPopover = CGSizeMake(400, 460);
//         toolbar.frame = CGRectMake(0, 0, 320,70);
    }
    table.delegate = self;
    table.dataSource = self;
    cartObj = [[ZSCoverFlowViewController alloc] initWithNibName:@"ZSCoverFlowViewController" bundle:nil];
    editbutton.title=@"تعديل";
    totalCost =0;
    lableTotal.text=[NSString stringWithFormat:@" ريال   %.2f",totalCost];
    [super viewDidLoad];
	
}
-(IBAction)editClicked:(id)sender
{
   editbutton = (UIBarButtonItem *)sender;
    if(editbutton.title == @"تعديل"){
        if ([app.cartArray count]>0) {
            [table setEditing:YES animated:YES];
            checkOutbutton.enabled=NO;
            checkOutButton2.hidden=YES;
            editbutton.title=@"تم";
        }
		else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"متجر زهرة" message:@"لا يوجد بيانات لتعديلها" delegate:self cancelButtonTitle:nil otherButtonTitles:@"موافق", nil];
            [alert show];
            [alert release];
        }
	}    
    else
    {
        [table setEditing:NO animated:YES];
        editbutton.title=@"تعديل";
        checkOutbutton.enabled=YES;
        checkOutButton2.hidden=NO;
    }
}
-(IBAction)backButtonClicked:(id)sender{
    [self dismissModalViewControllerAnimated:YES];
}
-(IBAction)checkoutClicked:(id)sender
{
    if (app.device == 0) {
        [self dismissModalViewControllerAnimated:YES];
        [[NSNotificationCenter defaultCenter] 
         postNotificationName:@"checkoutDone" object:self];
    }
    else{
        [[NSNotificationCenter defaultCenter] 
         postNotificationName:@"checkoutDone" object:self];
    }
}
#pragma mark - tableview methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [app.cartArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text=[[app.cartArray objectAtIndex:indexPath.row] objectForKey:@"product_name"];
    cell.detailTextLabel.text=[[app.cartArray objectAtIndex:indexPath.row] objectForKey:@"product_price"];
    return cell;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle==UITableViewCellEditingStyleDelete) 
    {
        [app.cartArray removeObjectAtIndex:indexPath.row];
        totalCost=0;
        lableTotal.text=[NSString stringWithFormat:@" ريال  %.2f",totalCost];
        [self viewWillAppear:YES];
        [tableView reloadData];
    }
}
-(void)viewWillAppear:(BOOL)animated{
    for (int i=0; i<[app.cartArray count]; i++) 
    {
        NSString *strValue = [[app.cartArray objectAtIndex:i] objectForKey:@"product_price"];
        float valueCost = [strValue floatValue];
        totalCost = totalCost + valueCost;
        lableTotal.text = [NSString stringWithFormat:@" ريال  %.2f",totalCost];
    }
}
- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
