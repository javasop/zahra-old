//
//  FAQItem.h
//  HealthEducationBreastCancer
//
//  Created by Irene Berezan on 04.05.12.
//  Copyright (c) 2012 Irene Berezan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTSAbstractJSONModelClass.h"

static NSString* const FAQ_ID = @"ID";
static NSString* const FAQ_DATE = @"post_date";
static NSString* const FAQ_QUESTION = @"post_title";
static NSString* const FAQ_CONTENT = @"post_content";

@interface FAQItem : MTSAbstractJSONModelClass
{
    NSUInteger _ID;
    NSDate* _date;
    NSString* _question;
    NSString* _content;
}

@property (assign, readwrite) NSUInteger ID;
@property (nonatomic, retain) NSString* question;
@property (nonatomic, retain) NSDate* date;
@property (nonatomic, retain) NSString* content;

@end
