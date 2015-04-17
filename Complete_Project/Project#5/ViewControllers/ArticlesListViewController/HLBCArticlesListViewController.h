//
//  HEBCArticlesListViewController.h
//  HealthEducationBreastCancer
//
//  Created by Irene Berezan on 10.05.12.
//  Copyright (c) 2012 Irene Berezan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HEBCModelManager.h"
#import "HLBCAbstractTableView.h"

static const NSUInteger article_title_row_count = 2;
static const NSUInteger article_abstract_row_count = 2;

@interface HLBCArticlesListViewController : HLBCAbstractTableView
{
    NSArray* _articlesList;
}

@property (nonatomic, retain, readonly) NSArray* articlesList;
@end
