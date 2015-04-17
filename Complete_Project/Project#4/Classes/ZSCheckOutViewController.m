//
//  CheckOutViewController.m
//  StoreModule
//
//  Created by AgilePc-100 on 3/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import "AsyncImageView.h"
#import "ZSCheckOutViewController.h"
#import "ZScustomcheckout.h"
#import "ZSBuyProductsController.h"
#import "JSON.h"

@implementation ZSCheckOutViewController
@synthesize strCost;

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
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) { // if iOS 7
        self.edgesForExtendedLayout = UIRectEdgeNone; //layout adjustements
    }
    tabView.delegate=self;
    tabView.dataSource=self;
    app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    app.isNetworkAvailable;
    totalCost = 0;
    qtyArr=[[NSMutableArray alloc] init];
    for (int i=0; i<[app.cartArray count]; i++)
    {
        [qtyArr addObject:@"1"];
    }
    [qtyArr retain];
    self.navigationItem.title = @"إنهاء الطلب";
    couponText.delegate=self;
    if (app.device==0) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"شراء" style:UIBarButtonItemStylePlain target:self action:@selector(buyButtonClicked:)];
    }
    arrGiftBtn = [[NSMutableArray alloc] init];
    arrGiftWrapBtn = [[NSMutableArray alloc] init];
    arrProdInfo = [[NSMutableArray alloc] init];
    for (int i=0; i<[app.cartArray count]; i++) {
        [arrGiftBtn addObject:@"0"];
        [arrGiftWrapBtn addObject:@"0"];
    }
    [arrGiftBtn retain];
    [arrGiftWrapBtn retain];
    [self reloadTheTotal];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int returnValue;
    if (app.device==0) {
        returnValue=80;
    }
    else{
        returnValue=110;
    }
    return returnValue;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    NSString *cellIdentifier = @"cellIdentifier";
    ZScustomcheckout *cell=(ZScustomcheckout *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell==nil)
    {
        cell=[[ZScustomcheckout alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.giftBtn.hidden = TRUE;
    cell.giftwrapBtn.hidden = TRUE;
    cell.removeBtn.hidden = FALSE;
    cell.itempriceLbl.hidden = FALSE;
    cell.itemtotalLbl.hidden = FALSE;
    cell.productLbl.hidden = FALSE;
    cell.productImg.hidden = FALSE;
    cell.qtyBtnDown.hidden = FALSE;
    cell.qtyBtnUp.hidden = FALSE;
    cell.textFieldQty.hidden=FALSE;
    cell.qtyLable.hidden=TRUE;
    cell.textFieldQty.delegate=self;
    cell.textFieldQty.text=[qtyArr objectAtIndex:indexPath.row];
    if (app.device==0) {
        [cell.giftBtn setFrame:CGRectMake(143, 40, 50, 24)];
        [cell.giftwrapBtn setFrame:CGRectMake(197, 40, 57, 24)];
        [cell.removeBtn setFrame:CGRectMake(259, 40, 57, 24)];
        [cell.qtyBtnDown setFrame:CGRectMake(109, 53, 28, 24)];
        [cell.qtyBtnUp setFrame:CGRectMake(109, 28, 28, 24)];
        cell.itemtotalLbl.text = [NSString stringWithFormat:@"الإجمالي  : %.2f ريال ",(([[qtyArr objectAtIndex:indexPath.row]floatValue])*([[[app.cartArray objectAtIndex:indexPath.row] objectForKey:@"product_price"] floatValue]))];
        [cell.qtyBtnUp.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:11.0]];
        [cell.qtyBtnDown.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:11.0]];
        [cell.giftBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:11.0]];
        [cell.giftwrapBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:11.0]];
        [cell.removeBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:11.0]];
    }
    else{
        if (rotateI==1) {
            [cell.productImg setFrame:CGRectMake(10, 10, 90, 90)];
            [cell.productLbl setFrame:CGRectMake(130, 10, 170, 22)];
            [cell.itempriceLbl setFrame:CGRectMake(340, 10, 170, 22)];
            [cell.itemtotalLbl setFrame:CGRectMake(575, 10, 170, 22)];
            [cell.qtyLable setFrame:CGRectMake(130, 55, 40, 30)];
            [cell.textFieldQty setFrame:CGRectMake(175, 55, 50,30)];
            
            [cell.giftBtn setFrame:CGRectMake(310, 55, 72, 30)];
            [cell.giftwrapBtn setFrame:CGRectMake(430, 55, 100, 30)];
            [cell.removeBtn setFrame:CGRectMake(610, 55, 100, 30)];
            [cell.qtyBtnDown setFrame:CGRectMake(230, 75, 40, 30)];
            [cell.qtyBtnUp setFrame:CGRectMake(230, 40, 40, 30)];
            [cell.itempriceLbl setTextAlignment:UITextAlignmentLeft];
            [cell.itemtotalLbl setTextAlignment:UITextAlignmentLeft];
        }
        else{
            [cell.productImg setFrame:CGRectMake(10, 10, 90, 90)];
            [cell.productLbl setFrame:CGRectMake(130, 10, 200, 30)];
            [cell.itempriceLbl setFrame:CGRectMake(412, 10, 200, 30)];
            [cell.itemtotalLbl setFrame:CGRectMake(800, 10, 200, 30)];
            [cell.qtyLable setFrame:CGRectMake(130, 55, 40, 30)];
            [cell.textFieldQty setFrame:CGRectMake(175, 55, 50, 30)];
            
            [cell.giftBtn setFrame:CGRectMake(420, 55, 72, 30)];
            [cell.giftwrapBtn setFrame:CGRectMake(532, 55, 100, 30)];
            [cell.removeBtn setFrame:CGRectMake(820, 55, 100, 30)];
            [cell.qtyBtnDown setFrame:CGRectMake(230, 75, 40, 30)];
            [cell.qtyBtnUp setFrame:CGRectMake(230, 40, 40, 30)];
            [cell.itempriceLbl setTextAlignment:UITextAlignmentCenter];
            [cell.itemtotalLbl setTextAlignment:UITextAlignmentCenter];
             
        }
        
        cell.itemtotalLbl.text = [NSString stringWithFormat:@"الإجمالي  : %.2f ريال ",(([[qtyArr objectAtIndex:indexPath.row]floatValue])*([[[app.cartArray objectAtIndex:indexPath.row] objectForKey:@"product_price"] floatValue]))];
    }
    NSString *imgUrl=[[app.cartArray objectAtIndex:indexPath.row] objectForKey:@"featured_image"];
    imgUrl = [imgUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:imgUrl];
    [[AsyncImageLoader sharedLoader] cancelLoadingURL:url];
    cell.productImg.imageURL=url;
    cell.productLbl.text=[[app.cartArray objectAtIndex:indexPath.row] objectForKey:@"product_name"];
    cell.itempriceLbl.text=[NSString stringWithFormat:@"سعر الوحدة : %@ ريال",[[app.cartArray objectAtIndex:indexPath.row] objectForKey:@"product_price"]];
    cell.giftBtn.tag = indexPath.row;
    [cell.giftBtn addTarget:self action:@selector(giftbtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    if ([[arrGiftBtn objectAtIndex:indexPath.row] intValue]==1) {
        cell.giftBtn.highlighted = YES;
        is_gift=1;
    }
    else {
        cell.giftBtn.highlighted = NO;  
        is_gift=0;
    }
    cell.giftwrapBtn.tag = indexPath.row;
    [cell.giftwrapBtn addTarget:self action:@selector(giftwarpbtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    if ([[arrGiftWrapBtn objectAtIndex:indexPath.row] intValue]==1) {
        cell.giftwrapBtn.highlighted = YES;
        has_wrap=1;
    }
    else {
        cell.giftwrapBtn.highlighted = NO;    
        has_wrap=0;
    }
    cell.qtyBtnDown.tag = indexPath.row;
    [cell.qtyBtnDown addTarget:self action:@selector(qtybtnClickedDown:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.qtyBtnUp.tag = indexPath.row;
    [cell.qtyBtnUp addTarget:self action:@selector(qtybtnClickedUp:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.removeBtn.tag = indexPath.row;
    [cell.removeBtn addTarget:self action:@selector(removebtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

-(IBAction)giftbtnClicked:(id)sender
{   
    UIButton *temp = (UIButton *)sender;
    NSLog(@"gift button pressed at index %d",temp.tag);
    
    if ([[arrGiftBtn objectAtIndex:temp.tag] intValue] == 1) {
        [arrGiftBtn replaceObjectAtIndex:temp.tag withObject:@"0"];
    }
    else{
        [arrGiftBtn replaceObjectAtIndex:temp.tag withObject:@"1"];
    }
    
    [tabView reloadData];

}

-(IBAction)giftwarpbtnClicked:(id)sender
{

    UIButton *temp = (UIButton *)sender;
    NSLog(@"giftWrap button pressed at index %d",temp.tag);
        
    if ([[arrGiftWrapBtn objectAtIndex:temp.tag] intValue] == 1) {
        [arrGiftWrapBtn replaceObjectAtIndex:temp.tag withObject:@"0"];
    }
    else{
        [arrGiftWrapBtn replaceObjectAtIndex:temp.tag withObject:@"1"];
    }
    
    [tabView reloadData];
}

-(IBAction)qtybtnClickedDown:(id)sender{
    UIButton *tempBtn=(UIButton *)sender;
    int tqty=[[qtyArr objectAtIndex:tempBtn.tag] intValue];
    if(tqty>1)
    {
        tqty--;
        [qtyArr replaceObjectAtIndex:tempBtn.tag withObject:[NSString stringWithFormat:@"%d",tqty]];
        [qtyArr retain];
    }
    totalCost=0;
    [self reloadTheTotal];
    [tabView reloadData];
}

-(IBAction)qtybtnClickedUp:(id)sender{
    UIButton *tempBtn=(UIButton *)sender;
    int tqty=[[qtyArr objectAtIndex:tempBtn.tag] intValue];
        tqty++;
        [qtyArr replaceObjectAtIndex:tempBtn.tag withObject:[NSString stringWithFormat:@"%d",tqty]];
        [qtyArr retain];
    totalCost=0;
    [self reloadTheTotal];
    [tabView reloadData];
}

-(IBAction)removebtnClicked:(id)sender{
    UIButton *temp = (UIButton *)sender;
    NSLog(@"remove %d",temp.tag);
    [app.cartArray removeObjectAtIndex:temp.tag];
    totalCost = 0;
    totalLable.text = [NSString stringWithFormat:@"%.2f",totalCost];
    [self reloadTheTotal];
    [tabView reloadData];
}

-(BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
    if (app.device==1) {
        if (textField == couponText) {
            if (rotateI ==1) {
                [UIView beginAnimations:nil context:NULL];
                [UIView setAnimationDelegate:self];
                [UIView setAnimationDuration:0.25];
                self.view.transform = CGAffineTransformMakeTranslation(0, -250);
                [UIView commitAnimations];
            }
            else if(rotateI ==2){
                [UIView beginAnimations:nil context:NULL];
                [UIView setAnimationDelegate:self];
                [UIView setAnimationDuration:0.25];
                self.view.transform = CGAffineTransformMakeTranslation(0, -350);
                [UIView commitAnimations];
            }
        }
        else{
            return NO;
        }
    }
   else{
        if (textField == couponText) {
                [UIView beginAnimations:nil context:NULL];
                [UIView setAnimationDelegate:self];
                [UIView setAnimationDuration:0.25];
                self.view.transform = CGAffineTransformMakeTranslation(0, -215);
                [UIView commitAnimations];
        }
        else{
            return NO;
        }
    }
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if (textField == couponText) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.25];
        self.view.transform = CGAffineTransformMakeTranslation(0, 0);
        [UIView commitAnimations];
    }
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.editing) {
        return UITableViewCellEditingStyleDelete;
    }
    return UITableViewCellEditingStyleNone;
}

-(IBAction)buyButtonClicked:(id)sender{
    [couponText resignFirstResponder];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.25];
    self.view.transform = CGAffineTransformMakeTranslation(0, 0);
    [UIView commitAnimations];
    
    if ([app.cartArray count]>0) {
        if ([couponText.text length]>0) {
            NSString *coupenStr = couponText.text;
            NSString *strurl = [NSString stringWithFormat:@"http://www.galamr.com/services/index.php/welcome/verify_coupon?&cc=%@",coupenStr];
            strurl = [strurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//            app.cartArray = [[NSMutableArray alloc]init];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString:strurl]];
            [request setHTTPMethod: @"GET"];
            
            NSData *returnData = [ NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil ];
            NSString *returnString = [[NSString alloc] initWithData:returnData encoding: NSUTF8StringEncoding];
            NSDictionary *dictCopen=[returnString JSONValue];
            [dictCopen retain];
            NSString *strValue=[dictCopen objectForKey:@"value"];
            NSString *strPrecentage=[dictCopen objectForKey:@"is_precentage"];
            NSString *strExpired=[dictCopen objectForKey:@"expired"];
            
            if ([strExpired isEqualToString:@"1"]) {
                UIAlertView *alertExpired= [[UIAlertView alloc] initWithTitle:@"متجر زهرة" message:@"لا يمكن تطبيق التخفيض على هذه العملية" delegate:self cancelButtonTitle:nil otherButtonTitles:@"موافق", nil];
                [alertExpired show];
                [alertExpired release];
            }
            else if([strExpired isEqualToString:@"0"])
            {
                float discountValue = [strValue integerValue];
                if ([strPrecentage isEqualToString:@"0"])
                {
                        strCost=totalLable.text;
                        float valueCost = [strCost floatValue];
                        float perValue = discountValue/100;
                        float afterDiscount = valueCost * perValue;
                        totalCost = valueCost-afterDiscount;
                        totalLable.text = [NSString stringWithFormat:@"%.2f",totalCost];
                        app.costInfo=totalLable.text;
                        NSString *msg=[NSString stringWithFormat:@"ريال  %.2f %% الخصم الخاص بك ",discountValue];
                        UIAlertView *alertDis= [[UIAlertView alloc] initWithTitle:@"متجر زهرة" message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:@"موافق", nil];
                        [alertDis show];
                        alertDis.tag=2;
                        [alertDis release];
                }
                else if([strPrecentage isEqualToString:@"1"])
                {
                        strCost=totalLable.text;
                        float valueCost = [strCost floatValue];
                        totalCost = valueCost - discountValue;
                        totalLable.text = [NSString stringWithFormat:@"%.2f",totalCost];
                        app.costInfo=totalLable.text;
                        NSString *msg=[NSString stringWithFormat:@"ريال  %.2f الخصم الخاص بك",discountValue];
                        UIAlertView *alertDis1= [[UIAlertView alloc] initWithTitle:@"متجر زهرة" message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:@"موافق", nil];
                        [alertDis1 show];
                        alertDis1.tag=3;
                        [alertDis1 release];
                }
            }   
            else{
                UIAlertView *alertExpired= [[UIAlertView alloc] initWithTitle:@"متجر زهرة" message:@"لا يمكن تطبيق الخصم على هذه العملية." delegate:self cancelButtonTitle:nil otherButtonTitles:@"موافق", nil];
                [alertExpired show];
                [alertExpired release];
            }
        }
        else
        {
            strCost=totalLable.text;
            app.costInfo=totalLable.text;
            ZSBuyProductsController *buyproductView=[[ZSBuyProductsController alloc] initWithNibName:@"ZSBuyProductsController" bundle:nil];
            [self.navigationController pushViewController:buyproductView animated:YES];
            [buyproductView release];
        }
       
        for(int i=0;i<[app.cartArray count];i++){
            dictProduct = [[NSMutableDictionary alloc] init];
            [dictProduct setObject:[qtyArr objectAtIndex:i] forKey:@"quantity"];
            [dictProduct setObject:[[app.cartArray objectAtIndex:i] objectForKey:@"product_price"] forKey:@"price"];
            [dictProduct setObject:[[app.cartArray objectAtIndex:i] objectForKey:@"product_id"] forKey:@"product_id"];
            [dictProduct setObject:[arrGiftBtn objectAtIndex:i] forKey:@"is_gift"];
            [dictProduct setObject:[arrGiftWrapBtn objectAtIndex:i] forKey:@"has_wrap"];            
            [arrProdInfo addObject:dictProduct];
            [arrProdInfo retain];

        }
           }
    else
    {
        UIAlertView *alertMsg= [[UIAlertView alloc] initWithTitle:@"متجر زهرة" message:@"العربة فارغة ، قم بإضافة منتجات " delegate:self cancelButtonTitle:nil otherButtonTitles:@"موافق", nil];
        [alertMsg show];
        [alertMsg release];
    }
 
    // NSLog(@"%@",[arrProdInfo description]);
    app.productsArray = [arrProdInfo copy];
    [app.productsArray retain];
    // NSLog(@"Arrray %@",[app.productsArray description]);
    [arrProdInfo removeAllObjects];
    
}
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 2 || alertView.tag == 3)
    {
        if(buttonIndex == 0)
        {
            ZSBuyProductsController *buyproductView=[[ZSBuyProductsController alloc] initWithNibName:@"ZSBuyProductsController" bundle:nil];
            [self.navigationController pushViewController:buyproductView animated:YES];
            [buyproductView release];
        }
    }
    
    
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.25];
    self.view.transform = CGAffineTransformMakeTranslation(0, 0);
    
    [UIView commitAnimations];
    if (app.device==0) {
        return NO;
    }
    return YES;
}
-(void)viewWillAppear:(BOOL)animated{
    if (app.device ==1 ) {
        if ([[UIApplication sharedApplication]statusBarOrientation]==UIInterfaceOrientationPortrait || [[UIApplication sharedApplication]statusBarOrientation]==UIInterfaceOrientationPortraitUpsideDown)
        {
            tabView.frame = CGRectMake(0, 0, 768, 892);
            tot.frame =CGRectMake(19, 908, 85, 36);
            totalLable.frame =CGRectMake(99, 908, 71, 36);
            butBuy.frame = CGRectMake(575, 900, 152, 47);
            //couponLable.frame=CGRectMake(246, 913, 102, 24);
            //couponText.frame=CGRectMake(356, 909, 166, 31);
            dollar.frame = CGRectMake(172, 908, 17, 36);
            rotateI =1;
        }
        else
        {
            tabView.frame = CGRectMake(0, 0, 1024, 636);
            tot.frame =CGRectMake(19, 652, 85, 36);
            totalLable.frame =CGRectMake(99, 652, 71, 36);
            butBuy.frame = CGRectMake(831, 644, 152, 47);
            //couponLable.frame=CGRectMake(350, 657, 102, 24);
            //couponText.frame=CGRectMake(462, 653, 166, 31);
            dollar.frame = CGRectMake(172, 652, 17, 36);
            rotateI=2;
        } 
        [tabView reloadData];
    }
}

-(void)reloadTheTotal
{
    for (int i=0; i<[app.cartArray count]; i++) 
    {
        float valueCost = (([[qtyArr objectAtIndex:i]floatValue])*([[[app.cartArray objectAtIndex:i] objectForKey:@"product_price"] floatValue]));
        totalCost = totalCost + valueCost;
        totalLable.text = [NSString stringWithFormat:@"%.2f",totalCost];  
    }
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [couponText resignFirstResponder];
}
-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (app.device==1) {
        if (toInterfaceOrientation==UIInterfaceOrientationPortrait || toInterfaceOrientation==UIInterfaceOrientationPortraitUpsideDown) {
            tabView.frame = CGRectMake(0, 0, 768, 892);
            tot.frame =CGRectMake(19, 908, 85, 36);
            totalLable.frame =CGRectMake(99, 908, 71, 36);
            butBuy.frame = CGRectMake(575, 900, 152, 47);
            couponLable.frame=CGRectMake(246, 913, 102, 24);
            couponText.frame=CGRectMake(356, 909, 166, 31);
            dollar.frame = CGRectMake(172, 908, 17, 36);
            rotateI =1;
        }
        else
        {
            tabView.frame = CGRectMake(0, 0, 1024, 636);
            tot.frame =CGRectMake(19, 652, 85, 36);
            totalLable.frame =CGRectMake(99, 652, 71, 36);
            butBuy.frame = CGRectMake(831, 644, 152, 47);
            couponLable.frame=CGRectMake(350, 657, 102, 24);
            couponText.frame=CGRectMake(462, 653, 166, 31);
            dollar.frame = CGRectMake(172, 652, 17, 36);
            rotateI=2;
        }
        [tabView reloadData];
    }
}
@end
