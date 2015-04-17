//
//  Author.h
//  HealthEducationBreastCancer
//
//  Created by Irene Berezan on 14.05.12.
//  Copyright (c) 2012 Irene Berezan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Author : NSObject
{
    NSUInteger _ID;
    NSString* _firstname;
    NSString* _lastname;
}

@property (nonatomic, readonly) NSUInteger ID;
@property (nonatomic, retain) NSString* firstname;
@property (nonatomic, retain) NSString* lastname;


- (id)initWithID:(NSUInteger)ID firstname:(NSString*)firstname lastname:(NSString*)lastname;
@end
