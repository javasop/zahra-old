//
//  TableViewController.m
//  Complete_Project
//
//  Created by Rebecca Sable on 6/28/14.
//  Copyright (c) 2014 nitin.gupta@ongraph.com. All rights reserved.
//

#import "BanksTableViewController.h"
#import "BanksTableViewCell.h"

@interface BanksTableViewController ()


@end

@implementation BanksTableViewController

@synthesize banks;

static NSString *CellIdentifier = @"CellIdentifier";

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
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    
    banks = [NSArray arrayWithObjects:
                      [NSDictionary dictionaryWithObjectsAndKeys:
                       @"riyadh_bank_ipad",@"image",
                       @"SA932 0000 0021 2044 8869 940",@"iban",
                       nil],
                      [NSDictionary dictionaryWithObjectsAndKeys:
                       @"bilad_ipad",@"image",
                       @"SA04 1500 0999 3000 0110 0004",@"iban",
                       nil],
                      [NSDictionary dictionaryWithObjectsAndKeys:
                       @"rajhi_ipad",@"image",
                       @"SA51 8000 0114 6080 1000 3039",@"iban",
                       nil],
                      [NSDictionary dictionaryWithObjectsAndKeys:
                       @"samba_ipad",@"image",
                       @"SA57 4000 0000 0099 0480 0715",@"iban",
                       nil],
                      [NSDictionary dictionaryWithObjectsAndKeys:
                       @"inma_ipad",@"image",
                       @"SA08 0500 0068 2005 2657 3000",@"iban",
                       nil],
                      [NSDictionary dictionaryWithObjectsAndKeys:
                       @"saudi_ipad",@"image",
                       @"SA316 5000 00010 1730 976 001",@"iban",
                       nil],
                      [NSDictionary dictionaryWithObjectsAndKeys:
                       @"holland_ipad",@"image",
                       @"SA505 0000 0000 1035 872 9008",@"iban",
                       nil],
                      [NSDictionary dictionaryWithObjectsAndKeys:
                       @"french_ipad",@"image",
                       @"SA565 50000 00097 1333 001 16",@"iban",
                       nil],
                      [NSDictionary dictionaryWithObjectsAndKeys:
                       @"jazzera_ipad",@"image",
                       @"SA686 00000 00030 4644 640 01",@"iban",
                       nil],
                      nil];
    
    
    
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
    return [banks count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BanksTableViewCell *cell = (BanksTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"identity"forIndexPath:indexPath];
    
    NSDictionary *bank = banks[indexPath.item];
    
    [cell setbImage:[UIImage imageNamed:[bank objectForKey:@"image"]]];
    
    [cell setbIban:[bank objectForKey:@"iban"]];

     
    // Configure Cell
    
//    [cell.textLabel setText:[NSString stringWithFormat:@"Row %i in Section %i", [indexPath row], [indexPath section]]];
    
    
    return cell;
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
