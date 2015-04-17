//
//  HEBCBookletsViewController.m
//  HealthEducationBreastCancer
//
//  Created by MacAir on 02.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AHEBCBookletsViewController.h"
#import "HEBCModelManager.h"

@implementation AHEBCBookletsViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) { // if iOS 7
        self.edgesForExtendedLayout = UIRectEdgeNone; //layout adjustements
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLibraryView:) name:kModelNotificationBookletsListDidChange object:[HEBCModelManager sharedHEBCModelManager]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kModelNotificationBookletsListDidChange object:[HEBCModelManager sharedHEBCModelManager]];
}

#pragma -
#pragma Update Events
- (NSArray*)bookArray
{
    return [HEBCModelManager sharedHEBCModelManager].bookletsList;
}

- (void)updateItems:(id)sender
{
    [super updateItems:sender];
    [[HEBCModelManager sharedHEBCModelManager] updateFromServer_bookletsList];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return NO;
}

@end
