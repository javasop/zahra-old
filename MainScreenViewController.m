//
//  MainScreenViewController.m
//  MainScreenApp
//
//  Created by Igor Milakovic on 11/18/12.
//  Copyright (c) 2012 Igor Milakovic. All rights reserved.
//

#import "MainScreenViewController.h"

@interface MainScreenViewController ()

@end

@implementation MainScreenViewController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _scrollView.contentSize = CGSizeMake(640, 460);
    
    _firstContentView.frame = CGRectMake(0, 0, _firstContentView.frame.size.width, _firstContentView.frame.size.height);
    [_scrollView addSubview:_firstContentView];
    
    _secondContentView.frame = CGRectMake(320, 0, _secondContentView.frame.size.width, _secondContentView.frame.size.height);
    [_scrollView addSubview:_secondContentView];
}

#pragma mark - Public

- (IBAction)firstScreenButtonTapped:(UIButton *)sender
{
    // [[[UIAlertView alloc] initWithTitle:@"Test" message:[NSString stringWithFormat:@"First screen button %d tapped!", sender.tag] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    
    switch (sender.tag)
    {
        case 100:
            // Health Education. 
            
            break;
        case 101:
            // Action for flowers button
            break;
        case 102:
            // Action for red button
            break;
        case 103:
            // Action for purple button
            break;
        case 104:
            // Action for blue button
            break;
        case 105:
            // Action for darker green button
            break;
        case 106:
            // Action for pink button
            break;
        default:
            break;
    }
}

- (IBAction)secondScreenButtonTapped:(UIButton *)sender
{
    // [[[UIAlertView alloc] initWithTitle:@"Test" message:[NSString stringWithFormat:@"Second screen button %d tapped!", sender.tag] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    
    switch (sender.tag)
    {
        case 100:
            // Action for flowers button
            break;
        case 101:
            // Action for red button
            break;
        case 102:
            // Action for darker green button
            break;
        case 103:
            // Action for pink button
            break;
        case 104:
            // Action for gray button
            break;
        case 105:
            // Action for purple button
            break;
        default:
            break;
    }
}

- (IBAction)pageControlDidChangeValue:(UIPageControl *)sender
{
    CGRect newVisibleRect = CGRectMake(sender.currentPage * _scrollView.bounds.size.width, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height);
    
    [_scrollView scrollRectToVisible:newVisibleRect animated:YES];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = scrollView.frame.size.width;
    int pageIndex = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    _pageControl.currentPage = pageIndex;
}

#pragma mark - Memory management

- (void)viewDidUnload
{
    _scrollView = nil;
    _pageControl = nil;
    _firstContentView = nil;
    _secondContentView = nil;
    
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return NO;
}


@end
