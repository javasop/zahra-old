//
//  HEBCBookShelfViewController.h
//  HealthEducationBreastCancer
//
//  Created by Irene Berezan on 10.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AHEBCBookShelfViewController.h"

#import "MyCellView.h"
#import "MyBookView.h"
#import "MyBelowBottomView.h"


#import "Book.h"
#import "HEBCModelManager.h"

@interface AHEBCBookShelfViewController (Private)
- (void)updateLibraryView:(NSNotification*)notification;
@end


@implementation AHEBCBookShelfViewController

+ (NSString*)defaultDetailsViewControllerNibName
{
    NSString* nibName = nil;
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        nibName = [NSString stringWithFormat:@"HEBCBookViewController_iPad"];
    }
    else
    {
        nibName = [NSString stringWithFormat:@"HEBCBookViewController_iPhone"];
    }
    
    return nibName;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}


- (NSArray*)bookArray
{
    return [NSArray array];
}

- (Book*)bookForIndex:(NSUInteger)index
{
    Book * book = (Book*)[[self bookArray] objectAtIndex:index];
    return book;
}


- (void)initBooks {
    NSInteger numberOfBooks = [[self bookArray] count];
    _bookArray = [[NSMutableArray alloc] initWithCapacity:numberOfBooks];
    _bookStatus = [[NSMutableArray alloc] initWithCapacity:numberOfBooks];
    for (int i = 0; i < numberOfBooks; i++) {
        NSNumber *number = [NSNumber numberWithInt:i];
        [_bookArray addObject:number];
        [_bookStatus addObject:[NSNumber numberWithInt:AHBOOK_UNSELECTED]];
    }
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	[self initBooks];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) { // if iOS 7
        self.edgesForExtendedLayout = UIRectEdgeNone; //layout adjustements
    }
    
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    CGFloat width = MIN(self.view.frame.size.width, self.view.frame.size.height);
    CGFloat height = MAX(self.view.frame.size.width, self.view.frame.size.height);
    
    CGRect bookShelfViewFrame = CGRectZero;
    if (UIDeviceOrientationIsLandscape(orientation)) {
        bookShelfViewFrame = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, height, width);
    }
    else {
        bookShelfViewFrame = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, width, height);
    }
    _bookShelfView = [[GSBookShelfView alloc] initWithFrame:bookShelfViewFrame];
    
    [_bookShelfView setDataSource:self];
    //[_bookShelfView setShelfViewDelegate:self];
    
    [self.view addSubview:_bookShelfView];
    
    
    UIBarButtonItem* updateBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(updateItems:)];
    self.navigationItem.rightBarButtonItem = updateBarButtonItem;
    
    [self updateItems:self];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    if (_bookShelfView.dataSource == self)
    {
        _bookShelfView.dataSource = nil;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return NO;
}


- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    CGFloat width = MIN(self.view.frame.size.width, self.view.frame.size.height);
    CGFloat height = MAX(self.view.frame.size.width, self.view.frame.size.height);
    if (UIDeviceOrientationIsLandscape(orientation)) {
        [_bookShelfView setFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, height, width)];
    }
    else {
        [_bookShelfView setFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, width, height)];
    }

    [_bookShelfView reloadData];
}

#pragma mark GSBookShelfViewDataSource

- (NSInteger)numberOfBooksInBookShelfView:(GSBookShelfView *)bookShelfView {
    return [_bookArray count];
}

- (NSInteger)numberOFBooksInCellOfBookShelfView:(GSBookShelfView *)bookShelfView
{
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
        if (UIDeviceOrientationIsLandscape(orientation)) {
            return 4;
        }
        else {
            return 3;
        }
        
    }
    else
    {
        UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
        if (UIDeviceOrientationIsLandscape(orientation)) {
            return 4;
        }
        else {
            return 3;
        }
        
    }
    return 1;
}

