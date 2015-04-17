//
//  MTSNewsDetailsViewController.m
//  MTSFunGuide
//
//  Created by iberezan on 2/14/12.
//  Copyright (c) 2012 Ирочка. All rights reserved.
//

#import "AHEBCArticleDetailsViewController.h"
#import "AHEBCArticleDetailsTableViewCell.h"
#import "Article.h"
#import "Author.h"
#import "HEBCModelManager.h"

#define NEWS_DETAILS_CELL_TEXT_FONT_SIZE 14.0


@implementation AHEBCArticleDetailsViewController

@synthesize artcle = _article;
@synthesize newsTableViewCell = _newsTableViewCell;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil article:(Article*)article
{
    self = [self initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _article = [article retain];
    }
    return self;
}

- (void)dealloc
{
    [_article release];
    [_newsTableViewCell release];
    
    [super dealloc];
}


#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) { // if iOS 7
        self.edgesForExtendedLayout = UIRectEdgeNone; //layout adjustements
    }
    
    self.navigationController.title = self.artcle.title;
    //self.tableView.backgroundView = nil;    
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"1st level.png"]];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.newsTableViewCell = nil;
}

#pragma -
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

// Variable height support
//
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat rowHeight = 150.0;
    
    static CGFloat kCellWidthDiff = 20.0;
    static CGFloat kTextViewWidthDiff = 28.0;
    
    UIFont *cellFont = [UIFont systemFontOfSize:NEWS_DETAILS_CELL_TEXT_FONT_SIZE];
    
    CGFloat cellWidth = self.view.frame.size.width - kCellWidthDiff;
    CGFloat textViewWidth = cellWidth - kTextViewWidthDiff;
    CGSize constraintSize = CGSizeMake(textViewWidth, MAXFLOAT);
    
    NSString *cellText = self.artcle.text;
    CGSize labelSize = [cellText sizeWithFont:cellFont constrainedToSize:constraintSize];
    
    return rowHeight + labelSize.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellNewsIdentifier = @"CellNewsIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellNewsIdentifier];
    if (cell == nil)
    {
        self.newsTableViewCell = [[[AHEBCArticleDetailsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellNewsIdentifier] autorelease];
        [[NSBundle mainBundle] loadNibNamed:@"AHEBCArticleDetailsTableViewCell" owner:self options:nil];
        [((AHEBCArticleDetailsTableViewCell*)cell).fullDescriptionTextView setFont:[UIFont systemFontOfSize:14.0]];
        cell = self.newsTableViewCell;
        cell.backgroundView = nil;
        [cell setBackgroundColor:[[self class] defaultCellColor]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    ((AHEBCArticleDetailsTableViewCell*)cell).titleLabel.text = self.artcle.title;
    ((AHEBCArticleDetailsTableViewCell*)cell).detailInfoTextField.text = self.artcle.abstract;
    ((AHEBCArticleDetailsTableViewCell*)cell).fullDescriptionTextView.text = self.artcle.text;
    ((AHEBCArticleDetailsTableViewCell*)cell).dateLabel.text = [MTSAbstractJSONModelClass dayMonthTimeStringFromDate:self.artcle.date];
    
    ((AHEBCArticleDetailsTableViewCell*)cell).sourceTextField.text = [NSString stringWithFormat:@"%@ %@",self.artcle.author.firstname, self.artcle.author.lastname];
    
    return cell;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return NO;
}


@end
