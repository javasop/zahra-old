//
//  Article.m
//  HealthEducationBreastCancer
//
//  Created by Irene Berezan on 04.05.12.
//  Copyright (c) 2012 Irene Berezan. All rights reserved.
//

#import "Article.h"
#import "Author.h"

@implementation Article
@synthesize ID = _ID;
@synthesize title = _title;
@synthesize abstract = _abstract;
@synthesize text = _text;

@synthesize date = _date;

@synthesize author = _author;

- (id)initWithDictionary:(NSDictionary*)dictinary
{
    if (self = [super init])
    {
        _ID = [MTSAbstractJSONModelClass parseIntegerFromDictionary:dictinary forKey:ARTICLE_ID];
        _title = [[MTSAbstractJSONModelClass parseStringFromDictionary:dictinary forKey:ARTICLE_TITLE] retain];
        _abstract = [[MTSAbstractJSONModelClass parseStringFromDictionary:dictinary forKey:ARTICLE_ABSTRACT] retain];
        _text = [[MTSAbstractJSONModelClass parseStringFromDictionary:dictinary forKey:ARTICLE_TEXT] retain];
        _date = [[MTSAbstractJSONModelClass parseDateFromDictionary:dictinary forKey:ARTICLE_DATE] retain];
        
        NSUInteger author_ID = [MTSAbstractJSONModelClass parseIntegerFromDictionary:dictinary forKey:ARTICLE_AUTHOR_ID];
        NSString* author_firstname = [MTSAbstractJSONModelClass parseStringFromDictionary:dictinary forKey:ARTICLE_AUTHOR_FIRSTNAME];
        NSString* author_lastname = [MTSAbstractJSONModelClass parseStringFromDictionary:dictinary forKey:ARTICLE_AUTHOR_LASTNAME];
        
        _author = [[Author alloc] initWithID:author_ID firstname:author_firstname lastname:author_lastname];
    }
    return self;
}

- (void)dealloc
{
    [_title release];
    [_abstract release];
    [_text release];
    [_date release];
    [_author release];
    [super dealloc];
}

- (NSDictionary*)dictionary
{
    NSDictionary* dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                [NSNumber numberWithInteger:self.ID], ARTICLE_ID,
                                self.title, ARTICLE_TITLE,
                                self.abstract, ARTICLE_ABSTRACT,
                                self.text, ARTICLE_TEXT,
                                [MTSAbstractJSONModelClass timestampValueFromDate:self.date], ARTICLE_DATE,
                                [NSNumber numberWithInteger:self.author.ID], ARTICLE_AUTHOR_ID,
                                self.author.firstname, ARTICLE_AUTHOR_FIRSTNAME,
                                self.author.lastname, ARTICLE_AUTHOR_LASTNAME,
                                nil];
    return dictionary;
}
@end
