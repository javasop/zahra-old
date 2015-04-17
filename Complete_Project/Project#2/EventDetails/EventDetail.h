//
//  EventDetail.h
//  ManagingEvents
//
//  Created by ankit on 21/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "AppDelegate.h"
#import "iCarousel.h"
#import "typeOfTicket.h"
#import "SBJson.h"
#import "AddressAnnotation.h"


@interface EventDetail : UIViewController<iCarouselDataSource,iCarouselDelegate,MKMapViewDelegate>
{
    IBOutlet iCarousel *carousel;
    AppDelegate *thedelegate;
    NSMutableArray *items;
    
    UIBarButtonItem *barBtn;
    
    IBOutlet UIView *loadingView;
    IBOutlet UILabel *placeLbl;
    IBOutlet UILabel *priceLbl;
    IBOutlet UILabel *dateTimeLbl;
    IBOutlet UITextView *eventDescTxtView;
    IBOutlet MKMapView *mapView;
    IBOutlet UIButton *fullScreenBtn;
    IBOutlet MKMapView *fullScreenMap;
    IBOutlet UIView *fullScreenMapView;
        
    NSURL *imageURL;
    NSData *imageData;
    UIImage *tempImage;
    
    IBOutlet UILabel *placeLblHolder;
    IBOutlet UILabel *priceLblHolder;
    IBOutlet UILabel *dateTimeLblHolder;
    IBOutlet UILabel *eventDescTxtViewHolder;
        
    IBOutlet UIView *detailView;


    int carouselCheck;
    
}
- (IBAction)buttonTapped:(id)sender;
- (IBAction)booking:(id)sender;
- (UIImage *)resizeImage:(UIImage *)image width:(float)resizeWidth height:(float)resizeHeight;
- (IBAction)fullScreen:(id)sender;
- (IBAction)closeMapView:(id)sender;

@end
