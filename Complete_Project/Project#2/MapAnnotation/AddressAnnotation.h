//
//  AddressAnnotation.h
//  FindMyCar
//
//  Created by Apple on 26/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MapKit/MapKit.h"
@interface AddressAnnotation : NSObject<MKAnnotation> {
    CLLocationCoordinate2D coordinate;
    NSString *mTitle;
    NSString *mSubTitle;
}

@property(nonatomic,readonly)CLLocationCoordinate2D coordinate;
@property(nonatomic,retain)NSString * mTitle;
@property(nonatomic,retain)NSString * mSubTitle;
-(id)initWithCoordinate:(CLLocationCoordinate2D) c title:(NSString *) t subTitle:(NSString *) st;
-(id)initWithCoordinate:(CLLocationCoordinate2D)c;
-(void) moveAnnotation:(CLLocationCoordinate2D) newCoordinate;
-(NSString *) subtitle;
-(NSString *) title;
@end

