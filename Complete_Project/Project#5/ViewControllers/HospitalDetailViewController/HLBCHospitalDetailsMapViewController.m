//
//  HEBCHospitalDetailsMapViewController.m
//  HealthEducationBreastCancer
//
//  Created by Irene Berezan on 10.05.12.
//  Copyright (c) 2012 Irene Berezan. All rights reserved.
//

#import "HLBCHospitalDetailsMapViewController.h"
#import "Hospital.h"

@implementation HLBCHospitalDetailsMapViewController

@synthesize hospital = _hospital;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil hospital:(Hospital*)hospital
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        _hospital = [hospital retain];
    }
    return self;
}


- (void)dealloc
{
    [_hospital release];
    
    [super dealloc];
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) { // if iOS 7
        self.edgesForExtendedLayout = UIRectEdgeNone; //layout adjustements
    }
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone)
    {
        UIBarButtonItem * callButtonIten = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Call", @"Call") style:UIBarButtonItemStyleBordered target:self action:@selector(callToHospital:)];
        self.navigationItem.rightBarButtonItem = callButtonIten;
        [callButtonIten release];
    }
    
    [self setCenterCoordinateWithLatitude:self.hospital.latitude andLongitude:self.hospital.longitude];
    [self addPlacemarkWithLatitude:self.hospital.latitude andLongitude:self.hospital.longitude title:self.hospital.name subtitle:[NSString stringWithFormat:@"%@: %d %%", NSLocalizedString(@"Discount", @"Discount"), self.hospital.discount]];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

#pragma mark -
#pragma Events
- (IBAction)callToHospital:(id)sender
{
    NSString *phoneURLString = [NSString stringWithFormat:@"tel:+38//%@", self.hospital.phone];
    NSURL *phoneURL = [NSURL URLWithString:phoneURLString];
    [[UIApplication sharedApplication] openURL:phoneURL];     
}

@end
