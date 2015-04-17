//
//  Hospital.h
//  HealthEducationBreastCancer
//
//  Created by Irene Berezan on 04.05.12.
//  Copyright (c) 2012 Irene Berezan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MTSAbstractJSONModelClass.h"

static NSString* const HOSPITAL_ID = @"hospital_id";
static NSString* const HOSPITAL_NAME = @"hospital_name";
static NSString* const HOSPITAL_DISCOUNT = @"discount";
static NSString* const HOSPITAL_PHONE = @"hospital_phone";
static NSString* const HOSPITAL_LATITUDE = @"_pronamic_google_maps_latitude";
static NSString* const HOSPITAL_LONGITUDE = @"_pronamic_google_maps_longitude";

@interface Hospital : MTSAbstractJSONModelClass
{
    NSUInteger _ID;
    NSString* _name;
    NSUInteger _discount;
    NSString* _phone;
    float _latitude;
    float _longitude;
}

@property (nonatomic, assign, readwrite) NSUInteger ID;
@property (nonatomic, retain) NSString* name;
@property (nonatomic, assign, readwrite) NSUInteger discount;
@property (nonatomic, retain) NSString* phone;
@property (nonatomic, assign, readwrite) float latitude;
@property (nonatomic, assign, readwrite) float longitude;


- (id)initWithDictionary:(NSDictionary*)dictinary;
- (NSDictionary*)dictionary;
@end
