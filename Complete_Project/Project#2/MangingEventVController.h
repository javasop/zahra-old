//
//  ViewController.h
//  ManagingEvents
//


#import <UIKit/UIKit.h>

#import "EventDetail.h"
#import "AppDelegate.h"
#import "SBJson.h"
#import "TKCalendarMonthViewController.h"
#import "TKCalendarMonthView.h"


@interface MangingEventVController : UIViewController < UINavigationControllerDelegate,UINavigationBarDelegate,TKCalendarMonthViewDelegate,TKCalendarMonthViewDataSource >
{
    
    IBOutlet UITableView *eventTable;
    
    AppDelegate *thedelegate;
    TKCalendarMonthView *calendar;	
    TKCalendarMonthViewController *controller;
    NSMutableArray *marks;
    NSMutableArray *eventDetail;
}


@end