- (UIView *)bookShelfView:(GSBookShelfView *)bookShelfView bookViewAtIndex:(NSInteger)index {
    static NSString *identifier = @"bookView";
    MyBookView *bookView = (MyBookView *)[bookShelfView dequeueReuseableBookViewWithIdentifier:identifier];
    if (bookView == nil) {
        bookView = [[MyBookView alloc] initWithFrame:CGRectZero];
        bookView.reuseIdentifier = identifier;
        [bookView addTarget:self action:@selector(bookViewClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    [bookView setIndex:index];
    [bookView setSelected:[(NSNumber *)[_bookStatus objectAtIndex:index] intValue]];
    
    Book * book = [self bookForIndex:index];
    
    UIImage* cover = nil;
    if (book.coverURL)
    {
        NSArray *documentsPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString* filaPath = [[documentsPaths objectAtIndex:0]
                              stringByAppendingPathComponent:[book.coverURL lastPathComponent]];
        
        NSLock* lock = [[NSLock alloc] init];
        [lock lock];
        {
            NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:book.coverURL]];
            [data writeToFile:filaPath atomically:YES];
        }
        [lock unlock];
        
        cover = [UIImage imageWithContentsOfFile:filaPath];
        
    }
    if (cover)
    {
        [bookView setBackgroundImage:cover forState:UIControlStateNormal];
    }
    else
    {
        [bookView setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"book.png"]] forState:UIControlStateNormal];
        
    }
    
    bookView.imageView.contentMode = UIViewContentModeScaleAspectFill;
//    CGFloat k = self.view.frame.size.width / 320;
//    CGFloat bookWidth = bookView.imageView.image.size.width * k;
//    CGFloat bookHeight = bookView.imageView.image.size.height * k;
//    CGRect frame = bookView.frame;
//    bookView.frame = CGRectMake(frame.origin.x * k, frame.origin.y * k, frame.size.width * k, frame.size.height * k);
    return bookView;
}

- (UIView *)bookShelfView:(GSBookShelfView *)bookShelfView cellForRow:(NSInteger)row {
    static NSString *identifier = @"cell";
    MyCellView *cellView = (MyCellView *)[bookShelfView dequeueReuseableCellViewWithIdentifier:identifier];
    if (cellView == nil) {
        cellView = [[MyCellView alloc] initWithFrame:CGRectZero];
        cellView.reuseIdentifier = identifier;
    }
    return cellView;
}

- (CGFloat)k
{
    return self.view.frame.size.width / 320;
}

- (UIView *)aboveTopViewOfBookShelfView:(GSBookShelfView *)bookShelfView {
    return nil;
}

- (UIView *)belowBottomViewOfBookShelfView:(GSBookShelfView *)bookShelfView {
    return nil;
}

- (UIView *)headerViewOfBookShelfView:(GSBookShelfView *)bookShelfView {
    return nil;
}

- (CGFloat)cellHeightOfBookShelfView:(GSBookShelfView *)bookShelfView {
    return self.view.frame.size.width * 125 / 320;
}

- (CGFloat)cellMarginOfBookShelfView:(GSBookShelfView *)bookShelfView {
    
    return 20.0f * [self k];
}

- (CGFloat)bookViewHeightOfBookShelfView:(GSBookShelfView *)bookShelfView {
    return 88.0f * [self k];
}

- (CGFloat)bookViewWidthOfBookShelfView:(GSBookShelfView *)bookShelfView {
    return 74.0f * [self k];
}

- (CGFloat)bookViewBottomOffsetOfBookShelfView:(GSBookShelfView *)bookShelfView {
    return 110.0f * [self k];
}

- (CGFloat)cellShadowHeightOfBookShelfView:(GSBookShelfView *)bookShelfView {
    return 2.0f * [self k];
}



#pragma mark - BookView Listener

- (void)bookViewClicked:(UIButton *)button
{
    MyBookView *bookView = (MyBookView *)button;
    NSUInteger index = bookView.index;
    
    Book * book = [self bookForIndex:index];
    
    NSArray *documentsPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* filaPath = [[documentsPaths objectAtIndex:0]
                          stringByAppendingPathComponent:[book.textURL lastPathComponent]];
    
    NSLock* lock = [[NSLock alloc] init];
    [lock lock];
    {
        NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:book.textURL]];
        [data writeToFile:filaPath atomically:YES];
    }
    [lock unlock];
    
    
    ReaderDocument *document = [ReaderDocument withDocumentFilePath:filaPath password:nil];
    
	if (document != nil) // Must have a valid ReaderDocument object in order to proceed with things
	{
		ReaderViewController *readerViewController = [[ReaderViewController alloc] initWithReaderDocument:document];
        
		readerViewController.delegate = self; // Set the ReaderViewController delegate to self
        
        
		[self.navigationController pushViewController:readerViewController animated:YES];
        
	}
    [bookView setSelected:NO];
}

#pragma -
#pragma Update Events

- (void)updateItems:(id)sender
{
}


#pragma Notifications
- (void)updateLibraryView:(NSNotification*)notification
{
    _bookArray = nil;
    _bookStatus = nil;
    
    [self initBooks];
    [_bookShelfView reloadData];
}

- (void)dismissReaderViewController:(ReaderViewController *)viewController
{
    [self.navigationController popViewControllerAnimated:YES];
}




@end
