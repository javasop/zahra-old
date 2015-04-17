//
//  Booking.m
//  ManagingEvents
//


#import "Booking.h"

@implementation Booking

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    // Do any additional setup after loading the view from its nib.
    
    thedelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithTitle:@"Submit" style:UIBarButtonItemStylePlain target:self action:@selector(submit:)];
    [self.navigationItem setRightBarButtonItem:barBtn];
    
    UIButton *btn1 = (UIButton *)[self.view viewWithTag:100];
    btn1.backgroundColor = [UIColor blueColor];
    mapView.hidden = NO;
    
    lat = 0;
    lon = 0;
 
    //for the map to dispay the current location
    MKCoordinateSpan span;
    MKCoordinateRegion region;
    span.latitudeDelta=1;
    span.longitudeDelta=1;
    MKUserLocation *loc1 = mapView.userLocation;
    CLLocationCoordinate2D location = loc1.coordinate ;

    region.span=span;
    region.center=location;
    [mapView setRegion:region animated:TRUE];
    [mapView regionThatFits:region];
    
    [longPressed addTarget:self action:@selector(handleLongPress:)];        
}


//----to select the location----//
- (void)handleLongPress:(UIGestureRecognizer *)gestureRecognizer
{   
    
    if (gestureRecognizer.state != UIGestureRecognizerStateBegan)
        return;
    CGPoint touchPoint = [gestureRecognizer locationInView:mapView];   
    CLLocationCoordinate2D touchMapCoordinate = 
    [mapView convertPoint:touchPoint toCoordinateFromView:mapView];
    lat = touchMapCoordinate.latitude;
    lon = touchMapCoordinate.longitude;
    NSString *latStr = [NSString stringWithFormat:@"%.4f",lat];
    NSString *lonStr = [NSString stringWithFormat:@"%.4f",lon];
   
    NSString *urlStr = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?latlng=%@,%@&sensor=true",latStr,lonStr];

    NSURLResponse * serviceResponse;
    NSError * serviceError;
       
    NSMutableURLRequest * serviceRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    NSData *returndata = [NSURLConnection sendSynchronousRequest:serviceRequest returningResponse:&serviceResponse error:&serviceError];
    
    NSString *returnInfo = [[NSString alloc] initWithData:returndata encoding:NSUTF8StringEncoding];
    NSDictionary *dropAddress = [returnInfo JSONValue];
    

    NSArray *result = (NSArray *)[dropAddress objectForKey:@"results"];
    NSDictionary *dat = (NSDictionary *)[result objectAtIndex:0];
    NSString *geometry = (NSString *)[dat objectForKey:@"formatted_address"];

    if (dropAnnotation)
    {
        [mapView removeAnnotation:dropAnnotation];
    }
    
    dropAnnotation = [[AddressAnnotation alloc] initWithCoordinate:touchMapCoordinate title:geometry subTitle:nil];
    [mapView addAnnotation:dropAnnotation];
}

- (MKAnnotationView *) mapView:(MKMapView *)mapview viewForAnnotation:(id <MKAnnotation>) annotation
{
    if (annotation == dropAnnotation)
    {
        MKPinAnnotationView *annView=[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"currentloc"];
        annView.pinColor = MKPinAnnotationColorPurple;
        annView.canShowCallout = YES;
        annView.dragState = YES;
        annView.animatesDrop = TRUE;
        annView.calloutOffset = CGPointMake(-5, 5);
        return annView;
    }
    return nil;
}

- (void)mapView:(MKMapView *)_mapView didAddAnnotationViews:(NSArray *)views {
    
    id<MKAnnotation> myAnnotation = dropAnnotation;
    [_mapView selectAnnotation:myAnnotation animated:YES];
}


