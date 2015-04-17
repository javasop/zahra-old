//
//  Hospital.m
//  HealthEducationBreastCancer
//
//  Created by Irene Berezan on 04.05.12.
//  Copyright (c) 2012 Irene Berezan. All rights reserved.
//

#import "Hospital.h"

@implementation Hospital

@synthesize ID = _ID;
@synthesize name = _name;
@synthesize phone = _phone;
@synthesize discount = _discount;
@synthesize latitude = _latitude;
@synthesize longitude = _longitude;

- (id)initWithDictionary:(NSDictionary*)dictinary
{
    if (self = [super init])
    {
        _ID = [MTSAbstractJSONModelClass parseIntegerFromDictionary:dictinary forKey:HOSPITAL_ID];
        _name = [[MTSAbstractJSONModelClass parseStringFromDictionary:dictinary forKey:HOSPITAL_NAME] retain];
        _discount = [MTSAbstractJSONModelClass parseIntegerFromDictionary:dictinary forKey:HOSPITAL_DISCOUNT];
        _phone = [[MTSAbstractJSONModelClass parseStringFromDictionary:dictinary forKey:HOSPITAL_PHONE] retain];
        _latitude = [MTSAbstractJSONModelClass parseFloatFromDictionary:dictinary forKey:HOSPITAL_LATITUDE];
        _longitude = [MTSAbstractJSONModelClass parseFloatFromDictionary:dictinary forKey:HOSPITAL_LONGITUDE];
    }
    return self;
}

- (void)dealloc
{
    [_name release];
    [_phone release];
    [super dealloc];
}


- (NSDictionary*)dictionary
{
    NSDictionary* dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                [NSNumber numberWithInteger:self.ID], HOSPITAL_ID,
                                self.name, HOSPITAL_NAME,
                                [NSNumber numberWithInteger:self.discount], HOSPITAL_DISCOUNT,
                                self.phone, HOSPITAL_PHONE,
                                [NSNumber numberWithFloat:self.latitude], HOSPITAL_LATITUDE,
                                [NSNumber numberWithFloat:self.longitude], HOSPITAL_LONGITUDE,
                                nil];
    return dictionary;
}

@end
