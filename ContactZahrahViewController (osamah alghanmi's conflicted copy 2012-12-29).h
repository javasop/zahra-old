//
//  ContactZahrahViewController.h
//  Complete_Project
//
//  Created by adel alahmed on 11/13/12.
//  Copyright (c) 2012 nitin.gupta@ongraph.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactZahrahViewController : UIViewController{
    
    IBOutlet UILabel *info;
    
}

@property (strong, nonatomic) IBOutlet UILabel *info;

-(IBAction)displayInfo:(id)sender;
-(IBAction)openSite:(id)sender;


@end
