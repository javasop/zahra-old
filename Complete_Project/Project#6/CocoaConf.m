//
//  CocoaConf.m
//  IntroducingCollectionViews
//
//  Created by Mark Pospesel on 10/8/12.
//  Copyright (c) 2012 Mark Pospesel. All rights reserved.
//

#import "CocoaConf.h"
#import "Conference.h"
#import "SpeakerCell.h"
#import "ConferenceHeader.h"
#import "StarRatingFooter.h"
#import "Book.h"
#import "HEBCModelManager.h"
#import "SBJson.h"





NSString *kConferenceHeaderID = @"ConferenceHeader";
NSString *kConferenceHeaderSmallID = @"ConferenceHeaderSmall";
NSString *kSpeakerCellID = @"SpeakerCell";
NSString *kStarRatingFooterID = @"StarRatingFooter";

@interface CocoaConf()

- (id)initWithConferences:(NSArray *)conferences;

@end

@implementation CocoaConf

@synthesize bookletDetail,conferences;

- (id)initWithConferences:(NSArray *)conferences
{
    self = [super init];
    
//    [[HEBCModelManager sharedHEBCModelManager] updateFromServer_bookletsList];
//    
//    conferences = [HEBCModelManager sharedHEBCModelManager].bookletsList;
    
    thedelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    self.conferences = conferences;

    return self;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
   return [self.conferences count];

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//    if (section < 0 || section >= self.conferences.count)
//        return 0;
    
    return [self.conferences[0] count];
}




- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
 
    
    NSInteger section = indexPath.section;
    
    SpeakerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kSpeakerCellID forIndexPath:indexPath];
    
    NSDictionary *test = self.conferences[0][indexPath.item];
    
    int count = [self.conferences count];
    
    int scount = [self.conferences[0] count];
    
    bookletDetail = test;
    
    NSString *hello = [test objectForKey:@"cover"];
    
    NSString *name = [test objectForKey:@"booklet_name"];
    
    NSURL *imageurl = [NSURL URLWithString:hello];
    
    NSData *imageData = [NSData dataWithContentsOfURL:imageurl];
    
    UIImage *tempImage = [UIImage imageWithData:imageData];
    
    cell.speakerImg = tempImage;
    
    
    // asynchronous image load
    //[[AppDelegate backgroundQueue] addOperationWithBlock:^{
      //  [[NSOperationQueue mainQueue] addOperationWithBlock:^{
    
    
//            NSArray *bookArray = [NSArray array];
//    
//
//            bookArray = [HEBCModelManager sharedHEBCModelManager].bookletsList;
//    
//    
//            
//            
//            Book * book = (Book*)[bookArray objectAtIndex:indexPath.item];
//            
//            UIImage* cover = nil;
//            
//            
//            if (book.coverURL)
//            {
//                NSArray *documentsPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//                NSString* filaPath = [[documentsPaths objectAtIndex:0]
//                                      stringByAppendingPathComponent:[book.coverURL lastPathComponent]];
//                
//                NSLock* lock = [[NSLock alloc] init];
//                [lock lock];
//                {
//                    NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:book.coverURL]];
//                    [data writeToFile:filaPath atomically:YES];
//                }
//                [lock unlock];
//                
//                cover = [UIImage imageWithContentsOfFile:filaPath];
//                
//            }
//            if (cover)
//            {
//                cell.speakerImg = cover;
//
//            }
    
      //  }];
    //}];
    
    
    
    
    return cell;
    
}

//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    NSInteger section = indexPath.section;
//
//    if ([kind isEqualToString:UICollectionElementKindSectionFooter])
//    {
//        StarRatingFooter *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kStarRatingFooterID forIndexPath:indexPath];
//        return footer;
//    }
//    
//    BOOL isSmall = [kind isEqualToString:[SmallConferenceHeader kind]];
//    ConferenceHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:isSmall? kConferenceHeaderSmallID : kConferenceHeaderID forIndexPath:indexPath];
//    
//    [header setConference:self.conferences[section]];
//    
//    return header;
//}

