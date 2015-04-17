//
//  ViewController.h
//  Complete_Project
//


#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@class AHEBCViewController;
@class MangingEventVController;
@class SMViewController;
@class ZSViewController;
@class HEBCViewController;
@class HLBCViewController;
@class ContactZahrahViewController;
@class members;
@class DonationIntroViewController;
@class LamsatZaharahIntroductionViewController;
@class AboutZahrahNewViewController;
@class AppInfoViewController;

@interface ViewController : UIViewController<UIScrollViewDelegate>{
 
    
    IBOutlet UILabel *label;
    IBOutlet UIImageView *large_bright, *large_dim, *small_bright, *small_dim; 
    IBOutlet UIScrollView *_scrollView;
    IBOutlet UIPageControl *_pageControl;
    IBOutlet UIView *_firstContentView;
    IBOutlet UIView *_secondContentView;
    AppDelegate *thedelegate;

}

- (IBAction)firstScreenButtonTapped:(UIButton *)sender;
- (IBAction)secondScreenButtonTapped:(UIButton *)sender;
- (IBAction)pageControlDidChangeValue:(UIPageControl *)sender;

//@property (strong, nonatomic) IBOutlet UIView *v;
@property (strong, nonatomic) IBOutlet UILabel *label; 
//@property (strong, nonatomic) IBOutlet UIScrollView *scroll;

//
@property (strong, nonatomic) ContactZahrahViewController *c;

// 
@property (strong, nonatomic) AHEBCViewController *projOneController;


// events
@property (strong, nonatomic) MangingEventVController *projTwoController;
// store 
@property (strong, nonatomic) SMViewController *projThreeController;
// store zahrah
@property (strong, nonatomic) ZSViewController *projFourController;
// hospital list
@property (strong, nonatomic) HLBCViewController *projFiveController;

// health education
@property (strong, nonatomic) HEBCViewController *projSixController;

@property (strong, nonatomic) members *members_viewController;

@property (strong, nonatomic) DonationIntroViewController *d;

@property (strong, nonatomic) LamsatZaharahIntroductionViewController *lamsat;


@property (strong, nonatomic) AboutZahrahNewViewController *about;


@property (strong, nonatomic) AppInfoViewController *appi;


@property (nonatomic, retain) IBOutlet UIImageView *large_bright; 
@property (nonatomic, retain) IBOutlet UIImageView *large_dim;
@property (nonatomic, retain) IBOutlet UIImageView *small_bright;
@property (nonatomic, retain) IBOutlet UIImageView *small_dim; 



//Methods
- (IBAction)CallProjectOne:(id)sender;     //Project #1
- (IBAction)CallProjectTwo:(id)sender;     //Project #2
- (IBAction)CallProjectThree:(id)sender;   //Project #3
- (IBAction)CallProjectFour:(id)sender;    //Project #4
- (IBAction)CallProjectFive:(id)sender;    //Project #5
- (IBAction)CallProjectSix:(id)sender;     //Project #6
- (IBAction)PlayVideo:(id)sender;
- (IBAction)contact_us:(id)sender;
- (IBAction)memberships:(id)sender;
- (IBAction)donations:(id)sender;
- (IBAction)aboutapp:(id)sender;

@end

