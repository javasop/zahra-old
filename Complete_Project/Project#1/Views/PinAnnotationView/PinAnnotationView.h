//
//  PinAnnotationView.h
//  HealthEducationBreastCancer
//
//  Created by Irene Berezan on 02.06.12.
//  Copyright (c) 2012 Irene Berezan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface PinAnnotationView : NSObject <MKAnnotation>
{
@private
    NSString *_title;
    NSString * _subtitle;
    CLLocationCoordinate2D _coordinate;
}
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic) CLLocationCoordinate2D coordinate;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate;

@end