#pragma mark - Private Class Methods

+ (Conference *)columbus2011
{
    return[ Conference conferenceWithName:@"CocoaConf Columbus 2011" startDate:[NSDate date] duration:3 speakers:@[@"Chris Adamson", @"Randy Beiter", @"Craig Castelaz", @"Mark Dalrymple", @"Bill Dudney", @"Mark Gilicinski", @"Chris Judd", @"Dave Koziol", @"Mac Liaw", @"Steve Madsen", @"Jonathan Penn", @"Doug Sjoquist", @"Josh Smith", @"Daniel Steinberg"]];
}

+ (Conference *)raleigh2011
{
    return [Conference conferenceWithName:@"CocoaConf Raleigh 2011" startDate:[NSDate date] duration:3 speakers:@[@"Chris Adamson", @"Jeff Biggus", @"Collin Donnell", @"Bill Dudney", @"Nathan Eror", @"Andy Hunt", @"Andria Jensen", @"Josh Johnson", @"Chris Judd", @"Saul Mora", @"Jonathan Penn", @"Jared Richardson", @"Josh Smith", @"Daniel Steinberg"]];
}

+ (Conference *)chicago2012
{
    return [Conference conferenceWithName:@"CocoaConf Chicago 2012" startDate:[NSDate date] duration:3 speakers:@[@"Chris Adamson", @"Randy Beiter", @"Jeff Biggus", @"Jonathan Blocksom", @"Heath Borders", @"Brian Coyner", @"Bill Dudney", @"Dave Koziol", @"Brad Larson", @"Eric Meyer", @"Jonathan Penn", @"Boisy Pitre", @"Mark Pospesel", @"Josh Smith", @"Daniel Steinberg", @"Whitney Young"]];
}

+ (Conference *)dc2012
{
    return [Conference conferenceWithName:@"CocoaConf DC 2012" startDate:[NSDate date] duration:3 speakers:@[@"Chris Adamson", @"Mike Ash", @"Jonathan Blocksom", @"Step Christopher", @"Mark Dalrymple", @"Jason Hunter", @"Chris Judd", @"Jonathan Lehr", @"Scott McAlister", @"Saul Mora", @"Jonathan Penn", @"Mark Pospesel", @"Jonathan Saggau", @"Chad Sellers", @"David Smith", @"Daniel Steinberg", @"Walter Tyree", @"Whitney Young"]];
}

+ (Conference *)columbus2012
{
    return [Conference conferenceWithName:@"CocoaConf Columbus 2012" startDate:[NSDate date] duration:3 speakers:@[@"Josh Abernathy", @"Chris Adamson", @"Randy Beiter", @"Brian Coyner", @"Mark Dalrymple", @"Bill Dudney", @"Jason Felice", @"Geoff Goetz", @"Chris Judd", @"Jeff Kelley", @"Dave Koziol", @"Steve Madsen", @"Kevin Munc", @"Jaimee Newberry", @"Jonathan Penn", @"Doug Sjoquist", @"Josh Smith", @"Daniel Steinberg", @"Mattt Thompson"]];
}

+ (Conference *)portland2012
{
    // reduces list for screenshots
    //return [Conference conferenceWithName:@"CocoaConf Portland 2012" startDate:[NSDate dateWithYear:2012 month:10 day:25] duration:3 speakers:@[@"Josh Abernathy", @"Tim Burks", @"James Dempsey", @"Collin Donnell", @"Andria Jensen", @"Justin Miller", @"Jaimee Newberry", @"Janine Ohmer", @"Elizabeth Taylor"]];
    return [Conference conferenceWithName:@"CocoaConf Portland 2012" startDate:[NSDate date] duration:3 speakers:@[@"Josh Abernathy", @"Chris Adamson", @"Tim Burks", @"James Dempsey", @"Collin Donnell", @"Pete Hodgson", @"Andria Jensen", @"Justin Miller", @"Saul Mora", @"Jaimee Newberry", @"Janine Ohmer", @"Daniel Pasco", @"Jonathan Penn", @"Mark Pospesel", @"Ben Scheirman", @"Brent Simmons", @"Josh Smith", @"Daniel Steinberg", @"Elizabeth Taylor", @"Mattt Thompson"]];
}

