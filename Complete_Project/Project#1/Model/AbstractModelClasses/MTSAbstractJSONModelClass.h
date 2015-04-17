//
//  MTSBaseEntity.h
//  MTSFunGuide
//
//  Created by Irene Berezan on 19.02.12.
//  Copyright (c) 2012 Irene Berezan. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "MTSAbstractModelClass.h"

@interface MTSAbstractJSONModelClass : MTSAbstractModelClass
+ (NSInteger)parseIntegerFromDictionary:(NSDictionary *)dictionary forKey:(NSString *)key;
+ (BOOL)parseBoolFromDictionary:(NSDictionary *)dictionary forKey:(NSString *)key;
+ (NSString *)parseStringFromDictionary:(NSDictionary *)dictionary forKey:(NSString *)key;
+ (NSNumber *)parseNumberFromDictionary:(NSDictionary *)dictionary forKey:(NSString *)key;
+ (id)parseJSONObjectFromDictionary:(NSDictionary *)dictionary forKey:(NSString *)key;
+ (float)parseFloatFromDictionary:(NSDictionary *)dictionary forKey:(NSString *)key;
+ (NSDate *)parseDateFromDictionary:(NSDictionary *)dictionary forKey:(NSString *)key;
+ (NSDate *)parseShortDateFromDictionary:(NSDictionary *)dictionary forKey:(NSString *)key;

- (id)initWithDictionary:(NSDictionary*)dictionary;
- (NSDictionary*)dictionary;


+ (NSString*)timestampValueFromDate:(NSDate*)date;
+ (NSString*)newsTimestampValueFromDate:(NSDate*)date;
+ (NSString*)dayMonthStringFromDate:(NSDate*)date;
+ (NSString*)dayMonthTimeStringFromDate:(NSDate*)date;
+ (NSString*)timeStringFromDate:(NSDate*)date;
+ (NSString*)birthdayStringFromDate:(NSDate*)date;
@end