//----to select the Payment methods----//
- (IBAction)modeSelectAction:(id)sender
{
    UIButton *btn1 = (UIButton *)[self.view viewWithTag:100];
    UIButton *btn2 = (UIButton *)[self.view viewWithTag:101];
    btn1.backgroundColor = [UIColor clearColor];
    btn2.backgroundColor = [UIColor clearColor];
    
    UIButton *clickedBtn = (UIButton *)sender;
    
    if (clickedBtn.backgroundColor == [UIColor whiteColor])
        [clickedBtn setBackgroundColor:[UIColor blueColor]];
    
    else if (clickedBtn.backgroundColor == [UIColor blueColor])
        [clickedBtn setBackgroundColor:[UIColor whiteColor]];
    
    if ([sender tag] == 100)
    {
        mapView.hidden = NO;
        paymentCheck = 0;
    }
    else
    { 
        mapView.hidden = YES;
        paymentCheck = 1;
    }
}

//----to submit the details regarding the booking of the ticket----//
- (IBAction)submit:(id)sender
{
    if(thedelegate.isNetworkAvailable)
    {
        if (![self validate])
            return;
       // if ((lat == 0 || lon == 0) && (paymentCheck == 0))
       // {
         //   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Address Missing!!!" message:@"Kindly choose a location from the Map" delegate:    self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
         //   [alert show];
         //   return;
      //  }
        
        NSLog(@"event id : %@",[[thedelegate.ticketInfoArray objectAtIndex:thedelegate.ticketSelected] objectForKey:@"event_id"]);
        NSLog(@"ticket id : %@",[[thedelegate.ticketInfoArray objectAtIndex:thedelegate.ticketSelected] objectForKey:@"ticket_id"]);
        NSLog(@"ticket price :%@",[[thedelegate.ticketInfoArray objectAtIndex:thedelegate.ticketSelected] objectForKey:@"ticket_price"]);
        NSLog(@"ticket space :%@",[[thedelegate.ticketInfoArray objectAtIndex:thedelegate.ticketSelected] objectForKey:@"ticket_spaces"]);

        NSString *addressStr = [[NSString stringWithFormat:@"%.4f %.4f",lat, lon] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
        NSMutableData *body=[NSMutableData data];
        NSString *boundary = [NSString stringWithString:@"14737809831466499882746641449"];
        NSString *endBoundary = [NSString stringWithFormat:@"\r\n--%@--\r\n", boundary];
    
        //URL Request
        NSMutableURLRequest *uploadRequest = [[NSMutableURLRequest alloc]
                                          initWithURL:[NSURL URLWithString:@"http://www.galamr.com/services/index.php/welcome/booking?"]];
    
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
        [uploadRequest addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
        [uploadRequest setHTTPMethod:@"POST"];
    
        NSString *Key1 = @"first_name";
        NSString *Key2 = @"last_name";
        NSString *Key3 = @"adress";
        NSString *Key4 = @"phone_number";
        NSString *Key5 = @"event_id";
        NSString *Key6 = @"ticket_id";
        NSString *Key7 = @"ticket_spaces";
        NSString *Key8 = @"ticket_price";
        NSString *Key9 = @"area";
        NSString *Key10 = @"city";
        NSString *Key11 = @"district";
        
        NSString *startBoundary = [NSString stringWithFormat:@"--%@\r\n", boundary];
    
        NSString *firstnameParam = [NSString stringWithFormat:@"Content-Disposition: form-data; first_name=\"%@\"\r\n\r\n%@\r\n--%@\r\n", Key1,firstNameTxtFld.text,boundary];
        NSString *lastNameParam = [NSString stringWithFormat:@"Content-Disposition: form-data; last_name=\"%@\"\r\n\r\n%@\r\n--%@\r\n", Key2,secondNameTxtFld.text,boundary];
        NSString *adressParam;
        if (paymentCheck == 0)
            adressParam = [NSString stringWithFormat:@"Content-Disposition: form-data; address=\"%@\"\r\n\r\n%@\r\n--%@\r\n", Key3,addressStr,boundary];
        else
            adressParam = [NSString stringWithFormat:@"Content-Disposition: form-data; address=\"%@\"\r\n\r\nINSTORE\r\n--%@\r\n", Key3,boundary];
    
        NSString *phoneNumberParam = [NSString stringWithFormat:@"Content-Disposition: form-data; phone_number=\"%@\"\r\n\r\n%@\r\n--%@\r\n", Key4,phoneTxtFld.text,boundary];
        // my added keys
                NSString *areaParam = [NSString stringWithFormat:@"Content-Disposition: form-data; phone_number=\"%@\"\r\n\r\n%@\r\n--%@\r\n", Key9,area.text,boundary];
        
                        NSString *districtParam = [NSString stringWithFormat:@"Content-Disposition: form-data; phone_number=\"%@\"\r\n\r\n%@\r\n--%@\r\n", Key11,district.text,boundary];
        
                                NSString *cityParam = [NSString stringWithFormat:@"Content-Disposition: form-data; phone_number=\"%@\"\r\n\r\n%@\r\n--%@\r\n", Key10,city.text,boundary];
        // end my added keys
        
      /*  
        NSString *eventIDParam = [NSString stringWithFormat:@"Content-Disposition: form-data; event_id=\"%@\"\r\n\r\n%@\r\n--%@\r\n", Key5,[[thedelegate.eventArray objectAtIndex:thedelegate.eventSelected] objectForKey:@"event_id"],boundary];
        NSString *ticketIDParam = [NSString stringWithFormat:@"Content-Disposition: form-data; ticket_id=\"%@\"\r\n\r\n%@\r\n--%@\r\n", Key6,[[thedelegate.ticketInfoArray objectAtIndex:thedelegate.ticketSelected] objectForKey:@"ticket_id"],boundary];
        NSString *ticketSpacesParam = [NSString stringWithFormat:@"Content-Disposition: form-data; ticket_spaces=\"%@\"\r\n\r\n%@\r\n--%@\r\n", Key7,[[thedelegate.ticketInfoArray objectAtIndex:thedelegate.ticketSelected] objectForKey:@"ticket_spaces"],boundary];
        NSString *ticketPriceParam = [NSString stringWithFormat:@"Content-Disposition: form-data; ticket_price=\"%@\"\r\n\r\n%@\r\n--%@\r\n", Key8,[[thedelegate.ticketInfoArray objectAtIndex:thedelegate.ticketSelected] objectForKey:@"ticket_price"],boundary];
        [body appendData:[startBoundary dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[firstnameParam dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[lastNameParam dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[adressParam dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[phoneNumberParam dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[eventIDParam dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[ticketIDParam dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[ticketSpacesParam dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[ticketPriceParam dataUsingEncoding:NSUTF8StringEncoding]];
        // my added keys.
         [body appendData:[areaParam dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[cityParam dataUsingEncoding:NSUTF8StringEncoding]]; 
         [body appendData:[districtParam dataUsingEncoding:NSUTF8StringEncoding]];
        // end my added keys.
        [body appendData:[endBoundary dataUsingEncoding:NSUTF8StringEncoding]];
        NSString *datastr = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
        NSLog(@"datastr: %@",datastr);
        [uploadRequest setHTTPBody: body];
        NSURLResponse * serviceResponse;
        NSError * serviceError;
        NSData *returndata = [NSURLConnection sendSynchronousRequest:uploadRequest returningResponse:&serviceResponse error:&serviceError];    
        NSString *returnString = [[NSString alloc] initWithData:returndata encoding:NSUTF8StringEncoding];
        NSLog(@"returnString:%@",returnString);
        */
        
        
        
        //NSLog(@"event id : %@",[[thedelegate.ticketInfoArray objectAtIndex:thedelegate.ticketSelected] objectForKey:@"event_id"]);
        
        
        NSLog(@"EVENT ID : %@",[[thedelegate.eventArray objectAtIndex:thedelegate.eventSelected] objectForKey:@"event_id"]);
        
        NSString *event_id = [[thedelegate.eventArray objectAtIndex:thedelegate.eventSelected] objectForKey:@"event_id"];
        
        
        NSString *ticket_id = [[thedelegate.ticketInfoArray objectAtIndex:thedelegate.ticketSelected] objectForKey:@"ticket_id"];
        
        
        //NSLog(@"ticket id : %@",[[thedelegate.ticketInfoArray objectAtIndex:thedelegate.ticketSelected] objectForKey:@"ticket_id"]);
       // NSLog(@"ticket price :%@",[[thedelegate.ticketInfoArray objectAtIndex:thedelegate.ticketSelected] objectForKey:@"ticket_price"]);
        
        NSString *ticket_price = [[thedelegate.ticketInfoArray objectAtIndex:thedelegate.ticketSelected] objectForKey:@"ticket_price"];
        
        //NSLog(@"ticket space :%@",[[thedelegate.ticketInfoArray objectAtIndex:thedelegate.ticketSelected] objectForKey:@"ticket_spaces"]);
        
        NSString *ticket_spaces = [[thedelegate.ticketInfoArray objectAtIndex:thedelegate.ticketSelected] objectForKey:@"ticket_spaces"];
        
        NSString *urlstr = [NSString stringWithFormat:@"http://www.galamr.com/services/index.php/welcome/booking?&event_id=%@&ticket_id=%@&ticket_spaces=%@&ticket_price=%@&first_name=%@&last_name=%@&phone=%@&address=%@&area=%@&district=%@&city=%@&email=%@", event_id, ticket_id, ticket_spaces, ticket_price, firstNameTxtFld.text,secondNameTxtFld.text, phoneTxtFld.text,@"", area.text, district.text,city.text,emailTxtFld.text];
        NSLog(@"Start : Sent URL WAS : ");
        NSLog(@"%@", urlstr);
        NSLog(@"End : Sent URL WAS : ");
        urlstr = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        //[urlstr retain];
        NSURL *url = [NSURL URLWithString:urlstr];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        NSLog(@"%@",responseString);
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Response" message:@"" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        return;
    }
}

//----to check whether any of the field is not left blank----//
- (BOOL)validate
{
	if ([firstNameTxtFld.text length] == 0)
    {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil 
														message:@"الاسم الأول مطلوب"
													   delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
		[alert show];
        return NO;
	}
	else if ([secondNameTxtFld.text length] == 0) 
    {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil 
														message:@"الاسم الأخير مطلوب"
													   delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
		[alert show];
        return NO;
	}
    
    else if ([emailTxtFld.text length] == 0) 
    {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil 
														message:@"البريد الالكتروني مطلوب"
													   delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
		[alert show];
		return NO;
	}
    
	else if ([phoneTxtFld.text length] == 0) 
    {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil 
														message:@"رفم الهاتف / الجوال مطلوب"
													   delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
		[alert show];
        return NO;
	}else if ([area.text length] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil 
														message:@"اسم المنطقة مطلوب"
													   delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
		[alert show];
        return NO;
    }else if ([district.text length] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil 
														message:@"اسم الحي مطلوب"
													   delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
		[alert show];
        return NO;
    }else if ([city.text length] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"اسم المدينة مطلوب" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alert show];
        return NO;
    }
	
	return YES;
}

//----to resign keyboard----//
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == firstNameTxtFld)
        [secondNameTxtFld becomeFirstResponder];
    else if (textField == secondNameTxtFld)
        [emailTxtFld becomeFirstResponder];
    else if (textField == emailTxtFld)
        [phoneTxtFld becomeFirstResponder];
    else if (textField == phoneTxtFld)
        [phoneTxtFld resignFirstResponder];
    else if (textField == city)
        [city resignFirstResponder];
    else if (textField == district) 
        [district resignFirstResponder];
    else if (textField == area) 
        [area resignFirstResponder];
    
    return YES;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) 
    {
        if (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
            return YES;
    } 
    else 
    {
        if (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
            return YES;
    }
    return NO;
}

@end
