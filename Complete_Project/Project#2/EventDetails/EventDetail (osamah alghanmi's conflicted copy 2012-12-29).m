//
//  EventDetail.m
//  ManagingEvents
//
//  Created by ankit on 21/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EventDetail.h"

@implementation EventDetail
int selEventCount;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    thedelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [self.navigationItem setTitle:thedelegate.selectedEvent];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    barBtn = [[UIBarButtonItem alloc] initWithTitle:@"Booking" style:UIBarButtonItemStylePlain target:self action:@selector(booking:)];
    [self.navigationItem setRightBarButtonItem:barBtn];
    
    mapView.hidden = YES;
    fullScreenBtn.hidden = YES;
    placeLblHolder.hidden = YES;
    priceLblHolder.hidden = YES;
    dateTimeLblHolder.hidden = YES;
    eventDescTxtViewHolder.hidden = YES;
    
    [loadingView setHidden:NO];
    carouselCheck = 1;
    
    carousel = [[iCarousel alloc] init];
   //carousel = [[iCarousel alloc] init];
  
}

- (void) viewWillAppear:(BOOL)animated
{
    //to display the particular event selected from the table at the centre of the carousel
    //[carousel scrollToItemAtIndex:selEventCount animated:YES];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    if (thedelegate.isNetworkAvailable)
    {
        mapView.hidden = NO;
        fullScreenBtn.hidden = NO;
        placeLblHolder.hidden = NO;
        priceLblHolder.hidden = NO;
        dateTimeLblHolder.hidden = NO;
        eventDescTxtViewHolder.hidden = NO;
        
        //for the event images
        
        NSMutableArray *imgArray = [[NSMutableArray alloc] init];
        imgArray = [[thedelegate.eventArray objectAtIndex:thedelegate.eventSelected] objectForKey:@"event_images"];
        NSLog(@"imgArray : %@",imgArray);

        if (carouselCheck == 1)
        {
            // Initialize and configure the carousel
            items = [[NSMutableArray alloc] init];
    
            if ([imgArray count] > 0)
            {
                for (int i = 0; i < [imgArray count]; i++)
                {
                    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) 
                    {
                        imageURL=[NSURL URLWithString:[imgArray objectAtIndex:i]];
                        imageData = [NSData dataWithContentsOfURL:imageURL];  
                        tempImage = [self resizeImage:[UIImage imageWithData:imageData] width:600 height:500];
            
                        [items addObject:tempImage];
                        //[items addObject:[UIImage imageWithData:imageData]];
                    }
                    else
                    {  
                        imageURL=[NSURL URLWithString:[imgArray objectAtIndex:i]];
                        imageData = [NSData dataWithContentsOfURL:imageURL];        
                        [items addObject:[UIImage imageWithData:imageData]];
                    }
                }
            }
            else
            {
                [items addObject:[UIImage imageNamed:@"noImagePalceHolder.jpg"]];
            }
            
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) 
                carousel = [[iCarousel alloc] initWithFrame:CGRectMake(0, -30, 320, 300)];
            else
                carousel = [[iCarousel alloc] initWithFrame:CGRectMake(0, 10, 768, 547)];
            
            carousel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            carousel.type = iCarouselTypeCoverFlow2;
            carousel.dataSource = self;
            carousel.delegate = self;
            [self.view addSubview:carousel];
           
            //for the details to be displayed on the screen
            placeLbl.text = [[thedelegate.eventArray objectAtIndex:thedelegate.eventSelected] objectForKey:@"location_name"];
            eventDescTxtView.text = [[thedelegate.eventArray objectAtIndex:thedelegate.eventSelected] objectForKey:@"event_description"];
            dateTimeLbl.text = [NSString stringWithFormat:@"%@ - %@",[[thedelegate.eventArray objectAtIndex:thedelegate.eventSelected] objectForKey:@"event_start_time"],[[thedelegate.eventArray objectAtIndex:thedelegate.eventSelected] objectForKey:@"event_end_time"]];
            priceLbl.text = @"N/A";
    
            //to locate the location using the given lat and long
            id temp = [[thedelegate.eventArray objectAtIndex:thedelegate.eventSelected] objectForKey:@"location_latitude"];
            NSLog(@"%@",[temp class]);
    
            float eventLat = [[[thedelegate.eventArray objectAtIndex:thedelegate.eventSelected] objectForKey:@"location_latitude"]floatValue];
            float eventLong = [[[thedelegate.eventArray objectAtIndex:thedelegate.eventSelected] objectForKey:@"location_longitude"]floatValue];
    
            MKCoordinateSpan span;
            MKCoordinateRegion region;
            span.latitudeDelta = 0.01;
            span.longitudeDelta = 0.01;
            CLLocationCoordinate2D location;
            location.latitude = eventLat;
            location.longitude = eventLong;
            region.span = span;
            region.center = location;
            [mapView setRegion:region animated:TRUE];
            [mapView regionThatFits:region];
            
            [fullScreenMap setRegion:region animated:TRUE];
            [fullScreenMap regionThatFits:region];
    
            AddressAnnotation *newAnnotation = [[AddressAnnotation alloc] initWithCoordinate:location title:nil subTitle:nil];
            [mapView addAnnotation:newAnnotation];
            [loadingView setHidden:YES];
            
            [fullScreenMap addAnnotation:newAnnotation];            
            carouselCheck = 2;
        }
        else
        {
            [loadingView setHidden:YES];
            return;
        }
    }

}

