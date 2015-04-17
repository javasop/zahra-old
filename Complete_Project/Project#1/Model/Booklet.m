//
//  Booklet.m
//  HealthEducationBreastCancer
//
//  Created by Irene Berezan on 13.05.12.
//  Copyright (c) 2012 Irene Berezan. All rights reserved.
//

#import "Booklet.h"

@implementation Booklet

+ (NSString*)jsonKey_book_ID
{
    return [NSString stringWithFormat:@"%@", BOOKLET_ID];
}

+ (NSString*)jsonKey_book_TITLE
{
    return [NSString stringWithFormat:@"%@", BOOKLET_TITLE];
}

@end
