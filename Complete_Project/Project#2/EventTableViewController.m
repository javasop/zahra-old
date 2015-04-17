//
//  EventTableViewController.m
//  Complete_Project
//
//  Created by Rebecca Sable on 6/30/14.
//  Copyright (c) 2014 nitin.gupta@ongraph.com. All rights reserved.
//

#import "EventTableViewController.h"

@interface EventTableViewController ()

@end

@implementation EventTableViewController

@synthesize events;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    thedelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    NSURLResponse * serviceResponse;
    NSError * serviceError;
    
    eventDetail = [[NSMutableArray alloc] init];
    self.events = [[NSMutableArray alloc]init];

    
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
        
        
        NSString *dictionaryName = [NSString stringWithFormat:@"%@ details",eventStartTime];
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:dictionaryName];
        NSArray *defaultsArray = [NSArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:data]];
        
        if (!defaultsArray)
            defaultsArray = [[NSArray alloc] init];
        
      //  eventDetail = [[NSMutableArray alloc] initWithArray:defaultsArray];
        [eventDetail addObject:event];
        
        [self.events addObject:event];
        
        data = [NSKeyedArchiver archivedDataWithRootObject:eventDetail];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:dictionaryName];
        //[[NSUserDefaults standardUserDefaults]setObject:eventDetail forKey:dictionaryName];
    }
    
    
    
    
    NSDateFormatter *dateformat = [[NSDateFormatter alloc] init];
    [dateformat setDateFormat:@"yyyy-MM-dd"];
    NSString *t = [dateformat stringFromDate:[NSDate date]];
    
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@ details",t]];
    thedelegate.eventArray = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:data]];
    thedelegate.eventArray = [NSMutableArray arrayWithArray:eventDetail];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    return [eventDetail count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    UILabel *label = (UILabel *)[cell.contentView viewWithTag:10];
    UILabel *label2 = (UILabel *)[cell.contentView viewWithTag:20];

    
    if (cell == nil)
    {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [label setText:[[eventDetail objectAtIndex:[indexPath row]] objectForKey:@"event_name"]];
    [label2 setText:[[eventDetail objectAtIndex:[indexPath row]] objectForKey:@"event_start_date"]];

    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EventDetail *event;
    thedelegate.selectedEvent = [[eventDetail objectAtIndex:[indexPath row]]objectForKey:@"event_name"];
    thedelegate.eventSelected = [indexPath row];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        event = [[EventDetail alloc] initWithNibName:@"EventDetail_iPhone" bundle:nil];
        //event = [[EventDetail alloc] initWithNibName:@"TestEventDetail_iPhone" bundle:nil];
    }else{
        event = [[EventDetail alloc] initWithNibName:@"EventDetail_iPad" bundle:nil];
    }
    [self.navigationController pushViewController:event animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
