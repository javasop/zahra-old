//
//  IFRMapViewController.h
//  iFRest
//
//  Created by Irene Berezan on 12/1/11.
//  Copyright (c) 2011 iFree Ukraine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

static const float kDefaultMapSpanize = 0.04;

@interface AHEBCMapViewController : UIViewController <CLLocationManagerDelegate>
{
    MKMapView* _mapView;
    
    CLLocationManager* _locationManager;
}

@property (nonatomic, retain) IBOutlet MKMapView* mapView;

- (void)setCenterCoordinateWithLatitude:(float)latitude andLongitude:(float)longitude;
- (void)setCenterCoordinateWithUserLocation;
- (void)addPlacemarkWithLatitude:(float)latitude andLongitude:(float)longitude;
- (void)addPlacemarkWithLatitude:(float)latitude andLongitude:(float)longitude withMaxDistance:(float)distance;

- (void)addPlacemarkWithLatitude:(float)latitude andLongitude:(float)longitude title:(NSString*)title subtitle:(NSString*)subtitle;
@end
