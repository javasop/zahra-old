//
//  Brochure.m
//  HealthEducationBreastCancer
//
//  Created by Irene Berezan on 13.05.12.
//  Copyright (c) 2012 Irene Berezan. All rights reserved.
//

#import "Brochure.h"

@implementation Brochure

+ (NSString*)jsonKey_book_ID
{
    return [NSString stringWithFormat:@"%@", BROCHURE_ID];
}

+ (NSString*)jsonKey_book_TITLE
{
    return [NSString stringWithFormat:@"%@", BROCHURE_TITLE];
}

@end