+ (Conference *)raleigh2012
{
    // reduces list for screenshots
    //return [Conference conferenceWithName:@"CocoaConf Raleigh 2012" startDate:[NSDate dateWithYear:2012 month:11 day:29] duration:3 speakers:@[@"Ameir Al-Zoubi", @"Ken Auer", @"Kevin Conner", @"Jack Cox", @"Josh Johnson", @"Scott McAlister", @"Rob Napier", @"Josh Nozzi", @"Jay Thrash", @"Walter Tyree"]];
    return [Conference conferenceWithName:@"CocoaConf Raleigh 2012" startDate:[NSDate date] duration:3 speakers:@[@"Chris Adamson", @"Ameir Al-Zoubi", @"Ken Auer", @"Jonathan Blocksom", @"Kevin Conner", @"Jack Cox", @"Mark Dalrymple", @"Bill Dudney", @"Aaron Hillegass", @"Josh Johnson", @"Chris Judd", @"Scott McAlister", @"Rob Napier", @"Josh Nozzi", @"Jonathan Penn", @"Mark Pospesel", @"Daniel Steinberg", @"Jay Thrash", @"Walter Tyree"]];
}

+ (Conference *)chicago2013
{
    return [Conference conferenceWithName:@"CocoaConf Chicago 2013" startDate:[NSDate date] duration:3 speakers:@[@"Chris Adamson", @"Brandon Alexander", @"Randy Beiter", @"Jeff Biggus", @"James Dempsey", @"Aaron Douglas", @"Nathan Eror", @"Chris Judd", @"Peter Kananen", @"Dave Koziol", @"Ben Lachman", @"Jaimee Newberry", @"Jonathan Penn", @"Charles Perry", @"Boisy Pitre", @"Ben Scheirman", @"Josh Smith", @"Daniel Steinberg", @"Brittany Tarvin", @"Elizabeth Taylor", @"Josh Twist", @"Whitney Young"]];
}

+ (Conference *)dc2013
{
    // reduces list for screenshots
    //return [Conference conferenceWithName:@"CocoaConf DC 2013" startDate:[NSDate dateWithYear:2012 month:6 day:28] duration:3 speakers:@[@"Ken Auer", @"Jack Cox", @"Kevin Kim", @"Bob McCune", @"Rob Napier", @"Jaimee Newberry", @"Chris Risner", @"Chad Sellers", @"Doug Sjoquist", @"Walter Tyree", @"TJ Usiyan"]];
    return [Conference conferenceWithName:@"CocoaConf DC 2013" startDate:[NSDate date] duration:3 speakers:@[@"Chris Adamson", @"Ken Auer", @"Jonathan Blocksom", @"Jack Cox", @"Mark Dalrymple", @"Bill Dudney", @"Kevin Kim", @"Jeff LaMarche", @"Bob McCune", @"Rob Napier", @"Jaimee Newberry", @"Mark Pospesel", @"Chris Risner", @"Chad Sellers", @"Doug Sjoquist", @"Daniel Steinberg", @"Walter Tyree", @"TJ Usiyan", @"Ray Wenderlich"]];
}

