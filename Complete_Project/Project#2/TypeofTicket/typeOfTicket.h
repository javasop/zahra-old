//
//  Booking.h
//  ManagingEvents
//
//  Created by ankit on 22/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Booking.h"
#import "SBJson.h"

@interface typeOfTicket : UIViewController
{
    AppDelegate *thedelegate;
    
    IBOutlet UIImageView *featuredImgView;
    IBOutlet UIView *loadingView;
    
    UIBarButtonItem *barBtn;
}

- (IBAction)buttonClicked:(id)sender;
- (IBAction)book:(id)sender;

@end
