//
//  HEBCHospitalDetailsMapViewController.h
//  HealthEducationBreastCancer
//
//  Created by Irene Berezan on 10.05.12.
//  Copyright (c) 2012 Irene Berezan. All rights reserved.
//

#import "HLBCMapViewController.h"

@class Hospital;
@interface HLBCHospitalDetailsMapViewController : HLBCMapViewController
{
    Hospital* _hospital;
}

@property (nonatomic, retain) Hospital* hospital;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil hospital:(Hospital*)hospital;

- (IBAction)callToHospital:(id)sender;
@end
