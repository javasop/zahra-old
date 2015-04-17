//
//  HEBCHospitalsListViewController.h
//  HealthEducationBreastCancer
//
//  Created by Irene Berezan on 10.05.12.
//  Copyright (c) 2012 Irene Berezan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HEBCModelManager.h"
#import "AHEBCAbstractTableView.h"

@interface AHEBCHospitalsListViewController : AHEBCAbstractTableView
{
    NSArray* _hospitalsList;
}

@property (nonatomic, retain, readonly) NSArray* hospitalsList;

@end
