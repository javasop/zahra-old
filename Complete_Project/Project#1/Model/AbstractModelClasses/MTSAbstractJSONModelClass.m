//
//  MTSBaseEntity.m
//  MTSFunGuide
//
//  Created by Irene Berezan on 19.02.12.
//  Copyright (c) 2012 Irene Berezan. All rights reserved.

#import "MTSAbstractJSONModelClass.h"

@implementation MTSAbstractJSONModelClass

- (id)initWithDictionary:(NSDictionary*)dictionary
{
    if (self = [super init])
    {
	}
	
	return self;
}

- (NSDictionary*)dictionary
{
    return [NSDictionary dictionary];
}

+ (NSInteger)parseIntegerFromDictionary:(NSDictionary *)dictionary forKey:(NSString *)key 
{
    NSInteger result = 0;
    
    NSNumber* iD = [dictionary objectForKey:key];
    if (![iD isKindOfClass:[NSNull class]])
    {
        result = [iD integerValue];
    }
    
    return result;
}

+ (BOOL)parseBoolFromDictionary:(NSDictionary *)dictionary forKey:(NSString *)key 
{
    BOOL result = NO;
    
    NSNumber* iD = [dictionary objectForKey:key];
    if (![iD isKindOfClass:[NSNull class]])
    {
        result = [iD boolValue];
    }
    
    return result;
}

+ (NSNumber *)parseNumberFromDictionary:(NSDictionary *)dictionary forKey:(NSString *)key 
{
    NSNumber *result = nil;
    
    NSNumber *title = [dictionary objectForKey:key];
    if (![title isKindOfClass:[NSNull class]])
    {
        result = title;
    }
    
    return result;
}

+ (NSString *)parseStringFromDictionary:(NSDictionary *)dictionary forKey:(NSString *)key 
{
    NSString *result = nil;
    
    NSString *title = [dictionary objectForKey:key];
    if (![title isKindOfClass:[NSNull class]])
    {
        result = title;
    }
    
    return result;
}

+ (id)parseJSONObjectFromDictionary:(NSDictionary *)dictionary forKey:(NSString *)key 
{
    id result = nil;
    
    id object = [dictionary objectForKey:key];
    if (![object isKindOfClass:[NSNull class]])
    {
        result = object;
    }
    
    return result;
}

+ (float)parseFloatFromDictionary:(NSDictionary *)dictionary forKey:(NSString *)key
{
    float result = 0.0;
    
    NSNumber* iD = [dictionary objectForKey:key];
    if (![iD isKindOfClass:[NSNull class]])
    {
        result = [iD floatValue];
    }
    
    return result;
}
+ (NSDate *)parseDateFromDictionary:(NSDictionary *)dictionary forKey:(NSString *)key {
    NSDate *result = nil;
    
    NSString *dateString = [dictionary objectForKey:key];
    if (![dateString isKindOfClass:[NSNull class]])
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        result = [dateFormatter dateFromString:dateString];
        [dateFormatter release];
    }
    
    return result;
}
+ (NSDate *)parseShortDateFromDictionary:(NSDictionary *)dictionary forKey:(NSString *)key {
    NSDate *result = nil;
    
    NSString *dateString = [dictionary objectForKey:key];
    if (![dateString isKindOfClass:[NSNull class]])
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        result = [dateFormatter dateFromString:dateString];
        [dateFormatter release];
    }
    
    return result;
}

+ (NSString*)newsTimestampValueFromDate:(NSDate*)date
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd MMM HH:mm"];
    NSString* dictionaryValue = [dateFormatter stringFromDate:date]; 
    [dateFormatter release];
    return dictionaryValue;
}

+ (NSString*)timestampValueFromDate:(NSDate*)date
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString* dictionaryValue = [dateFormatter stringFromDate:date]; 
    [dateFormatter release];
    return dictionaryValue;
}

+ (NSString*)dayMonthStringFromDate:(NSDate*)date
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"d MMMM"];
    NSString* dictionaryValue = [dateFormatter stringFromDate:date]; 
    [dateFormatter release];
    return dictionaryValue;
}

+ (NSString*)birthdayStringFromDate:(NSDate*)date
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd.MM.yyyy"];
    NSString* dictionaryValue = [dateFormatter stringFromDate:date]; 
    [dateFormatter release];
    return dictionaryValue;
}

+ (NSString*)dayMonthTimeStringFromDate:(NSDate*)date
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"d MMMM HH:mm"];
    NSString* dictionaryValue = [dateFormatter stringFromDate:date]; 
    [dateFormatter release];
    return dictionaryValue;
}

+ (NSString*)timeStringFromDate:(NSDate*)date
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString* dictionaryValue = [dateFormatter stringFromDate:date]; 
    [dateFormatter release];
    return dictionaryValue;
}
 
@end
