//
//  Booking.h
//  ManagingEvents
//


#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

#import "AddressAnnotation.h"
#import "AppDelegate.h"
#import "SBJson.h"

@interface Booking : UIViewController<MKMapViewDelegate,UITextFieldDelegate>
{
    AppDelegate *thedelegate;
    
    IBOutlet UILongPressGestureRecognizer *longPressed;
    IBOutlet MKMapView *mapView;
    
    IBOutlet UITextField *firstNameTxtFld;
    IBOutlet UITextField *secondNameTxtFld;
    IBOutlet UITextField *emailTxtFld;
    IBOutlet UITextField *phoneTxtFld;
    IBOutlet UITextField *city;
    IBOutlet UITextField *district;
    IBOutlet UITextField *area;
    IBOutlet UILabel *how_to_specify_location;
    AddressAnnotation *dropAnnotation;
    NSString *event_id; 
    CLLocationDegrees lat;
    CLLocationDegrees lon;
    int paymentCheck;
}

@property (nonatomic, retain) NSString *event_id;
- (IBAction)modeSelectAction:(id)sender;
- (IBAction)submit:(id)sender;
- (BOOL)validate;

@end