//----for full screen map----//
- (IBAction)fullScreen:(id)sender
{
    UIViewController *modal=[[UIViewController alloc]init ];
    modal.view=fullScreenMapView;
    [self.navigationController presentModalViewController:modal animated:YES];
}

- (IBAction)closeMapView:(id)sender
{
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

//----to resize the image recieved fon the response----//
-(UIImage *)resizeImage:(UIImage *)image width:(float)resizeWidth height:(float)resizeHeight
{    
    UIGraphicsBeginImageContext(CGSizeMake(resizeWidth, resizeHeight));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0.0, resizeHeight);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, CGRectMake(0.0, 0.0, resizeWidth, resizeHeight), [image CGImage]);
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

//----carusel delegate methods----//
- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return [items count];
}

- (UIView *)carousel:(iCarousel *)_carousel viewForItemAtIndex:(NSUInteger)index
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) 
    {
        UIImage *image = [items objectAtIndex:index];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake(0, 0, 400, 450);
        return imageView;
    }
    else
    {
        UIImage *image = [items objectAtIndex:index];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake(0, 0, 174, 216);
        return imageView;
    }
    return nil;
    
}

//----carusel delegate methods - to set the title everytime when the carousel is scrolled---//
- (void)carouselDidEndScrollingAnimation:(iCarousel *)_carousel;
{
    
  // selEventCount = _carousel.currentItemIndex;
   // thedelegate.selectedEvent = [thedelegate.eventArray objectAtIndex:selEventCount];
}

- (void)carouselDidScroll:(iCarousel *)_carousel
{
   // [self.navigationItem setTitle:[thedelegate.eventArray objectAtIndex:_carousel.currentItemIndex]];
}


//----IBAction for the eent selected from the carousel----//
- (IBAction)buttonTapped:(id)sender
{
    
}

//----IBAction for the booking btn----//
- (IBAction)booking:(id)sender
{
    typeOfTicket *ticket;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) 
        ticket = [[typeOfTicket alloc] initWithNibName:@"typeOfTicket_iPhone" bundle:nil];
    else
        ticket = [[typeOfTicket alloc] initWithNibName:@"typeOfTicket_iPad" bundle:nil];
    
    [self.navigationController pushViewController:ticket animated:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) 
    {
        if (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
            return YES;
    } 
    else 
    {
        if (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
            return YES;
    }
   
    return NO;
}
- (void) viewDidDisappear:(BOOL)animated
{
    carousel = nil;
}

@end
