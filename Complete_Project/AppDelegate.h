//
//  AppDelegate.h
//  Complete_Project
//


#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

#import "Reachability.h"

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate, MKMapViewDelegate>{
    
    //Project #3
    NSMutableArray *mainArray;
    NSMutableArray *cartArray;
    int buttonSelected;
    CLLocationManager *locationManager;
    float lat;
    float lon;
    MKCoordinateRegion region;
    NSMutableArray *orderArray,*productsArray;
    int device;
    NSString *fnameInfo,*lnameInfo,*emailInfo,*phnInfo,*addInfo,*costInfo,*paymentInfo, *addressInfo;
    //Project #3
    NSString *region_string, *district_string, *city_string;
}
+ (NSOperationQueue *)backgroundQueue;


@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

//Project #2
@property (nonatomic, retain) NSMutableArray *eventArray;
@property (nonatomic, retain) NSMutableArray *ticketInfoArray;
@property (nonatomic, retain) NSString *selectedEvent;
@property (nonatomic, retain) NSMutableArray *dateEventArray;
@property (nonatomic, assign) int eventSelected;
@property (nonatomic, assign) int ticketSelected;

//Project Health Education
@property (nonatomic, retain) NSMutableArray *bookLibArray;




//Project #3
@property(nonatomic,retain)NSString *fnameInfo,*lnameInfo,*emailInfo,*phnInfo,*addInfo,*costInfo,*paymentInfo, *addressInfo;
@property(nonatomic,retain) NSMutableArray *orderArray,*productsArray;
@property(nonatomic,readwrite)int device;
@property(nonatomic,readwrite)int buttonSelected;
@property(nonatomic,retain) NSMutableArray *mainArray;
@property(nonatomic,retain) NSMutableArray *cartArray;
@property(nonatomic,readwrite)float lat;
@property(nonatomic,readwrite)float lon;
@property(nonatomic,readwrite)  MKCoordinateRegion region;
@property(nonatomic,retain) CLLocationManager *locationManager;
@property(nonatomic,retain) NSString *region_string,*district_string, *city_string;


- (BOOL)isNetworkAvailable;

@end
