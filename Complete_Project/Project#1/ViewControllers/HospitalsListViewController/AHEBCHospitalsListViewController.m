//
//  HEBCHospitalsListViewController.m
//  HealthEducationBreastCancer
//
//  Created by Irene Berezan on 10.05.12.
//  Copyright (c) 2012 Irene Berezan. All rights reserved.
//

#import "AHEBCHospitalsListViewController.h"
#import "Hospital.h"
#import "AHEBCHospitalDetailsMapViewController.h"

@interface AHEBCHospitalsListViewController (Private)
- (void)updateItems:(id)sender;
- (void)updateHospitalsView:(NSNotification*)notification;
@end

@implementation AHEBCHospitalsListViewController

@synthesize hospitalsList = _hospitalsList;

+ (NSString*)defaultDetailsViewControllerNibName
{
    NSString* nibName = nil;
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        nibName = [NSString stringWithFormat:@"AHEBCMapViewController_iPad"];
    }
    else
    {
        nibName = [NSString stringWithFormat:@"AHEBCMapViewController_iPhone"];
    }
    
    return nibName;
}

#pragma -

- (void)dealloc
{
    [_hospitalsList release];
    [super dealloc];
}


#pragma -
#pragma iVars

- (NSArray*)hospitalsList
{
    if (!_hospitalsList)
    {
        _hospitalsList = [[HEBCModelManager sharedHEBCModelManager].hospitalsList retain];
    }
    return _hospitalsList;
}


- (Hospital*)hospitalAtIndex:(NSUInteger)index
{
    return (Hospital*)[self.hospitalsList objectAtIndex:index];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) { // if iOS 7
        self.edgesForExtendedLayout = UIRectEdgeNone; //layout adjustements
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateHospitalsView:) name:kModelNotificationHospitalsListDidChange object:[HEBCModelManager sharedHEBCModelManager]];
    
    UIBarButtonItem* updateBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(updateItems:)];
    self.navigationItem.rightBarButtonItem = updateBarButtonItem;
    [updateBarButtonItem release];
    
    [self updateItems:self];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kModelNotificationHospitalsListDidChange object:[HEBCModelManager sharedHEBCModelManager]];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.hospitalsList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    // Configure the cell...
    NSUInteger row = (NSUInteger)(indexPath.row);
    //    NSUInteger section = (NSUInteger)(indexPath.section);
    
    Hospital* hospital = [self hospitalAtIndex:row];
    
    cell.textLabel.text = hospital.name;
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@: %d %%", NSLocalizedString(@"Discount", @"Discount"), hospital.discount];
    
    return cell;
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = (NSUInteger)(indexPath.row);
    Hospital* hospital = [self hospitalAtIndex:row];
    
    AHEBCHospitalDetailsMapViewController* mapViewController = [[AHEBCHospitalDetailsMapViewController alloc] initWithNibName:[[self class] defaultDetailsViewControllerNibName] bundle:[NSBundle mainBundle] hospital:hospital];
    
    [self.navigationController pushViewController:mapViewController animated:YES];
    [mapViewController release];
}

#pragma -
#pragma Events

- (void)updateItems:(id)sender
{
    [[HEBCModelManager sharedHEBCModelManager] updateFromServer_hospitalsList];
}

#pragma Notifications
- (void)updateHospitalsView:(NSNotification*)notification
{
    [_hospitalsList release];
    _hospitalsList = nil;
    
    [self.tableView reloadData];
    [self.tableView reloadInputViews];
    [self.tableView setNeedsDisplay];
    [self.view setNeedsDisplay];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return NO;
}



@end
