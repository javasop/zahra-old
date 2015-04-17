//
//  shippingInformation.m
//  StoreModule
//
//  Created by AgilePc-100 on 4/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "shippingInformation.h"
#import "DDAnnotation.h"
#import "DDAnnotationView.h"
#import "JSON.h"
@interface shippingInformation () 
- (void)coordinateChanged_:(NSNotification *)notification;
@end

@implementation shippingInformation
@synthesize mapView;
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
    mapView.delegate=self;
    [butManually setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
    [butOnMap setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Complete Order" style:UIBarButtonItemStylePlain target:self action:@selector(completeOrder:)];
    mapView.hidden =TRUE;
    addressLable.hidden=FALSE;
    addressText.hidden =FALSE;
    addressText.delegate=self;
    CLLocationCoordinate2D theCoordinate;
	theCoordinate.latitude = app.lat;
    theCoordinate.longitude = app.lon;
	
	DDAnnotation *annotation = [[[DDAnnotation alloc] initWithCoordinate:theCoordinate addressDictionary:nil] autorelease];
	annotation.title = @"Drag to Move Pin";
	annotation.subtitle = [NSString	stringWithFormat:@"%f %f", annotation.coordinate.latitude, annotation.coordinate.longitude];
	
    [self.mapView setCenterCoordinate:annotation.coordinate animated:YES];
	[self.mapView addAnnotation:annotation];
    chkButton=1;
}
-(IBAction)completeOrder:(id)sender{
    app.orderArray=[[NSMutableArray alloc] init];
    NSString *pay=@"XYZ";
    if (chkButton==1) {
        app.addInfo=addressText.text;
    }
    else{
        NSString *strurl = [NSString stringWithFormat:@"http://maps.google.com/maps/geo?q=%@,%@&output=json",addLat,addLon];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString:strurl]];
        [request setHTTPMethod: @"GET"];
        NSData *returnData = [ NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil ];
        NSString *returnString = [[NSString alloc] initWithData:returnData encoding: NSUTF8StringEncoding];
        NSLog(@"Returned Json: %@", returnString);
        NSDictionary *dictJson = [returnString JSONValue];
        app.addInfo = [[[dictJson objectForKey:@"Placemark"] objectAtIndex:0] objectForKey:@"address"];
    }
    NSMutableDictionary *dictOrder=[[NSMutableDictionary alloc] init];
    [dictOrder setObject:app.fnameInfo forKey:@"first_name"];
    [dictOrder setObject:app.lnameInfo forKey:@"last_name"];
    [dictOrder setObject:app.emailInfo forKey:@"email"];
    [dictOrder setObject:app.addInfo forKey:@"address"];
    [dictOrder setObject:app.costInfo forKey:@"total"];
    [dictOrder setObject:pay forKey:@"payment_method"];
    [app.orderArray addObject:dictOrder];
    NSLog(@"%@",[app.orderArray description]);
    [app.orderArray retain];
    
    SBJsonWriter *writer = [SBJsonWriter new];
    NSString *str = [writer stringWithObject:app.orderArray];
    [str  retain];
    NSLog(@"%@",str);
    
    SBJsonWriter *writer2 = [SBJsonWriter new];
    NSString *str2 = [writer2 stringWithObject:app.productsArray];
    [str2 retain];
    NSLog(@"%@",str2);
    
    NSString *urlstr = [NSString stringWithFormat:@"http://www.galamr.com/services/index.php/welcome/place_new_order?&order=%@&product=%@",str,str2];
    urlstr = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [urlstr retain];
    NSURL *url = [NSURL URLWithString:urlstr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",responseString);
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
-(IBAction)butManuallyClicked:(id)sender{
    mapView.hidden =TRUE;
    addressLable.hidden=FALSE;
    addressText.hidden =FALSE;
    [butManually setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
    [butOnMap setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    chkButton=1;
}
-(IBAction)butOnMapClicked:(id)sender{
    [addressText resignFirstResponder];
    mapView.hidden =FALSE;
    addressLable.hidden=TRUE;
    addressText.hidden =TRUE;
    [butManually setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    [butOnMap setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
    chkButton=2;
}

- (void)viewWillAppear:(BOOL)animated {
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(coordinateChanged_:) name:@"DDAnnotationCoordinateDidChangeNotification" object:nil];
    if (app.device!=0) {
        if ([[UIApplication sharedApplication] statusBarOrientation]==UIInterfaceOrientationPortrait || [[UIApplication sharedApplication] statusBarOrientation]==UIInterfaceOrientationPortraitUpsideDown) {
            labMain.frame=CGRectMake(207, 20, 354, 21);
            lab1.frame=CGRectMake(232, 52, 128, 24);
            lab2.frame=CGRectMake(431, 52, 138, 24);
            butManually.frame=CGRectMake(200, 52, 25,25);
            butOnMap.frame=CGRectMake(399, 52, 25, 25);
            addressLable.frame=CGRectMake(125, 386, 145, 21);
            addressText.frame=CGRectMake(279, 367, 419, 59);
            mapView.frame=CGRectMake(0, 90, 768, 918);
        }
        else
        {
            labMain.frame=CGRectMake(335, 20, 354, 21);
            lab1.frame=CGRectMake(360, 52, 128, 24);
            lab2.frame=CGRectMake(559, 52, 138, 24);
            butManually.frame=CGRectMake(328, 52, 25,25);
            butOnMap.frame=CGRectMake(527, 52, 25, 25);
            addressLable.frame=CGRectMake(280, 305, 145, 21);
            addressText.frame=CGRectMake(430, 288, 419, 59);
            mapView.frame=CGRectMake(0, 90, 1024, 662);
        }  
    }
      
}

- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"DDAnnotationCoordinateDidChangeNotification" object:nil];	
	[addressText resignFirstResponder];
}
- (void)viewDidUnload {
	self.mapView.delegate = nil;
	self.mapView = nil;
}

- (void)dealloc {
	mapView.delegate = nil;
	[mapView release];
    [super dealloc];
}

#pragma mark -
#pragma mark DDAnnotationCoordinateDidChangeNotification

- (void)coordinateChanged_:(NSNotification *)notification {	
	DDAnnotation *annotation = notification.object;
	annotation.subtitle = [NSString	stringWithFormat:@"%f %f", annotation.coordinate.latitude, annotation.coordinate.longitude];
    NSLog(@"fgdgfdg");
}

#pragma mark -
#pragma mark MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView1 annotationView:(MKAnnotationView *)annotationView didChangeDragState:(MKAnnotationViewDragState)newState fromOldState:(MKAnnotationViewDragState)oldState {
	if (oldState == MKAnnotationViewDragStateDragging) {
		DDAnnotation *annotation = (DDAnnotation *)annotationView.annotation;
		annotation.subtitle = [NSString	stringWithFormat:@"%f %f", annotation.coordinate.latitude, annotation.coordinate.longitude];		
        addLat=[NSString stringWithFormat:@"%f", annotation.coordinate.latitude];
        addLon=[NSString stringWithFormat:@"%f", annotation.coordinate.longitude];
        [addLat retain];
        [addLon retain];
        [mapView setCenterCoordinate:annotation.coordinate animated:YES];
	}
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;		
	}
	static NSString * const kPinAnnotationIdentifier = @"PinIdentifier";
	MKAnnotationView *draggablePinView = [self.mapView dequeueReusableAnnotationViewWithIdentifier:kPinAnnotationIdentifier];
	if (draggablePinView) {
		draggablePinView.annotation = annotation;
	} else {
		draggablePinView = [DDAnnotationView annotationViewWithAnnotation:annotation reuseIdentifier:kPinAnnotationIdentifier mapView:self.mapView];
		if ([draggablePinView isKindOfClass:[DDAnnotationView class]]) {
		} else {
		}
	}		
	return draggablePinView;
}
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (app.device==0) {
        return NO;
    }
    return YES;
}
-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (toInterfaceOrientation==UIInterfaceOrientationPortrait || toInterfaceOrientation==UIInterfaceOrientationPortraitUpsideDown) {
        labMain.frame=CGRectMake(207, 20, 354, 21);
        lab1.frame=CGRectMake(232, 52, 128, 24);
        lab2.frame=CGRectMake(431, 52, 138, 24);
        butManually.frame=CGRectMake(200, 52, 25,25);
        butOnMap.frame=CGRectMake(399, 52, 25, 25);
        addressLable.frame=CGRectMake(125, 386, 145, 21);
        addressText.frame=CGRectMake(279, 367, 419, 59);
        mapView.frame=CGRectMake(0, 90, 768, 918);
    }
    else
    {
        labMain.frame=CGRectMake(335, 20, 354, 21);
        lab1.frame=CGRectMake(360, 52, 128, 24);
        lab2.frame=CGRectMake(559, 52, 138, 24);
        butManually.frame=CGRectMake(328, 52, 25,25);
        butOnMap.frame=CGRectMake(527, 52, 25, 25);
        addressLable.frame=CGRectMake(280, 305, 145, 21);
        addressText.frame=CGRectMake(430, 288, 419, 59);
        mapView.frame=CGRectMake(0, 90, 1024, 662);
    }    
}
@end
