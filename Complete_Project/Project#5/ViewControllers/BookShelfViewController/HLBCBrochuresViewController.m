//
//  HEBCBrochuresViewController.m
//  HealthEducationBreastCancer
//
//  Created by MacAir on 02.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HLBCBrochuresViewController.h"
#import "HEBCModelManager.h"

@implementation HLBCBrochuresViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) { // if iOS 7
        self.edgesForExtendedLayout = UIRectEdgeNone; //layout adjustements
    }

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLibraryView:) name:kModelNotificationBrochuresListDidChange object:[HEBCModelManager sharedHEBCModelManager]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:kModelNotificationBrochuresListDidChange object:[HEBCModelManager sharedHEBCModelManager]];
}

#pragma -
#pragma Update Events
- (NSArray*)bookArray
{
    return [HEBCModelManager sharedHEBCModelManager].brochuresList;
}

- (void)updateItems:(id)sender
{
    [super updateItems:sender];
    [[HEBCModelManager sharedHEBCModelManager] updateFromServer_brochuresList];
}

@end
