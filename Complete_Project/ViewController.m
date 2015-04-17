//
//  ViewController.m
//  Complete_Project
//

#import "AboutZahrahNewViewController.h"
#import "ViewController.h"
#import "AHEBCViewController.h"
#import "MangingEventVController.h"
#import "SMViewController.h"
#import "ZSViewController.h"
#import "HEBCViewController.h"
#import "HLBCViewController.h"
#import "members.h"
#import "DonationIntroViewController.h"
#import "ContactZahrahViewController.h"
#import "LamsatZaharahIntroductionViewController.h"
#import "AppInfoViewController.h"
#import "EventTableViewController.h"





@interface ViewController ()

@end

@implementation ViewController

@synthesize projOneController, projTwoController, projThreeController, projFourController, projFiveController, projSixController,large_dim,large_bright,small_bright,small_dim, label,c,members_viewController,d,lamsat,about,appi;



- (void)viewDidAppear:(BOOL)animated{
    
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


-(void)viewWillAppear:(BOOL)animated{
        

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
    
    
    thedelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    thedelegate.isNetworkAvailable;
  
    _scrollView.contentSize = CGSizeMake(640, 460);
    
    _firstContentView.frame = CGRectMake(0, 0, _firstContentView.frame.size.width, _firstContentView.frame.size.height);
    [_scrollView addSubview:_firstContentView];
    
    _secondContentView.frame = CGRectMake(320, 0, _secondContentView.frame.size.width, _secondContentView.frame.size.height);
    [_scrollView addSubview:_secondContentView];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return NO;
}


#pragma mark - Public

- (IBAction)firstScreenButtonTapped:(UIButton *)sender
{
    // [[[UIAlertView alloc] initWithTitle:@"Test" message:[NSString stringWithFormat:@"First screen button %d tapped!", sender.tag] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    
    switch (sender.tag)
    {
        case 100:
            // Action for light green button
            // [self CallProjectOne:nil];
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

- (IBAction)CallProjectOne:(id)sender{
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        projOneController = [[AHEBCViewController alloc] initWithNibName:kMainXib_AmalGroupOffMode_iPhone bundle:nil];
    } else
    {
        projOneController = [[AHEBCViewController alloc] initWithNibName:kMainXib_AmalGroupOffMode_iPad bundle:nil];
    }

    [self.navigationController pushViewController:projOneController animated:YES];
}

- (IBAction)CallProjectTwo:(id)sender{
    
    UIStoryboard *storyboard;
    
    storyboard = [UIStoryboard storyboardWithName:@"EventsStoryboard_ipad" bundle:[NSBundle mainBundle]];
    
    EventTableViewController *newView = [storyboard instantiateViewControllerWithIdentifier:@"event_story"];
    
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        projTwoController = [[MangingEventVController alloc] initWithNibName:@"MangingEventVController_iPhone" bundle:nil];
        [self.navigationController pushViewController:projTwoController animated:YES];

    } else
    {
        [self.navigationController pushViewController:newView animated:YES];

    }
    
}

- (IBAction)CallProjectThree:(id)sender{
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {

        
                        lamsat = [[LamsatZaharahIntroductionViewController alloc] initWithNibName:@"LamsatZahrahViewControllerIphone" bundle:nil];
        //projThreeController = [[SMViewController alloc] initWithNibName:@"SMViewController" bundle:nil];
    } else {
        
        // push the same view but for iPad. 
                                lamsat = [[LamsatZaharahIntroductionViewController alloc] initWithNibName:@"LamsatZaharahIntroductionViewController" bundle:nil];
        

    }
    
    [self.navigationController pushViewController:lamsat animated:YES];
}

- (IBAction)CallProjectFour:(id)sender{
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        projFourController = [[ZSViewController alloc] initWithNibName:@"ZSViewController" bundle:nil];
    } else 
    {
        projFourController = [[ZSViewController alloc] initWithNibName:@"ZSViewController~ipad" bundle:nil];
    }
    
    [self.navigationController pushViewController:projFourController animated:YES];
    
}

