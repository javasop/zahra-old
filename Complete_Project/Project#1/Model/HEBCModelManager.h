//
//  HEBCModelManager.h
//  HealthEducationBreastCancer
//
//  Created by Irene Berezan on 04.05.12.
//  Copyright (c) 2012 Irene Berezan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SynthesizeSingleton.h"

#import "CBServerCommunication.h"
#import "MTSAbstractJSONModelClass.h"

#pragma mark -
#pragma mark FileNames
static NSString* const kDefaultBG = @"bg.jpg";
static NSString* const kDefaultPlistType = @"plist";
static NSString* const kDefaultPlistRootObject = @"root";

// Local cash
static NSString* const CASH_HOSPITALS_PLIST = @"hospitals_list";
static NSString* const CASH_ARTICLES_PLIST = @"articles_list";
static NSString* const CASH_BOOKLETS_PLIST = @"booklets_list";
static NSString* const CASH_BROCHURES_PLIST = @"brochures_list";
static NSString* const CASH_FAQ_PLIST = @"faq_list";
static NSString* const CASH_STORIES_PLIST = @"stories_list";

// Notifications
static NSString* const kModelNotificationHospitalsListDidChange = @"kModelNotificationHospitalsListDidChange";
static NSString* const kModelNotificationArticlesListDidChange = @"kModelNotificationArticlesListDidChange";
static NSString* const kModelNotificationBookletsListDidChange = @"kModelNotificationBookletsListDidChange";
static NSString* const kModelNotificationBrochuresListDidChange = @"kModelNotificationBrochuresListDidChange";
static NSString* const kModelNotificationFAQListDidChange = @"kModelNotificationFAQListDidChange";

// adel
static NSString* const kModelNotificationStoriesListDidChange = @"kModelNotificationStoriesListDidChange";
// adel



@interface HEBCModelManager : NSObject <PCPServerCommunicationDelegate>
{
    NSMutableArray* _mHospitalsList;
    NSMutableArray* _mArticlesList;
    NSMutableArray* _mBookletsList;
    NSMutableArray* _mBrochuresList;
    NSMutableArray* _mFAQList;
    //
    NSMutableArray* _mStoriesList;
    //
}

+ (HEBCModelManager*)sharedHEBCModelManager;

+ (NSArray*)arrayFromCashWithPlistFileName:(NSString*)plistFileName;
+ (void)saveArray:(NSArray*)objectsList toCashWithPlistFileName:(NSString*)plistFileName;

@property (nonatomic, retain, readonly) NSArray* hospitalsList;
@property (nonatomic, retain, readonly) NSArray* articlesList;
@property (nonatomic, retain, readonly) NSArray* bookletsList;
@property (nonatomic, retain, readonly) NSArray* brochuresList;
@property (nonatomic, retain, readonly) NSArray* FAQList;
//
@property (nonatomic, retain, readonly) NSArray* storiesList;
//
@property (nonatomic, retain) NSMutableArray* mHospitalsList;
@property (nonatomic, retain) NSMutableArray* mArticlesList; 
@property (nonatomic, retain) NSMutableArray* mBookletsList;
@property (nonatomic, retain) NSMutableArray* mBrochuresList;
@property (nonatomic, retain) NSMutableArray* mFAQList;
//
@property (nonatomic, retain) NSMutableArray* mStoriesList;
//
- (void)updateFromServer_hospitalsList;
- (void)updateFromServer_articlesList;
- (void)updateFromServer_bookletsList;
- (void)updateFromServer_brochuresList;
- (void)updateFromServer_FAQList;
//
- (void)updateFromServer_StoriesList;
//
@end
