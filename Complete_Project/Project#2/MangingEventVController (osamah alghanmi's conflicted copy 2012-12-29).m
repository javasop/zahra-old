//
//  ViewController.m
//  ManagingEvents
//


#import "MangingEventVController.h"

@implementation MangingEventVController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
       
    [super viewDidLoad];

    
    thedelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //[self.navigationController setNavigationBarHidden:YES animated:YES];
    eventTable.hidden = YES;

    
    if (thedelegate.isNetworkAvailable)
    {
        eventTable.hidden = NO;
        [eventTable sizeThatFits:CGSizeMake(1024, 44*[thedelegate.eventArray count])];
        
        
        marks = [[NSMutableArray alloc]init];
        calendar = 	[[TKCalendarMonthView alloc]init];
        controller = [[TKCalendarMonthViewController alloc]init];
        
        calendar.delegate = self;
        calendar.dataSource = self;
        
   
        //for ipad
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad )
            eventTable.frame = CGRectMake(0, calendar.frame.size.height, 768, 500);
        else
            eventTable.frame = CGRectMake(0, calendar.frame.size.height, 328, 200);

        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad )
        {
            controller.view = calendar;
            [controller.view setFrame:CGRectMake(0, 0, 768, 550)];
        }
        else
            controller.view = calendar;
        
        
        [self.view addSubview:controller.view];
   
        NSURLResponse * serviceResponse;
        NSError * serviceError;
    
        //to fetch all the event info
        NSString *eventInfo = @"http://www.galamr.com/services/index.php/welcome/events_list_json";    
        NSMutableURLRequest * serviceRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:eventInfo]];
        NSData *returndata = [NSURLConnection sendSynchronousRequest:serviceRequest returningResponse:&serviceResponse error:&serviceError];
        NSString *returnaccountString = [[NSString alloc] initWithData:returndata encoding:NSUTF8StringEncoding];
        NSArray *json = [returnaccountString JSONValue];
    
        for (int i = 0; i < [json count]; i++)
        {
            NSDictionary *event = [json objectAtIndex:i];
            NSString *eventStartTime = [event objectForKey:@"event_start_date"];
            NSString *marksDate = [eventStartTime stringByAppendingString:@" 00:00:00 +0000"];
            NSDateFormatter *dateformat = [[NSDateFormatter alloc] init];
            [dateformat setDateFormat:@"yyyy-MM-dd hh:mm:ss z"];
            //NSDate *t = [dateformat dateFromString:marksDate];
            [dateformat setDateFormat:@"yyyy-MM-dd hh:mm:ss z"];
            
            [marks addObject:marksDate];
 
            NSString *dictionaryName = [NSString stringWithFormat:@"%@ details",eventStartTime];
            NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:dictionaryName];
            NSArray *defaultsArray = [NSArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:data]];
            
            if (!defaultsArray)
                defaultsArray = [[NSArray alloc] init];
        
            eventDetail = [[NSMutableArray alloc] initWithArray:defaultsArray];
            [eventDetail addObject:event];
        
       
            data = [NSKeyedArchiver archivedDataWithRootObject:eventDetail];
            [[NSUserDefaults standardUserDefaults] setObject:data forKey:dictionaryName];
            [[NSUserDefaults standardUserDefaults]setObject:eventDetail forKey:dictionaryName];     
        }
    
        NSDateFormatter *dateformat = [[NSDateFormatter alloc] init];
        [dateformat setDateFormat:@"yyyy-MM-dd"];
        NSString *t = [dateformat stringFromDate:[NSDate date]];

        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@ details",t]];
        thedelegate.eventArray = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:data]];

        [eventTable reloadData];
        [calendar reload];
    }
    else
        return;
}

- (void)viewWillAppear:(BOOL)animated
{
    //[self.navigationController setNavigationBarHidden:YES animated:YES];
}


//----tapku calender delegate methods----//
- (void)calendarMonthView:(TKCalendarMonthView *)monthView didSelectDate:(NSDate *)d 
{
    NSDateFormatter *dateformat = [[NSDateFormatter alloc] init];
    [dateformat setDateFormat:@"yyyy-MM-dd"];
    NSString *t = [dateformat stringFromDate:d];

    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@ details",t]];
    thedelegate.eventArray = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:data]];
    [eventTable reloadData];
}

- (void)calendarMonthView:(TKCalendarMonthView *)monthView monthDidChange:(NSDate *)d {
    
     if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad ){
         [UIView beginAnimations:nil context:NULL];
         eventTable.frame = CGRectMake(0, calendar.frame.size.height, 768, 500);
         [UIView commitAnimations];
     }
    else{
        [UIView beginAnimations:nil context:NULL];
        eventTable.frame = CGRectMake(0, calendar.frame.size.height, 328, 200);
        [UIView commitAnimations];
    }
}

- (NSArray*)calendarMonthView:(TKCalendarMonthView *)monthView marksFromDate:(NSDate *)startDate toDate:(NSDate *)lastDate {	
    NSArray *data = [NSArray arrayWithArray:marks];

    // Initialise empty marks array, this will be populated with TRUE/FALSE in order for each day a marker should be placed on.
    NSMutableArray *marks1 = [NSMutableArray array];

    // Initialise calendar to current type and set the timezone to never have daylight saving
    NSCalendar *cal = [NSCalendar currentCalendar];
    [cal setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
     
    // Construct DateComponents based on startDate so the iterating date can be created.
    // Its massively important to do this assigning via the NSCalendar and NSDateComponents because of daylight saving has been removed 
    // with the timezone that was set above. If you just used "startDate" directly (ie, NSDate *date = startDate;) as the first 
    // iterating date then times would go up and down based on daylight savings.
    NSDateComponents *comp = [cal components:(NSMonthCalendarUnit | NSMinuteCalendarUnit | NSYearCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSSecondCalendarUnit) 
    fromDate:startDate];
    

    NSDate *d = [cal dateFromComponents:comp];

    // Init offset components to increment days in the loop by one each time
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
     [offsetComponents setDay:1];
     
     
    // for each date between start date and end date check if they exist in the data array
    while (YES)
    {
        // Is the date beyond the last date? If so, exit the loop.
        // NSOrderedDescending = the left value is greater than the right
        if ([d compare:lastDate] == NSOrderedDescending)
            break;
     
        // If the date is in the data array, add it to the marks array, else don't
        if ([data containsObject:[d description]]) 
            [marks1 addObject:[NSNumber numberWithBool:YES] ];
        else 
            [marks1 addObject:[NSNumber numberWithBool:NO]];
     
        // Increment day using offset components (ie, 1 day in this instance)
        d = [cal dateByAddingComponents:offsetComponents toDate:d options:0];
     }
    
	return [NSArray arrayWithArray:marks1];
}


//---table view delegate methods----//
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [[thedelegate.eventArray objectAtIndex:[indexPath row]] objectForKey:@"event_name"];
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    return cell;   
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [thedelegate.eventArray count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EventDetail *event;
    thedelegate.selectedEvent = [[thedelegate.eventArray objectAtIndex:[indexPath row]]objectForKey:@"event_name"];
    thedelegate.eventSelected = [indexPath row];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) 
        event = [[EventDetail alloc] initWithNibName:@"EventDetail_iPhone" bundle:nil];
    else
        event = [[EventDetail alloc] initWithNibName:@"EventDetail_iPad" bundle:nil];

        [self.navigationController pushViewController:event animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}


- (void)viewDidUnload
{
    [super viewDidUnload];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
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

@end
