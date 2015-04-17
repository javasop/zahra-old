//
//  HEBCViewController.m
//  HealthEducationBreastCancer
//
//  Created by Irene Berezan on 04.05.12.
//  Copyright (c) 2012 Irene Berezan. All rights reserved.
//

#import "HEBCViewController.h"

#import "HEBCArticlesListViewController.h"
#import "HEBCHospitalsListViewController.h"
#import "HECBFAQListViewController.h"
#import "HEBCBookletsViewController.h"
#import "HEBCBrochuresViewController.h"

@interface HEBCViewController (Private)
@end

@interface HEBCViewController (DefaultNibNames)
+ (NSString*)defaultTableViewControllerNibName;
+ (NSString*)defaultBookShelfViewControllerNibName;
+ (NSString*)FAQTableViewControllerNibName;
@end

@implementation HEBCViewController
@synthesize image_text;
@synthesize large_dim,large_bright,small_dim,small_bright;

#pragma -
#pragma iVars

+ (NSString*)defaultTableViewControllerNibName
{
    NSString* nibName = nil;
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        nibName = [NSString stringWithFormat:@"HEBCTableViewController_iPad"];
    }
    else
    {
        nibName = [NSString stringWithFormat:@"HEBCTableViewController_iPhone"];
    }

    return nibName;
}

+ (NSString*)defaultBookShelfViewControllerNibName
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

+ (NSString*)FAQTableViewControllerNibName
{
    NSString* nibName = nil;
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        nibName = [NSString stringWithFormat:@"HEBCQuestionTableViewController_iPad"];
    }
    else
    {
        nibName = [NSString stringWithFormat:@"HEBCQuestionTableViewController_iPhone"];
    }
    
    return nibName;
}


#pragma mark - View lifecycle


-(void)viewWillAppear:(BOOL)animated{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:15.0];
    [UIView setAnimationRepeatCount:20.0f];
    [UIView setAnimationRepeatAutoreverses:YES];
    CGPoint pos = large_bright.center; 
    pos.x = 400.0f;
    large_bright.center = pos;
    CGPoint pos2 = large_dim.center; 
    pos2.x = -10.0;
    large_dim.center = pos2;
    [UIView commitAnimations];
}
- (void)viewDidDisappear:(BOOL)animated {
    //reset everything when the view is dissappeared
    CGPoint pos = large_bright.center;
    pos.x = 0;
    large_bright.center = pos;
    CGPoint pos2 = large_dim.center;
    pos2.x = 0;
    large_dim.center = pos2;
    
}
-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) { // if iOS 7
        self.edgesForExtendedLayout = UIRectEdgeNone; //layout adjustements
    }
    

    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

#pragma -
#pragma Events

- (IBAction)openFAQ:(id)sender
{
    HECBFAQListViewController* faqListViewController = [[HECBFAQListViewController alloc] initWithNibName:[[self class] FAQTableViewControllerNibName] bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:faqListViewController animated:YES];
    [faqListViewController release];
}

- (IBAction)openSelfExam:(id)sender
{
    NSURL * videoURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:kVideoFileName ofType:kVideoFileType]];  
    MPMoviePlayerController * moviePlayerController = [[MPMoviePlayerController alloc] initWithContentURL:videoURL];  
    
//    [[NSNotificationCenter defaultCenter] addObserver:self  
//                                             selector:@selector(moviePlaybackStateDidChange:)  
//                                                 name:MPMoviePlayerPlaybackStateDidChangeNotification  
//                                               object:moviePlayerController];
    [[NSNotificationCenter defaultCenter] addObserver:self  
                                             selector:@selector(moviePlaybackDidFinish:)  
                                                 name:MPMoviePlayerPlaybackDidFinishReasonUserInfoKey
                                               object:moviePlayerController];  
    
    [self.view addSubview:moviePlayerController.view];
    
    moviePlayerController.fullscreen = YES;
    moviePlayerController.scalingMode = MPMovieScalingModeAspectFit;
    [moviePlayerController play]; 
}

- (IBAction)openArticles:(id)sender
{
    HEBCArticlesListViewController* articleListViewController = [[HEBCArticlesListViewController alloc] initWithNibName:[[self class] defaultTableViewControllerNibName] bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:articleListViewController animated:YES];
    [articleListViewController release];
}

- (IBAction)openLibrary:(id)sender
{
    HEBCBookletsViewController* libraryListViewController  = [[HEBCBookletsViewController alloc] initWithNibName:[[self class] defaultBookShelfViewControllerNibName]  bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:libraryListViewController animated:YES];
    [libraryListViewController release];
}

- (IBAction)openBroshures:(id)sender
{
    HEBCBrochuresViewController* libraryListViewController  = [[HEBCBrochuresViewController alloc] initWithNibName:[[self class] defaultBookShelfViewControllerNibName]  bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:libraryListViewController animated:YES];
    [libraryListViewController release];
}

- (IBAction)openHospitalsList:(id)sender
{
    HEBCHospitalsListViewController* hospitalsListViewController = [[HEBCHospitalsListViewController alloc] initWithNibName:[[self class] defaultTableViewControllerNibName] bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:hospitalsListViewController animated:YES];
    [hospitalsListViewController release];
}

#pragma -

- (void)moviePlaybackDidFinish:(NSNotification *)notification  
{  
    MPMoviePlayerController *moviePlayerController = [notification object];  
    MPMoviePlaybackState playbackState = moviePlayerController.playbackState; 
    if(playbackState == MPMoviePlaybackStateStopped)
    {
        NSLog(@"MPMoviePlaybackStateInterrupted");
        
        [[NSNotificationCenter defaultCenter] removeObserver:self  
                                                        name:MPMoviePlayerPlaybackStateDidChangeNotification  
                                                      object:moviePlayerController];
        
        [[NSNotificationCenter defaultCenter] removeObserver:self  
                                                        name:MPMoviePlayerPlaybackDidFinishReasonUserInfoKey  
                                                      object:moviePlayerController];
        [moviePlayerController.view removeFromSuperview];  
        [moviePlayerController release];
        
        NSLog(@"MPMoviePlaybackStateStopped");
    }
}

- (void)moviePlaybackStateDidChange:(NSNotification *)notification  
{  
//    MPMoviePlayerController *moviePlayerController = [notification object];  
//    MPMoviePlaybackState playbackState = moviePlayerController.playbackState;
//    if(playbackState == MPMoviePlaybackStateStopped)
//    {
//        NSLog(@"MPMoviePlaybackStateStopped");
//    } 
//    if(playbackState == MPMoviePlaybackStatePlaying) 
//    {
//        NSLog(@"MPMoviePlaybackStatePlaying");
//    } 
//    if(playbackState == MPMoviePlaybackStatePaused)
//    {
//        NSLog(@"MPMoviePlaybackStatePaused");
//    } 
//    if(playbackState == MPMoviePlaybackStateInterrupted) 
//    {
//        NSLog(@"MPMoviePlaybackStateInterrupted");
//    } 
//    if(playbackState == MPMoviePlaybackStateSeekingForward)
//    {
//        NSLog(@"MPMoviePlaybackStateSeekingForward");
//    } 
//    if(playbackState == MPMoviePlaybackStateSeekingBackward)
//    {
//        NSLog(@"MPMoviePlaybackStateSeekingBackward********");
//    }
}
- (void)viewDidUnload {
    [self setImage_text:nil];
    [super viewDidUnload];
}
@end
