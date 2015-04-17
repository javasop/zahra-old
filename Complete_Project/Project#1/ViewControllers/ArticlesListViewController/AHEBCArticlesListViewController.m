//
//  HEBCArticlesListViewController.m
//  HealthEducationBreastCancer
//
//  Created by Irene Berezan on 10.05.12.
//  Copyright (c) 2012 Irene Berezan. All rights reserved.
//

#import "AHEBCArticlesListViewController.h"

#import "Article.h"
#import "AHEBCArticleDetailsViewController.h"


@interface AHEBCArticlesListViewController (Private)
- (void)updateItems:(id)sender;
- (void)updateArticleView:(NSNotification*)notification;
@end

@implementation AHEBCArticlesListViewController


@synthesize articlesList = _articlesList;


- (void)dealloc
{
    [_articlesList release];
    [super dealloc];
}

#pragma -
#pragma iVars

- (NSArray*)articlesList
{
    if (!_articlesList)
    {
        _articlesList = [[HEBCModelManager sharedHEBCModelManager].storiesList retain];
    }
    return _articlesList;
}


- (Article*)articleAtIndex:(NSUInteger)index
{
    return (Article*)[self.articlesList objectAtIndex:index];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) { // if iOS 7
        self.edgesForExtendedLayout = UIRectEdgeNone; //layout adjustements
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateArticleView:) name:kModelNotificationStoriesListDidChange object:[HEBCModelManager sharedHEBCModelManager]];
    
    UIBarButtonItem* updateBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(updateItems:)];
    self.navigationItem.rightBarButtonItem = updateBarButtonItem;
    [updateBarButtonItem release];
    
    [self updateItems:self];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kModelNotificationStoriesListDidChange object:[HEBCModelManager sharedHEBCModelManager]];
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
    return [self.articlesList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    // Configure the cell...
    NSUInteger row = (NSUInteger)(indexPath.row);
    //    NSUInteger section = (NSUInteger)(indexPath.section);
    
    Article* article = [self articleAtIndex:row];
    
    cell.textLabel.text = article.title;
    cell.textLabel.numberOfLines = article_title_row_count;
    [cell.textLabel sizeToFit];
    
    cell.detailTextLabel.text = article.abstract;
    cell.detailTextLabel.numberOfLines = article_abstract_row_count;
    [cell.detailTextLabel sizeToFit];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 22.0 * (article_title_row_count + article_abstract_row_count);
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = (NSUInteger)(indexPath.row);
    Article* article = [self articleAtIndex:row];
    
    AHEBCArticleDetailsViewController* detailsViewController = [[AHEBCArticleDetailsViewController alloc] initWithNibName:[[self class] defaultTableViewControllerNibName] bundle:[NSBundle mainBundle] article:article];
    
    [self.navigationController pushViewController:detailsViewController animated:YES];
    [detailsViewController release];
}

#pragma -
#pragma Events
- (void)updateItems:(id)sender
{
    [[HEBCModelManager sharedHEBCModelManager] updateFromServer_StoriesList];
}
#pragma Notifications
- (void)updateArticleView:(NSNotification*)notification
{
    [_articlesList release];
    _articlesList = nil;
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
