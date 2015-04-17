//
//  Author.m
//  HealthEducationBreastCancer
//
//  Created by Irene Berezan on 14.05.12.
//  Copyright (c) 2012 Irene Berezan. All rights reserved.
//

#import "Author.h"

#import "MTSAbstractJSONModelClass.h"
@implementation Author
@synthesize ID = _ID;
@synthesize firstname = _firstname;
@synthesize lastname = _lastname;

- (id)initWithID:(NSUInteger)ID firstname:(NSString*)firstname lastname:(NSString*)lastname
{
    if (self = [super init])
    {
        _ID = ID;
        
        if (firstname && ![firstname isKindOfClass:[NSNull class]] && firstname.length)
        {
            _firstname = [[NSString alloc] initWithFormat:@"%@", firstname];
        }
        else
        {
            _firstname = [[NSString alloc] initWithFormat:@""];
        }
        
        if (lastname && ![lastname isKindOfClass:[NSNull class]] && lastname.length)
        {
            _lastname = [[NSString alloc] initWithFormat:@"%@", lastname];
        }
        else
        {
            _lastname = [[NSString alloc] initWithFormat:@""];
        }
        
    }
    return self;
}

- (void)dealloc
{
    [_firstname release];
    [_lastname release];
    
    [super dealloc];
}

@end
