//
//  Book.h
//  HealthEducationBreastCancer
//
//  Created by Irene Berezan on 04.05.12.
//  Copyright (c) 2012 Irene Berezan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MTSAbstractJSONModelClass.h"

static NSString* const BOOK_ID = @"book_id";
static NSString* const BOOK_TITLE = @"book_name";
static NSString* const BOOK_COVER_URL = @"cover";

static NSString* const BOOK_TEXT_URL = @"pdf_file";

@interface Book : MTSAbstractJSONModelClass
{
    NSUInteger _ID;
    NSString* _title;
    NSString* _coverURL;
    NSString* _textURL;
}

@property (assign, readwrite) NSUInteger ID;
@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) NSString* coverURL;
@property (nonatomic, retain) NSString* textURL;

+ (NSString*)jsonKey_book_ID;
+ (NSString*)jsonKey_book_TITLE;
@end
