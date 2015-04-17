//
//  PinAnnotationView.m
//  HealthEducationBreastCancer
//
//  Created by Irene Berezan on 02.06.12.
//  Copyright (c) 2012 Irene Berezan. All rights reserved.
//

#import "PinAnnotationView.h"

@implementation PinAnnotationView

@synthesize title = _title;
@synthesize subtitle = _subtitle;
@synthesize coordinate = _coordinate;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    self = [super init];
    if (self) 
    {
        _coordinate = coordinate;
    }
    
    return self;
}

- (void)dealloc
{
    [_title release];
    [_subtitle release];
    
    [super dealloc];
}

@end
