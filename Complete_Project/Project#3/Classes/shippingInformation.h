//
//  shippingInformation.h
//  StoreModule
//
//  Created by AgilePc-100 on 4/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "AppDelegate.h"
@interface shippingInformation : UIViewController<MKMapViewDelegate,UITextFieldDelegate,CLLocationManagerDelegate>
{
    AppDelegate *app;
    IBOutlet MKMapView *mapView;
    IBOutlet UIButton *butManually,*butOnMap;
    IBOutlet UILabel *addressLable;
    IBOutlet UITextField *addressText;
    IBOutlet UILabel *lab1,*lab2,*labMain;
    NSString *addLat,*addLon;
    int chkButton;
}
@property(nonatomic,retain)IBOutlet MKMapView *mapView;
-(IBAction)butManuallyClicked:(id)sender;
-(IBAction)butOnMapClicked:(id)sender;
-(IBAction)completeOrder:(id)sender;
@end