+ (Conference *)dallas2013
{
    return [Conference conferenceWithName:@"CocoaConf Dallas 2013" startDate:[NSDate date] duration:3 speakers:@[@"Patrick Burleson", @"Rene Cacheaux", @"James Dempsey", @"Bill Dudney", @"Nathan Eror", @"Kevin Harwood", @"Kevin Kim", @"Sean McMains", @"Saul Mora", @"Daniel Pasco", @"Jonathan Penn", @"Manton Reece", @"Kyle Richter", @"Cesare Rocchi", @"Ben Scheirman", @"Doug Sjoquist", @"Daniel Steinberg", @"Conrad Stoll", @"Josh Twist", @"Walter Tyree"]];
}

+ (Conference *)sanJose2013
{
    // reduces list for screenshots
    //return [Conference conferenceWithName:@"CocoaConf San Jose 2013" startDate:[NSDate dateWithYear:2013 month:4 day:21] duration:3 speakers:@[@"Matt Drance", @"Bill Dudney", @"Bob McCune", @"Kyle Richter", @"Michael Simmons", @"Michele Titolo", @"Marcus Zarra", @"Daniel Pasco", @"Jaimee Newberry", @"James Dempsey"]];
    return [Conference conferenceWithName:@"CocoaConf San Jose 2013" startDate:[NSDate date] duration:3 speakers:@[@"Chris Adamson", @"James Dempsey", @"Matt Drance", @"Bill Dudney", @"Nathan Eror", @"Mattieu Gamache-Asselin", @"Pete Hodgson", @"Jeff LaMarche", @"Ben Lachman", @"Bob McCune", @"Saul Mora", @"Jaimee Newberry", @"Daniel Pasco", @"Jonathan Penn", @"Mark Pospesel", @"Kyle Richter", @"Michael Simmons", @"Josh Smith", @"Daniel Steinberg", @"Elizabeth Taylor", @"Michele Titolo", @"Marcus Zarra"]];
}

#pragma mark - Class Methods

+ (CocoaConf *)combined
{
    static dispatch_once_t once;
    static id combinedCocoaConfs;
    dispatch_once(&once, ^{
        combinedCocoaConfs = [[self alloc] initWithConferences:@[[Conference conferenceWithName:@"CocoaConf" startDate:[NSDate date] duration:3 speakers:@[@"Josh Abernathy", @"Chris Adamson", @"Ameir Al-Zoubi", @"Mike Ash", @"Ken Auer", @"Randy Beiter", @"Jeff Biggus", @"Jonathan Blocksom", @"Heath Borders", @"Tim Burks", @"Craig Castelaz", @"Step Christopher", @"Kevin Conner", @"Jack Cox", @"Brian Coyner", @"Mark Dalrymple", @"James Dempsey", @"Collin Donnell", @"Bill Dudney", @"Nathan Eror", @"Jason Felice", @"Mark Gilicinski", @"Geoff Goetz", @"Aaron Hillegass", @"Pete Hodgson", @"Andy Hunt", @"Jason Hunter", @"Andria Jensen", @"Josh Johnson", @"Chris Judd", @"Jeff Kelley", @"Dave Koziol", @"Brad Larson", @"Jonathan Lehr", @"Mac Liaw", @"Steve Madsen", @"Scott McAlister", @"Eric Meyer", @"Justin Miller", @"Saul Mora", @"Kevin Munc", @"Rob Napier", @"Jaimee Newberry", @"Josh Nozzi", @"Janine Ohmer", @"Daniel Pasco", @"Jonathan Penn", @"Boisy Pitre", @"Mark Pospesel", @"Jared Richardson", @"Jonathan Saggau", @"Ben Scheirman", @"Chad Sellers", @"Brent Simmons", @"Doug Sjoquist", @"Josh Smith", @"David Smith", @"Daniel Steinberg", @"Elizabeth Taylor", @"Mattt Thompson", @"Jay Thrash", @"Walter Tyree", @"Whitney Young"]]]];
    });
    
    return combinedCocoaConfs;
}

