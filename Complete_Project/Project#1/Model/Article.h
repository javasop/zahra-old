//
//  Article.h
//  HealthEducationBreastCancer
//
//  Created by Irene Berezan on 04.05.12.
//  Copyright (c) 2012 Irene Berezan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MTSAbstractJSONModelClass.h"

// API keys
static NSString* const ARTICLE_ID = @"article_id";
static NSString* const ARTICLE_TITLE = @"post_title";
static NSString* const ARTICLE_ABSTRACT = @"post_excerpt";
static NSString* const ARTICLE_TEXT = @"post_content";
static NSString* const ARTICLE_DATE = @"post_date";

static NSString* const ARTICLE_AUTHOR_ID = @"ID";
static NSString* const ARTICLE_AUTHOR_FIRSTNAME = @"first_name";
static NSString* const ARTICLE_AUTHOR_LASTNAME = @"last_name";


@class Author;


@interface Article : MTSAbstractJSONModelClass
{
    NSUInteger _ID;
    NSString* _title;
    NSString* _abstract;
    NSString* _text;
    NSDate* _date;
    
    Author* _author;
}

@property (assign, readwrite) NSUInteger ID;
@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) NSString* abstract;
@property (nonatomic, retain) NSString* text;

@property (nonatomic, retain) NSDate* date;

@property (nonatomic, retain) Author* author;

@end
