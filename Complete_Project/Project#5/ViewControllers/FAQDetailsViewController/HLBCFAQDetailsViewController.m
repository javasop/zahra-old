//
//  MTSNewsDetailsViewController.m
//  MTSFunGuide
//
//  Created by iberezan on 2/14/12.
//  Copyright (c) 2012 Ирочка. All rights reserved.
//

#import "HLBCFAQDetailsViewController.h"
#import "HLBCArticleDetailsTableViewCell.h"
#import "FAQItem.h"
#import "HEBCModelManager.h"

#define NEWS_DETAILS_CELL_TEXT_FONT_SIZE 14.0


@implementation HLBCFAQDetailsViewController

@synthesize question = _question;
@synthesize newsTableViewCell = _newsTableViewCell;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil question:(FAQItem*)question
{
    self = [self initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _question = [question retain];
    }
    return self;
}

- (void)dealloc
{
    [_question release];
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
    
    self.navigationController.title = self.question.question;
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
    
    NSString *cellText = self.question.content;
    CGSize labelSize = [cellText sizeWithFont:cellFont constrainedToSize:constraintSize];
    
    return rowHeight + labelSize.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellFAQDetailsIdentifier = @"CellFAQDetailsIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellFAQDetailsIdentifier];
    if (cell == nil)
    {
        self.newsTableViewCell = [[[HLBCArticleDetailsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellFAQDetailsIdentifier] autorelease];
        [[NSBundle mainBundle] loadNibNamed:@"HLBCArticleDetailsTableViewCell" owner:self options:nil];
        [((HLBCArticleDetailsTableViewCell*)cell).fullDescriptionTextView setFont:[UIFont systemFontOfSize:14.0]];
        cell = self.newsTableViewCell;
        cell.backgroundView = nil;
        [cell setBackgroundColor:[[self class] defaultCellColor]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    ((HLBCArticleDetailsTableViewCell*)cell).titleLabel.text = self.question.question;
    ((HLBCArticleDetailsTableViewCell*)cell).fullDescriptionTextView.text = self.question.content;
    ((HLBCArticleDetailsTableViewCell*)cell).dateLabel.text = [MTSAbstractJSONModelClass dayMonthTimeStringFromDate:self.question.date];
    
    return cell;
}

@end
