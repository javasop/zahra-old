//
//  MTSAbstractModelClass.m
//  MTSFunGuideBeta
//
//  Created by Irene Berezan on 19.02.12.
//  Copyright (c) 2012 Irene Berezan. All rights reserved.

#import "MTSAbstractModelClass.h"

@implementation MTSAbstractModelClass

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
    }
    return self;
}



- (NSString *)currentLanguage
{
    return [[NSLocale preferredLanguages] objectAtIndex:0];
}

@end
