
#import "DonationIntroViewController.h"
#import "DonateViewController.h"
#import "BanksTableViewController.h"


@implementation DonationIntroViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) { // if iOS 7
        self.edgesForExtendedLayout = UIRectEdgeNone; //layout adjustements
    }
    
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return NO;
}


- (IBAction)sms_donation:(id)sender {
    
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"sms:5092"]];
    
    
}
- (IBAction)bank_transfer:(id)sender {
    
    UIStoryboard *storyboard;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
            storyboard = [UIStoryboard storyboardWithName:@"BanksStoryboard_iphone" bundle:[NSBundle mainBundle]];

        
    } else
    {

                    storyboard = [UIStoryboard storyboardWithName:@"BanksStoryboard_ipad" bundle:[NSBundle mainBundle]];
        
    }
    

    
    BanksTableViewController *newView = [storyboard instantiateViewControllerWithIdentifier:@"banks_story"];
    
    
    [self.navigationController pushViewController:newView animated:YES];
    

    
}


@end
