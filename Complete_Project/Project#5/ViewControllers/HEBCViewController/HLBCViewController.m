//
//  HEBCViewController.m
//  HealthEducationBreastCancer
//
//  Created by Irene Berezan on 04.05.12.
//  Copyright (c) 2012 Irene Berezan. All rights reserved.
//

#import "HLBCViewController.h"

#import "HLBCArticlesListViewController.h"
#import "HLBCHospitalsListViewController.h"
#import "HLCBFAQListViewController.h"
#import "HLBCBookletsViewController.h"
#import "HLBCBrochuresViewController.h"

@interface HLBCViewController (Private)
@end

@interface HLBCViewController (DefaultNibNames)
+ (NSString*)defaultTableViewControllerNibName;
+ (NSString*)defaultBookShelfViewControllerNibName;
+ (NSString*)FAQTableViewControllerNibName;
@end

@implementation HLBCViewController

-(void)viewDidLoad{
    
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) { // if iOS 7
        self.edgesForExtendedLayout = UIRectEdgeNone; //layout adjustements
    }

    
}

#pragma -
#pragma iVars

+ (NSString*)defaultTableViewControllerNibName
{
    NSString* nibName = nil;
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        nibName = [NSString stringWithFormat:@"HLBCTableViewController_iPad"];
    }
    else
    {
        nibName = [NSString stringWithFormat:@"HLBCTableViewController_iPhone"];
    }

    return nibName;
}

+ (NSString*)defaultBookShelfViewControllerNibName
{
    NSString* nibName = nil;
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        nibName = [NSString stringWithFormat:@"HLBCBookViewController_iPad"];
    }
    else
    {
        nibName = [NSString stringWithFormat:@"HLBCBookViewController_iPhone"];
    }
    
    return nibName;
}

+ (NSString*)FAQTableViewControllerNibName
{
    NSString* nibName = nil;
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        nibName = [NSString stringWithFormat:@"HLBCQuestionTableViewController_iPad"];
    }
    else
    {
        nibName = [NSString stringWithFormat:@"HLBCQuestionTableViewController_iPhone"];
    }
    
    return nibName;
}


#pragma mark - View lifecycle


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

#pragma -
#pragma Events

- (IBAction)openFAQ:(id)sender
{
    HLCBFAQListViewController* faqListViewController = [[HLCBFAQListViewController alloc] initWithNibName:[[self class] FAQTableViewControllerNibName] bundle:[NSBundle mainBundle]];
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
    HLBCArticlesListViewController* articleListViewController = [[HLBCArticlesListViewController alloc] initWithNibName:[[self class] defaultTableViewControllerNibName] bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:articleListViewController animated:YES];
    [articleListViewController release];
}

- (IBAction)openLibrary:(id)sender
{
    HLBCBookletsViewController* libraryListViewController  = [[HLBCBookletsViewController alloc] initWithNibName:[[self class] defaultBookShelfViewControllerNibName]  bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:libraryListViewController animated:YES];
    [libraryListViewController release];
}

- (IBAction)openBroshures:(id)sender
{
    HLBCBrochuresViewController* libraryListViewController  = [[HLBCBrochuresViewController alloc] initWithNibName:[[self class] defaultBookShelfViewControllerNibName]  bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:libraryListViewController animated:YES];
    [libraryListViewController release];
}

- (IBAction)openHospitalsList:(id)sender
{
    HLBCHospitalsListViewController* hospitalsListViewController = [[HLBCHospitalsListViewController alloc] initWithNibName:[[self class] defaultTableViewControllerNibName] bundle:[NSBundle mainBundle]];
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
@end
