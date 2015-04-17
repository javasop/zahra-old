//
//  EventTableViewController.h
//  Complete_Project
//
//  Created by Rebecca Sable on 6/30/14.
//  Copyright (c) 2014 nitin.gupta@ongraph.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventDetail.h"
#import "AppDelegate.h"
#import "SBJson.h"

@interface EventTableViewController : UITableViewController{
    
AppDelegate *thedelegate;
NSMutableArray *eventDetail;
}
@property (nonatomic, retain) NSMutableArray *events;

@end
