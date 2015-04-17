//
//  IFRMapViewController.m
//  iFRest
//
//  Created by Irene Berezan on 12/1/11.
//  Copyright (c) 2011 iFree Ukraine. All rights reserved.
//

#import "HLBCMapViewController.h"
#import "PinAnnotationView.h"

@implementation HLBCMapViewController

@synthesize mapView = _mapView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)dealloc
{
    [_locationManager release];
    [_mapView release];
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    [_locationManager stopUpdatingLocation];
    if (_locationManager.delegate == self)
    {
        _locationManager.delegate = nil;
    }
    
    self.mapView = nil;
}

- (void)viewWillUnload
{
    [super viewWillUnload];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [_locationManager stopUpdatingLocation];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [_locationManager startUpdatingLocation];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)setCenterCoordinateWithLatitude:(float)latitude andLongitude:(float)longitude andSpansize:(float)spansize
{
    CLLocationDegrees latitudeD = (double)latitude;
    CLLocationDegrees longitudeD = (double)longitude;
    
    CLLocationDegrees latitudeDelta = (double)spansize;
    CLLocationDegrees longitudeDelta = (double)spansize;
    
    [self.mapView setRegion:MKCoordinateRegionMake(CLLocationCoordinate2DMake(latitudeD, longitudeD), MKCoordinateSpanMake(latitudeDelta, longitudeDelta)) animated:YES];
}

- (void)setCenterCoordinateWithLatitude:(float)latitude andLongitude:(float)longitude
{
    [self setCenterCoordinateWithLatitude:latitude andLongitude:longitude andSpansize:kDefaultMapSpanize];
}

- (void)setCenterCoordinateWithUserLocation
{
    
    if (!_locationManager)
    {
        _locationManager = [[CLLocationManager alloc] init];
    }
    [_locationManager setHeadingFilter:0.5];
    [_locationManager setDistanceFilter:kCLDistanceFilterNone];
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    _locationManager.delegate = self;
    
    if ([CLLocationManager locationServicesEnabled])
    {
        [_locationManager startUpdatingLocation];
    }
    
    // Custom initialization
}

- (void)addPlacemarkWithLatitude:(float)latitude andLongitude:(float)longitude
{
    CLLocationDegrees latitudeD = (double)latitude;
    CLLocationDegrees longitudeD = (double)longitude;
    if ((latitudeD + longitudeD) > 0.01)
    {
        MKPlacemark* placemark = [[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake(latitudeD, longitudeD) addressDictionary:nil];
        [self.mapView addAnnotation:placemark];
        [placemark release];
    }    
}

- (void)addPlacemarkWithLatitude:(float)latitude andLongitude:(float)longitude withMaxDistance:(float)distance
{
    CLLocationDegrees latitudeD = (double)latitude;
    CLLocationDegrees longitudeD = (double)longitude;
    CLLocation *location = [self.mapView userLocation].location;
    CLLocation *placementLocation = [[CLLocation alloc] initWithLatitude:latitudeD longitude:longitudeD];
    if ([location distanceFromLocation:placementLocation] < distance)
    {
        [self addPlacemarkWithLatitude:latitude andLongitude:longitude];
    }
    [placementLocation release];
}

- (void)addPlacemarkWithLatitude:(float)latitude andLongitude:(float)longitude title:(NSString*)title subtitle:(NSString*)subtitle
{
    CLLocationDegrees latitudeD = (double)latitude;
    CLLocationDegrees longitudeD = (double)longitude;
    if ((latitudeD + longitudeD) > 0.01)
    {
        PinAnnotationView* placemark = [[PinAnnotationView alloc] initWithCoordinate:CLLocationCoordinate2DMake(latitudeD, longitudeD)];
        placemark.title = title;
        placemark.subtitle = subtitle;
        [self.mapView addAnnotation:placemark];
        [placemark release];
    }    
}

#pragma mark -
#pragma mark GRS delegate
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    if (manager == _locationManager)
    {
        CLLocationCoordinate2D location = newLocation.coordinate;
        [self setCenterCoordinateWithLatitude:location.latitude andLongitude:location.longitude];
        [manager stopUpdatingLocation];        
    }
}

@end
