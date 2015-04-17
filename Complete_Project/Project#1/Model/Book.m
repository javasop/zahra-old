//
//  Book.m
//  HealthEducationBreastCancer
//
//  Created by Irene Berezan on 04.05.12.
//  Copyright (c) 2012 Irene Berezan. All rights reserved.
//

#import "Book.h"

@implementation Book

@synthesize ID = _ID;
@synthesize title = _title;
@synthesize coverURL = _coverURL;
@synthesize textURL = _textURL;

+ (NSString*)jsonKey_book_ID
{
    return [NSString stringWithFormat:@"%@", BOOK_ID];
}

+ (NSString*)jsonKey_book_TITLE
{
    return [NSString stringWithFormat:@"%@", BOOK_TITLE];
}

- (id)initWithDictionary:(NSDictionary*)dictinary
{
    if (self = [super init])
    {
        _ID = [MTSAbstractJSONModelClass parseIntegerFromDictionary:dictinary forKey:[[self class] jsonKey_book_ID]];
        _title = [[MTSAbstractJSONModelClass parseStringFromDictionary:dictinary forKey:[[self class] jsonKey_book_TITLE]] retain];
        _coverURL = [[[MTSAbstractJSONModelClass parseStringFromDictionary:dictinary forKey:BOOK_COVER_URL] stringByReplacingPercentEscapesUsingEncoding:NSUnicodeStringEncoding] retain];
        _textURL = [[[MTSAbstractJSONModelClass parseStringFromDictionary:dictinary forKey:BOOK_TEXT_URL] stringByReplacingPercentEscapesUsingEncoding:NSUnicodeStringEncoding] retain];
        NSLog(@"Url:  %@ %@", _coverURL, _textURL);
    }
    return self;
}

- (void)dealloc
{
    [_title release];
    [_coverURL release];
    [_textURL release];
    [super dealloc];
}

- (NSDictionary*)dictionary
{
    NSDictionary* dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                [NSNumber numberWithInteger:self.ID], [[self class] jsonKey_book_ID],
                                self.title, [[self class] jsonKey_book_TITLE],
                                self.coverURL, BOOK_COVER_URL,
                                self.textURL, BOOK_TEXT_URL,
                                nil];
    return dictionary;
}
@end