- (IBAction)CallProjectFive:(id)sender{
    /*
   if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        projFiveController = [[HLBCViewController alloc] initWithNibName:kMainXib_HospitalsOnlyMode_iPhone bundle:nil];
    } else 
    {
       projFiveController = [[HLBCViewController alloc] initWithNibName:kMainXib_HospitalsOnlyMode_iPad bundle:nil];
    }
    
   NSLog(@"Hospitals list is clicked. ");
    
    [self.navigationController pushViewController:projFiveController animated:YES];
     */
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        projSixController = [[HEBCViewController alloc] initWithNibName:@"HEBCViewController_HospitalsOnlyMode_iPhone" bundle:nil];
    } else 
    {
        projSixController = [[HEBCViewController alloc] initWithNibName:kMainXib_HospitalsOnlyMode_iPad bundle:nil];
    }
    
    [self.navigationController pushViewController:projSixController animated:YES];
    

    
}

- (IBAction)CallProjectSix:(id)sender{
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        projSixController = [[HEBCViewController alloc] initWithNibName:kMainXib_EducationOffMode_iPhone bundle:nil];
    } else 
    {
        projSixController = [[HEBCViewController alloc] initWithNibName:kMainXib_EducationOffMode_iPad bundle:nil];
    }
    
    [self.navigationController pushViewController:projSixController animated:YES];
}

- (IBAction)PlayVideo:(id)sender{
    
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        
        about = [[AboutZahrahNewViewController alloc] initWithNibName:@"AboutZahrahNewViewController" bundle:nil];
        
            } else {
                about = [[AboutZahrahNewViewController alloc] initWithNibName:@"AboutZahrahNewViewControllerIphone" bundle:nil]; 
                    }
    [self.navigationController pushViewController:about animated:YES];
    
    /*
    NSURL * videoURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:kVideoFileName ofType:kVideoFileType]];  
    MPMoviePlayerController * moviePlayerController = [[MPMoviePlayerController alloc] initWithContentURL:videoURL];  
    

    [[NSNotificationCenter defaultCenter] addObserver:self  
                                             selector:@selector(moviePlaybackDidFinish:)  
                                                 name:MPMoviePlayerPlaybackDidFinishReasonUserInfoKey
                                               object:moviePlayerController];  
    
    [self.view addSubview:moviePlayerController.view];
    
    moviePlayerController.fullscreen = YES;
    moviePlayerController.scalingMode = MPMovieScalingModeAspectFit;
    [moviePlayerController play]; 
     */
}

-(IBAction)contact_us:(id)sender{
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
      c = [[ContactZahrahViewController alloc] initWithNibName:@"ContactZahrahViewController_iphone" bundle:nil];
        
        //c = [[ContactZahrahViewController alloc] initWithNibName:@"-iPhone" bundle:nil];

    } else 
    {

                c = [[ContactZahrahViewController alloc] initWithNibName:@"ContactZahrahViewController" bundle:nil];
        
    }
    
    [self.navigationController pushViewController:c animated:YES];
    
}

-(IBAction)memberships:(id)sender{

    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
        
        members_viewController = [[members alloc] initWithNibName:@"members_iPhone" bundle:nil];

        
        // projTwoController = [[MangingEventVController alloc] initWithNibName:@"MangingEventVController_iPhone" bundle:nil];
    } else 
    {        
        members_viewController = [[members alloc] initWithNibName:@"members" bundle:nil];
        
        
    }
    
    [self.navigationController pushViewController:members_viewController animated:YES];
    
}

- (IBAction)donations:(id)sender{

    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
        
        d = [[DonationIntroViewController alloc] initWithNibName:@"DonationIntroViewController_iphone" bundle:nil];
        
        

    } else 
    {        
       d = [[DonationIntroViewController alloc] initWithNibName:@"DonationIntroViewController" bundle:nil];
        
    }
    
    [self.navigationController pushViewController:d animated:YES];
    
}

- (IBAction)aboutapp:(id)sender {
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
        
        appi = [[AppInfoViewController alloc] initWithNibName:@"AppInfoViewController_iPhone" bundle:nil];
        
        
        
    } else
    {
        appi = [[AppInfoViewController alloc] initWithNibName:@"AppInfoViewController" bundle:nil];
        
    }
    
    [self.navigationController pushViewController:appi animated:YES];
}



@end