+ (CocoaConf *)all:(NSString*)type
{
    //call the hebcmanager model ...
//    NSArray *arr = [HEBCModelManager sharedHEBCModelManager].bookletsList;
    static dispatch_once_t once;
    static id allCocoaConfs;
        
        //[{"booklet_id":"489","booklet_name":"\u0628\u0631\u0646\u0627\u0645\u062c \u0634\u0628\u0643\u0629 \u0623\u0639\u0636\u0627\u0621 \u0632\u0647\u0631\u0629","pdf_file":"http:\/\/galamr.com\/zahrahcp\/wp-content\/uploads\/2012\/12\/healthy_diet.pdf","cover":"http:\/\/galamr.com\/zahrahcp\/wp-content\/uploads\/2012\/12\/1st-BG-zahra3.png"}]
        
        NSURLResponse * serviceResponse;
        NSError * serviceError;
        NSMutableArray *bookletArray = [[NSMutableArray alloc] init];

        
        //to fetch all the booklets info
        NSString *eventInfo = @"";
        if([type  isEqual: @"1"]){
        eventInfo = @"http://www.galamr.com/services/index.php/welcome/get_all_booklets";
        }
        else{
        eventInfo = @"http://www.galamr.com/services/index.php/welcome/get_all_amal_brochures"; 
        }
        NSMutableURLRequest * serviceRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:eventInfo]];
        NSData *returndata = [NSURLConnection sendSynchronousRequest:serviceRequest returningResponse:&serviceResponse error:&serviceError];
        NSString *returnaccountString = [[NSString alloc] initWithData:returndata encoding:NSUTF8StringEncoding];
        NSArray *json = [returnaccountString JSONValue];
        
        for (int i = 0; i < [json count]; i++)
        {
            NSDictionary *booklet = [json objectAtIndex:i];
            
//          NSString *bookletpdf = [booklet objectForKey:@"pdf_file"];
//
//            
//            NSString *dictionaryName = [NSString stringWithFormat:@"%@ booklet",bookletpdf];
//            NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:dictionaryName];
//            NSArray *defaultsArray = [NSArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:data]];
//            
//            if (!defaultsArray)
//                defaultsArray = [[NSArray alloc] init];
            
//            NSMutableArray *bookDetail = [[NSMutableArray alloc] initWithArray:defaultsArray];
            
            [bookletArray addObject:booklet];
            
            
//            [[NSUserDefaults standardUserDefaults] setObject:data forKey:dictionaryName];
//            [[NSUserDefaults standardUserDefaults]setObject:bookDetail forKey:dictionaryName];
        }
       allCocoaConfs = [[self alloc] initWithConferences:@[bookletArray]];
    
    return allCocoaConfs;
}

+ (CocoaConf *)currentCocoaConf
{
    static dispatch_once_t once;
    static id current;
    dispatch_once(&once, ^{
        current = [[self alloc] initWithConferences:@[[self dc2013]]];
    });
    
    return current;
}

+ (CocoaConf *)recent
{
    static dispatch_once_t once;
    static id recentCocoaConfs;
    dispatch_once(&once, ^{
        recentCocoaConfs = [[self alloc] initWithConferences:@[[self dc2013], [self chicago2013]]];
    });
    
    return recentCocoaConfs;
}

+ (NSString *)smallHeaderReuseID
{
    return kConferenceHeaderSmallID;
}

- (BOOL)deleteSpeakerAtPath:(NSIndexPath *)indexPath
{
    if (indexPath.section < 0 || indexPath.section >= self.conferences.count)
        return NO;

    Conference* conference = self.conferences[indexPath.section];
    return [conference deleteSpeakerAtIndex:indexPath.item];
}

- (BOOL)restoreSpeakerInSection:(int)section
{
    if (section < 0 || section >= self.conferences.count)
        return NO;
    
    Conference* conference = self.conferences[section];
    return [conference restoreSpeaker];
}

- (void)updateLibraryView:(NSNotification*)notification
{
    
    //i am doing nothing for now
}


@end
