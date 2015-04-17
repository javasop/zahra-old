//
//  HECBFAQListViewController.m
//  HealthEducationBreastCancer
//
//  Created by Irene Berezan on 10.05.12.
//  Copyright (c) 2012 Irene Berezan. All rights reserved.
//

#import "HECBFAQListViewController.h"

#import "HEBCFAQDetailsViewController.h"
#import "FAQItem.h"

static const float kFAQAskQuestionTextViewTag = 121212;

@interface HECBFAQListViewController (Private)
- (void)updateItems:(id)sender;
- (void)updateFAQView:(NSNotification*)notification;
@end

@implementation HECBFAQListViewController

@synthesize faqList = _faqList;
@synthesize questionTextView = _questionTextView;
@synthesize textViewImageBackButton = _textViewImageBackButton;


- (void)dealloc
{
    [_faqList release];
    [_questionTextView release];
    [_textViewImageBackButton release];
    
    [super dealloc];
}


#pragma -
#pragma iVars

- (NSArray*)faqList
{
    if (!_faqList)
    {
        _faqList = [[HEBCModelManager sharedHEBCModelManager].FAQList retain];
    }
    return _faqList;
}


- (FAQItem*)faqItemAtIndex:(NSUInteger)index
{
    return (FAQItem*)[self.faqList objectAtIndex:index];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImage *bg_img = [UIImage imageNamed:@"1st level.png"];
    
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:bg_img];

    
    self.questionTextView.tag = kFAQAskQuestionTextViewTag;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateFAQView:) name:kModelNotificationFAQListDidChange object:[HEBCModelManager sharedHEBCModelManager]];
    
    UIBarButtonItem* updateBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(updateItems:)];
    self.navigationItem.rightBarButtonItem = updateBarButtonItem;
    [updateBarButtonItem release];
    [self updateItems:self];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.questionTextView = nil;
    self.textViewImageBackButton = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kModelNotificationFAQListDidChange object:[HEBCModelManager sharedHEBCModelManager]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (self.questionTextView.isFirstResponder)
    {
        [self.questionTextView endEditing:YES];
    }
    
    [super viewWillDisappear:animated];
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
    return [self.faqList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    // Configure the cell...
    NSUInteger row = (NSUInteger)(indexPath.row);
    //    NSUInteger section = (NSUInteger)(indexPath.section);
    
    FAQItem * faqItem = [self faqItemAtIndex:row];
    if (faqItem.question)
    {
        cell.textLabel.text = faqItem.question;
    }
    
    if (faqItem.date)
    {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [MTSAbstractJSONModelClass dayMonthTimeStringFromDate: faqItem.date]];
    }
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.questionTextView.isFirstResponder)
    {
        [self.questionTextView endEditing:YES];
    }
    
    NSUInteger row = (NSUInteger)(indexPath.row);
    FAQItem* question = [self faqItemAtIndex:row];
                         
    HEBCFAQDetailsViewController* detailsViewController = [[HEBCFAQDetailsViewController alloc] initWithNibName:[[self class] defaultTableViewControllerNibName] bundle:[NSBundle mainBundle] question:question];

    [self.navigationController pushViewController:detailsViewController animated:YES];
    [detailsViewController release];
                         
}

#pragma -
#pragma Events

- (void)updateItems:(id)sender
{
    if (self.questionTextView.isFirstResponder)
    {
        [self.questionTextView endEditing:YES];
    }
    
    [[HEBCModelManager sharedHEBCModelManager] updateFromServer_FAQList];
}


- (IBAction)askQuestion:(id)sender
{
    if (self.questionTextView.isFirstResponder)
    {
        [self.questionTextView endEditing:YES];
    }
    if ([[self.questionTextView.text stringByTrimmingCharactersInSet:[(NSCharacterSet*)[NSCharacterSet letterCharacterSet] invertedSet]] length])
    {
        [[CBServerCommunication sharedCBServerCommunication] postQuestionWithText:self.questionTextView.text];
    }
    else
    {
        NSString* titleError = NSLocalizedString(@"Question warning", @"Question was not entered. Title");
        NSString* messageError = NSLocalizedString(@"Please, enter your question", @"Question was not entered. Message");

        UIAlertView* nilImageAlert = [[UIAlertView alloc] initWithTitle:titleError message:messageError delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"OK") otherButtonTitles:nil];
        [nilImageAlert show];
        [nilImageAlert release];
    }
}


#pragma Notifications
- (void)updateFAQView:(NSNotification*)notification
{
    [_faqList release];
    _faqList = nil;
    
    [self.tableView reloadData];
    [self.tableView reloadInputViews];
    [self.tableView setNeedsDisplay];
    [self.view setNeedsDisplay];
}


#pragma -
#pragma UITextViewDelegate


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{  
    BOOL shouldChangeText = YES;  
    
    if ((textView.tag == kFAQAskQuestionTextViewTag) && [text isEqualToString:@"\n"])
    {  
        [textView endEditing:YES];
        shouldChangeText = NO;
    }  
    
    return shouldChangeText;  
}


@end
