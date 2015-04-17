//
//  MTSNewsDetailsViewController.m
//  MTSFunGuide
//
//  Created by iberezan on 2/14/12.
//  Copyright (c) 2012 Ирочка. All rights reserved.
//

#import "HEBCArticleDetailsViewController.h"
#import "HEBCArticleDetailsTableViewCell.h"
#import "Article.h"
#import "Author.h"
#import "HEBCModelManager.h"

#define NEWS_DETAILS_CELL_TEXT_FONT_SIZE 14.0


@implementation HEBCArticleDetailsViewController

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
    
    self.navigationController.title = self.artcle.title;
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
    CGRect screenRect = [[UIScreen mainScreen] bounds];

    CGFloat screenHeight = screenRect.size.height;
    //CGFloat rowHeight = screenHeight * 0.35;
    
    static CGFloat kCellWidthDiff = 20.0;
    static CGFloat kTextViewWidthDiff = 28.0;
    
    UIFont *cellFont = [UIFont systemFontOfSize:NEWS_DETAILS_CELL_TEXT_FONT_SIZE];
    
    CGFloat cellWidth = self.view.frame.size.width - kCellWidthDiff;
    CGFloat textViewWidth = cellWidth - kTextViewWidthDiff;
    CGSize constraintSize = CGSizeMake(textViewWidth, MAXFLOAT);
    
    NSString *cellText = self.artcle.text;
    CGSize labelSize = [cellText sizeWithFont:cellFont constrainedToSize:constraintSize];
    
    //return rowHeight + labelSize.height;
    
    return labelSize.height + (screenHeight * 0.55);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellNewsIdentifier = @"CellNewsIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellNewsIdentifier];
    if (cell == nil)
    {
        self.newsTableViewCell = [[[HEBCArticleDetailsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellNewsIdentifier] autorelease];
        [[NSBundle mainBundle] loadNibNamed:@"HEBCArticleDetailsTableViewCell" owner:self options:nil];
        [((HEBCArticleDetailsTableViewCell*)cell).fullDescriptionTextView setFont:[UIFont systemFontOfSize:14.0]];
        cell = self.newsTableViewCell;
        cell.backgroundView = nil;
        [cell setBackgroundColor:[[self class] defaultCellColor]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    ((HEBCArticleDetailsTableViewCell*)cell).titleLabel.text = self.artcle.title;
    ((HEBCArticleDetailsTableViewCell*)cell).detailInfoTextField.text = self.artcle.abstract;
    ((HEBCArticleDetailsTableViewCell*)cell).fullDescriptionTextView.text = self.artcle.text;
    ((HEBCArticleDetailsTableViewCell*)cell).dateLabel.text = [MTSAbstractJSONModelClass dayMonthTimeStringFromDate:self.artcle.date];
    
    ((HEBCArticleDetailsTableViewCell*)cell).sourceTextField.text = [NSString stringWithFormat:@"%@ %@",self.artcle.author.firstname, self.artcle.author.lastname];
    
    return cell;
}

@end
