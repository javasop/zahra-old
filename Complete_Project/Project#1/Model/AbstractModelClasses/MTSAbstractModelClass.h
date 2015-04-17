//
//  MTSAbstractModelClass.h
//  MTSFunGuideBeta
//
//  Created by Irene Berezan on 19.02.12.
//  Copyright (c) 2012 Irene Berezan. All rights reserved.

#import <Foundation/Foundation.h>

@interface MTSAbstractModelClass : NSObject <NSCoding>

- (void)encodeWithCoder:(NSCoder *)aCoder;
- (id)initWithCoder:(NSCoder *)aDecoder;

- (NSString *)currentLanguage;

@end
