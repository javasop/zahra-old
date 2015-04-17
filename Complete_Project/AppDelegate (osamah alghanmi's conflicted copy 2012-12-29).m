//
//  AppDelegate.m
//  Complete_Project
//


#import "AppDelegate.h"

#import "ViewController.h"
#import "HEBCModelManager.h"
#import "GlobalConsts.h"

#define isIPhone (![[UIDevice currentDevice] respondsToSelector:@selector(userInterfaceIdiom)] || [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)

@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;

//Project #2
@synthesize eventArray, selectedEvent, dateEventArray, eventSelected, ticketInfoArray, ticketSelected;

//Project #3
@synthesize mainArray,buttonSelected,cartArray,lat,lon,region,locationManager,device,orderArray,productsArray;
@synthesize fnameInfo,lnameInfo,emailInfo,phnInfo,addInfo,costInfo,paymentInfo;


//Project #2
//----To check internet network connectivity----//
- (BOOL)isNetworkAvailable
{ 
    Reachability * reachability = [Reachability reachabilityForInternetConnection];
    if ([reachability currentReachabilityStatus]  ==  NotReachable)
    {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Event Manager" 
                                                            message:@"No Network is accessible. Please connect and try again." 
                                                           delegate:nil 
                                                  cancelButtonTitle:@"OK" 
                                                  otherButtonTitles:nil];
        [alertView show];
        return NO;
    }
    return YES;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    sleep(5);
    
    /*self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.viewController = [[ViewController alloc] initWithNibName:@"ViewController_iPhone" bundle:nil];
    } else {
        self.viewController = [[ViewController alloc] initWithNibName:@"ViewController_iPad" bundle:nil];
    }
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;*/
    
    
    /*UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:kDefaultBG]];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.frame = self.window.frame;
    [self.window addSubview:imageView];*/
    
    
    //Project #2
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    dateEventArray = [[NSMutableArray alloc] init];
    //Project #2
    
    //Project #3
    if (isIPhone) {
        device = 0;
    }
    else {
        
        device = 1;
    }
    //Project #3
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        self.viewController = [[ViewController alloc] initWithNibName:@"ViewController_iPhone" bundle:nil];
    } else
    {
        self.viewController = [[ViewController alloc] initWithNibName:@"ViewController_iPad" bundle:nil];
    }
    
    UINavigationController* navigationController = [[UINavigationController alloc] initWithRootViewController:self.viewController];
    navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    
    //Project #3
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = 100;
    [self.locationManager startUpdatingLocation];
    //Project #3
    
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];

    return YES;
}

//Project #3
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation{
    
	MKCoordinateSpan span;
	span.latitudeDelta=0.2;
	span.longitudeDelta=0.2;
	
	region.span=span;
	region.center=newLocation.coordinate;

    self.lat=newLocation.coordinate.latitude;
	self.lon=newLocation.coordinate.longitude;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
