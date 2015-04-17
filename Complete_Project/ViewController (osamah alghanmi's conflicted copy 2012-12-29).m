//
//  ViewController.m
//  Complete_Project
//


#import "ViewController.h"
#import "AHEBCViewController.h"
#import "MangingEventVController.h"
#import "SMViewController.h"
#import "ZSViewController.h"
#import "HEBCViewController.h"
#import "HLBCViewController.h"
#import "CUsViewController.h"
#import "members.h"
#import "DonateViewController.h"


@interface ViewController ()

@end

@implementation ViewController

@synthesize projOneController, projTwoController, projThreeController, projFourController, projFiveController, projSixController,large_dim,large_bright,small_bright,small_dim, label,c,members_viewController,d;



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

-(void)viewDidLoad{

    
    
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
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
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
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        projTwoController = [[MangingEventVController alloc] initWithNibName:@"MangingEventVController_iPhone" bundle:nil];
    } else 
    {
        projTwoController = [[MangingEventVController alloc] initWithNibName:@"MangingEventVController_iPad" bundle:nil];
    }
    
    [self.navigationController pushViewController:projTwoController animated:YES];
}

- (IBAction)CallProjectThree:(id)sender{
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        projThreeController = [[SMViewController alloc] initWithNibName:@"SMViewController" bundle:nil];
    } else 
    {
        projThreeController = [[SMViewController alloc] initWithNibName:@"SMViewController~ipad" bundle:nil];
    }
    
    [self.navigationController pushViewController:projThreeController animated:YES];
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
        projSixController = [[HEBCViewController alloc] initWithNibName:kMainXib_HospitalsOnlyMode_iPhone bundle:nil];
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

-(IBAction)contact_us:(id)sender{
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
        c = [[CUsViewController alloc] initWithNibName:@"CUsViewController" bundle:nil];
        
       // projTwoController = [[MangingEventVController alloc] initWithNibName:@"MangingEventVController_iPhone" bundle:nil];
    } else 
    {
       // projTwoController = [[MangingEventVController alloc] initWithNibName:@"MangingEventVController_iPad" bundle:nil];
        
                c = [[CUsViewController alloc] initWithNibName:@"CUsViewController_iPad" bundle:nil];
        
    }
    
    [self.navigationController pushViewController:c animated:YES];
    
}

-(IBAction)memberships:(id)sender{

    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
        
        members_viewController = [[members alloc] initWithNibName:@"-iphone" bundle:nil];

        
        // projTwoController = [[MangingEventVController alloc] initWithNibName:@"MangingEventVController_iPhone" bundle:nil];
    } else 
    {        
        members_viewController = [[members alloc] initWithNibName:@"members" bundle:nil];
        
        
    }
    
    [self.navigationController pushViewController:members_viewController animated:YES];
    
}

- (IBAction)donations:(id)sender{

    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
        
        d = [[DonateViewController alloc] initWithNibName:@"-iphone" bundle:nil];
        
        

    } else 
    {        
       d = [[DonateViewController alloc] initWithNibName:@"DonateViewController" bundle:nil];
        
        
    }
    
    [self.navigationController pushViewController:d animated:YES];
    
}

@end
