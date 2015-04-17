//
//  FAQItem.m
//  HealthEducationBreastCancer
//
//  Created by Irene Berezan on 04.05.12.
//  Copyright (c) 2012 Irene Berezan. All rights reserved.
//

#import "FAQItem.h"

@implementation FAQItem

@synthesize ID = _ID;
@synthesize date = _date;
@synthesize question = _question;
@synthesize content = _content;

- (id)initWithDictionary:(NSDictionary*)dictinary
{
    if (self = [super init])
    {
        _ID = [MTSAbstractJSONModelClass parseIntegerFromDictionary:dictinary forKey:FAQ_ID];
        _date = [[MTSAbstractJSONModelClass parseDateFromDictionary:dictinary forKey:FAQ_DATE] retain];
        _question = [[MTSAbstractJSONModelClass parseStringFromDictionary:dictinary forKey:FAQ_QUESTION] retain];
        _content = [[MTSAbstractJSONModelClass parseStringFromDictionary:dictinary forKey:FAQ_CONTENT] retain];
    }
    return self;
}

- (void)dealloc
{
    [_date release];
    [_question release];
    [_content release];
    
    [super dealloc];
}

- (NSDictionary*)dictionary
{
    NSDictionary* dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                [NSNumber numberWithInteger:self.ID], FAQ_ID,
                                [MTSAbstractJSONModelClass timestampValueFromDate:self.date], FAQ_DATE,
                                self.question, FAQ_QUESTION,
                                self.content, FAQ_CONTENT,
                                nil];
    return dictionary;
}

@end
