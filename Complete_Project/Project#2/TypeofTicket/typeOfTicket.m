//
//  Booking.m
//  ManagingEvents
//
//  Created by ankit on 22/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "typeOfTicket.h"

@implementation typeOfTicket

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
    [loadingView setHidden:NO];
    
    if (thedelegate.isNetworkAvailable)
    {
        [self.navigationItem setTitle:thedelegate.selectedEvent];
        barBtn = [[UIBarButtonItem alloc] initWithTitle:@"حجز" style:UIBarButtonItemStylePlain target:self action:@selector(book:)];
        [self.navigationItem setRightBarButtonItem:barBtn];
        [barBtn setEnabled:FALSE];
    }
    else
    {
        [loadingView setHidden:YES];
        return;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [loadingView setHidden:YES];
    //for the featured image
    NSURL *imageURL=[NSURL URLWithString:[[thedelegate.eventArray objectAtIndex:thedelegate.eventSelected] objectForKey:@"featured_image"]];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    featuredImgView.image = [UIImage imageWithData:imageData];
    
    //to fetch the ticket info
    NSURLResponse * serviceResponse;
    NSError * serviceError;
    
    NSString *eventID = [[thedelegate.eventArray objectAtIndex:thedelegate.eventSelected] objectForKey:@"event_id"];
    NSString *eventInfo = [NSString stringWithFormat:@"http://www.galamr.com/services/index.php/welcome/tickets_list_json/%@",eventID ];    
    // NSLog(@"%@",eventInfo);
    
    NSMutableURLRequest * serviceRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:eventInfo]];
    NSData *returndata = [NSURLConnection sendSynchronousRequest:serviceRequest returningResponse:&serviceResponse error:&serviceError];
    
    NSString *returnTicketInfo = [[NSString alloc] initWithData:returndata encoding:NSUTF8StringEncoding];
    thedelegate.ticketInfoArray = [returnTicketInfo JSONValue];
    
    NSLog(@"json : %@",thedelegate.ticketInfoArray);
    
    //for the UI
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) 
    {
        //for iPhone
        int y = 250;
        for (int i = 0; i < [thedelegate.ticketInfoArray count]; i++) 
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            //UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(448, y, 20, 20)] ;
            button.frame = CGRectMake(96, y, 20, 20);
            //button.backgroundColor = [UIColor whiteColor];
            
            [button setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
            [button setBackgroundColor:[UIColor whiteColor]];
            
            [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = i+100;
            [self.view addSubview:button];
            
            UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(146, y, 120, 20)];
            lbl.text = [[thedelegate.ticketInfoArray objectAtIndex:i] objectForKey:@"ticket_name"];
            
            lbl.textColor = [UIColor whiteColor];
            lbl.backgroundColor = [UIColor clearColor];
            [lbl sizeToFit];
            [self.view addSubview:lbl];
            
            y = y + 35;
        }
        
    }
    else
    { 
        //for iPad
        int y = 541;
        for (int i = 0; i < [thedelegate.ticketInfoArray count]; i++) 
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            //UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(448, y, 20, 20)] ;
            button.frame = CGRectMake(314, y, 20, 20);
            //button.backgroundColor = [UIColor whiteColor];
            [button setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
            [button setBackgroundColor:[UIColor whiteColor]];
            
            [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = i+100;
            [self.view addSubview:button];
            
            UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(407, y, 120, 20)];
            lbl.text = [[thedelegate.ticketInfoArray objectAtIndex:i] objectForKey:@"ticket_name"];
            lbl.textColor =[UIColor whiteColor];
            lbl.backgroundColor = [UIColor clearColor];
            [lbl sizeToFit];
            [self.view addSubview:lbl];
            
            y = y + 35;
        }
    }
}


    

//----to select the ticket type----//
- (IBAction)buttonClicked:(id)sender
{
    [barBtn setEnabled:TRUE];
    
    NSLog(@"ticket spaces : %@", [[[thedelegate.ticketInfoArray objectAtIndex:[sender tag] - 100 ] objectForKey:@"ticket_spaces"] class]);
    UIButton *clickedBtn = (UIButton *)sender;
    
    for (int i = 0; i < [thedelegate.ticketInfoArray count]; i++)
    {
        UIButton *btn= (UIButton *)[self.view viewWithTag:i + 100];
        btn.backgroundColor = [UIColor whiteColor];
    }
    
    
    if (clickedBtn.backgroundColor == [UIColor whiteColor]) 
    {
        if ([[[thedelegate.ticketInfoArray objectAtIndex:[sender tag] - 100 ] objectForKey:@"remaining_spaces"]intValue]>0 || [[[thedelegate.ticketInfoArray objectAtIndex:[sender tag]-100 ] objectForKey:@"remaining_spaces"] isEqualToString:@""] )
            [barBtn setTitle:@"حجز"];
        else
            [barBtn setTitle:@"حجز انتظار"];
        
        [clickedBtn setBackgroundColor:[UIColor blueColor]];
        thedelegate.ticketSelected = [sender tag] - 100;
    }
    
    else if (clickedBtn.backgroundColor == [UIColor blueColor])
        [clickedBtn setBackgroundColor:[UIColor whiteColor]];
   }


//----to book the selected ticket of the event----//
- (IBAction)book:(id)sender
{
    Booking *book;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) 
        book = [[Booking alloc] initWithNibName:@"Booking_iPhone" bundle:nil];
    else
        book = [[Booking alloc] initWithNibName:@"Booking_iPad" bundle:nil];
    
    [self.navigationController pushViewController:book animated:YES];
    

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
        /*if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight)
            return YES;*/
        if (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
            return YES;
    }
    return NO;
}

@end
