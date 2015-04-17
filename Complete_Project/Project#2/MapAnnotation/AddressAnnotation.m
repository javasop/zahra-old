//
//  AddressAnnotation.m
//  FindMyCar
//
//  Created by Apple on 26/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AddressAnnotation.h"

@implementation AddressAnnotation

@synthesize coordinate;
@synthesize mTitle;
@synthesize mSubTitle;

- (NSString *)subtitle{
    return mSubTitle;
}

- (NSString *)title{
    return mTitle;
}

-(id)initWithCoordinate:(CLLocationCoordinate2D)c title:(NSString *)t subTitle:(NSString *)st
{
    coordinate = c;
	mTitle =  t;
    mSubTitle = st;
    return self;
}
-(id)initWithCoordinate:(CLLocationCoordinate2D)c{
    coordinate=c;
    NSLog(@"%f,%f",c.latitude,c.longitude);
    return self;
}

-(void) moveAnnotation:(CLLocationCoordinate2D) newCoordinate
{
    coordinate = newCoordinate;
}
@end