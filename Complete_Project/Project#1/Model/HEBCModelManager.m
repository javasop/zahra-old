//
//  HEBCModelManager.m
//  HealthEducationBreastCancer
//
//  Created by Irene Berezan on 04.05.12.
//  Copyright (c) 2012 Irene Berezan. All rights reserved.
//

#import "HEBCModelManager.h"


#import "Article.h"
#import "Hospital.h"
#import "Booklet.h"
#import "Brochure.h"
#import "FAQItem.h"

@interface HEBCModelManager (Private)
- (void)loadLocalCash_hospitalsList;
- (void)saveToCash_hospitalsList;
- (void)loadLocalCash_articlesList;
- (void)saveToCash_articlesList;
- (void)loadLocalCash_bookletsList;
- (void)saveToCash_bookletsList;
- (void)loadLocalCash_brochuresList;
- (void)saveToCash_brochuresList;
- (void)loadLocalCash_FAQList;
- (void)saveToCash_FAQList;
- (void)loadLocalCash_Stories;
- (void)saveToCash_Stories;
@end


@implementation HEBCModelManager

@synthesize hospitalsList = _mHospitalsList;
@synthesize articlesList = _mArticlesList;
@synthesize bookletsList = _mBookletsList;
@synthesize brochuresList = _mBrochuresList;
@synthesize FAQList    = _mFAQList;
@synthesize storiesList    = _mStoriesList;

SYNTHESIZE_SINGLETON_FOR_CLASS(HEBCModelManager)

#pragma -
#pragma Class Methods
+ (NSArray*)arrayFromCashWithPlistFileName:(NSString*)plistFileName
{
// Get list of articles from plist file
NSString* plistFilePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)
                            objectAtIndex:0]
                           stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", plistFileName, kDefaultPlistType]];

if (![[NSFileManager defaultManager] isReadableFileAtPath:plistFilePath])
{
    plistFilePath = [[NSBundle mainBundle] pathForResource:
                     plistFileName ofType:kDefaultPlistType];        
}

return [NSArray arrayWithArray:(NSArray*)[[NSDictionary dictionaryWithContentsOfFile:plistFilePath] objectForKey:kDefaultPlistRootObject]];
}

+ (void)saveArray:(NSArray*)objectsList toCashWithPlistFileName:(NSString*)plistFileName
{
    // Put list of articles into plist file
    NSString* plistFilePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)
                                objectAtIndex:0]
                               stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", plistFileName, kDefaultPlistType]];    
    
    NSMutableArray* objectGroups = [NSMutableArray new];
    for (MTSAbstractJSONModelClass* object in objectsList)
    {
        [objectGroups addObject:object.dictionary];
    }
    NSDictionary* dictionary = [NSDictionary dictionaryWithObject:(NSArray*)objectGroups forKey:kDefaultPlistRootObject];
    [dictionary writeToFile:plistFilePath atomically:YES];
    [objectGroups release];}


#pragma -
#pragma Memory management

- (void)dealloc
{
    [_mHospitalsList release];
    [_mArticlesList release];
    [_mBookletsList release];
    [_mBrochuresList release];
    [_mFAQList release];
    //
    [_mStoriesList release];
    //
    [super dealloc];
}

#pragma -
#pragma iVars

///////// HospitalsList
- (NSMutableArray*)mHospitalsList
{
    if (!_mHospitalsList)
    {
        _mHospitalsList = [NSMutableArray new];
        
        [self loadLocalCash_hospitalsList];
    }
    return _mHospitalsList;
}

- (NSArray*)hospitalsList
{
    return [NSArray arrayWithArray:self.mHospitalsList];
}


- (void)setMHospitalsList:(NSMutableArray *)mHospitalsList
{
    if (![_mHospitalsList isEqual:mHospitalsList])
    {
        [_mHospitalsList release];
        _mHospitalsList = [mHospitalsList retain];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kModelNotificationHospitalsListDidChange object:self];
    }
}


///////// ArticlesList
- (NSMutableArray*)mArticlesList
{
    if (!_mArticlesList)
    {
        _mArticlesList = [NSMutableArray new];
        
        [self loadLocalCash_articlesList];
    }
    return _mArticlesList;
}

- (NSArray*)articlesList
{
    return [NSArray arrayWithArray:self.mArticlesList];
}


- (void)setMArticlesList:(NSMutableArray *)mArticlesList
{
    if (![_mArticlesList isEqual:mArticlesList])
    {
        [_mArticlesList release];
        _mArticlesList = [mArticlesList retain];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kModelNotificationArticlesListDidChange object:self];
    }
}


// adel


///////// StoriesList
- (NSMutableArray*)mStoriesList
{
    if (!_mStoriesList)
    {
        _mStoriesList = [NSMutableArray new];
        
        [self loadLocalCash_storiesList];
    }
    return _mStoriesList;
}

- (NSArray*)storiesList
{
    return [NSArray arrayWithArray:self.mStoriesList];
}

- (void)setMStoriesList:(NSMutableArray *)mArticlesList
{
    if (![_mStoriesList isEqual:mArticlesList])
    {
        [_mStoriesList release];
        _mStoriesList = [mArticlesList retain];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kModelNotificationStoriesListDidChange object:self];
    }
}

// adel


///////// BookletsList
- (NSMutableArray*)mBookletsList
{
    if (!_mBookletsList)
    {
        _mBookletsList = [NSMutableArray new];
        
        [self loadLocalCash_bookletsList];
    }
    return _mBookletsList;
}

- (NSArray*)bookletsList
{
    return [NSArray arrayWithArray:self.mBookletsList];
}


- (void)setMBookletsList:(NSMutableArray *)mLibraryList
{
    if (![_mBookletsList isEqual:mLibraryList])
    {
        [_mBookletsList release];
        _mBookletsList = [mLibraryList retain];
        [[NSNotificationCenter defaultCenter] postNotificationName:kModelNotificationBookletsListDidChange object:self];
    }
}

///////// BrochuresList
- (NSMutableArray*)mBrochuresList
{
    if (!_mBrochuresList)
    {
        _mBrochuresList = [NSMutableArray new];
        
        [self loadLocalCash_brochuresList];
    }
    return _mBrochuresList;
}

- (NSArray*)brochuresList
{
    return [NSArray arrayWithArray:self.mBrochuresList];
}


- (void)setMBrochuresList:(NSMutableArray *)mBrochuresList
{
    if (![_mBrochuresList isEqual:mBrochuresList])
    {
        [_mBrochuresList release];
        _mBrochuresList = [mBrochuresList retain];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kModelNotificationBrochuresListDidChange object:self];
    }
}

///////// FAQList
- (NSMutableArray*)mFAQList
{
    if (!_mFAQList)
    {
        _mFAQList = [NSMutableArray new];
        
        [self loadLocalCash_FAQList];
    }
    return _mFAQList;
}

- (NSArray*)FAQList
{
    return [NSArray arrayWithArray:self.mFAQList];
}


- (void)setMFAQList:(NSMutableArray *)mFAQList
{
    if (![_mFAQList isEqual:mFAQList])
    {
        [_mFAQList release];
        _mFAQList = [mFAQList retain];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kModelNotificationFAQListDidChange object:self];
    }
}

#pragma -
#pragma Local cashes

- (void)loadLocalCash_hospitalsList
{
    [_mHospitalsList removeAllObjects];
    NSArray * objectsFromPlist = [[[self class] arrayFromCashWithPlistFileName:CASH_HOSPITALS_PLIST] retain];
    
    for (NSDictionary* dictionary in objectsFromPlist)
    {
        Hospital* hospital = [[Hospital alloc] initWithDictionary:dictionary];
        [_mHospitalsList addObject:hospital];
        [hospital release];
    }
    
    [objectsFromPlist release];
}

- (void)saveToCash_hospitalsList
{
    [[self class] saveArray:self.hospitalsList toCashWithPlistFileName:CASH_HOSPITALS_PLIST];
}
///
- (void)loadLocalCash_articlesList 
{
    [_mArticlesList removeAllObjects];
    NSArray * objectsFromPlist = [[[self class] arrayFromCashWithPlistFileName:CASH_ARTICLES_PLIST] retain];
    
    for (NSDictionary* dictionary in objectsFromPlist)
    {
        Article* article = [[Article alloc] initWithDictionary:dictionary];
        [_mArticlesList addObject:article];
        [article release];
    }
    
    [objectsFromPlist release];
}

- (void)saveToCash_articlesList
{
    [[self class] saveArray:self.articlesList toCashWithPlistFileName:CASH_ARTICLES_PLIST];
}

///


///
- (void)loadLocalCash_storiesList 
{
    [_mStoriesList removeAllObjects];
    // what to do here? 
    NSArray * objectsFromPlist = [[[self class] arrayFromCashWithPlistFileName:CASH_STORIES_PLIST] retain];
    
    for (NSDictionary* dictionary in objectsFromPlist)
    {
        Article* article = [[Article alloc] initWithDictionary:dictionary];
        [_mArticlesList addObject:article];
        [article release];
    }
    
    [objectsFromPlist release];
}

- (void)saveToCash_storiesList
{
    
    [[self class] saveArray:self.storiesList toCashWithPlistFileName:CASH_STORIES_PLIST];
}

///


- (void)loadLocalCash_bookletsList
{
    [_mBookletsList removeAllObjects];
    NSArray * objectsFromPlist = [[[self class] arrayFromCashWithPlistFileName:CASH_BOOKLETS_PLIST] retain];
    
    for (NSDictionary* dictionary in objectsFromPlist)
    {
        Booklet* book = [[Booklet alloc] initWithDictionary:dictionary];
        [_mBookletsList addObject:book];
        [book release];
    }
    
    [objectsFromPlist release];
}

- (void)saveToCash_bookletsList
{
    [[self class] saveArray:self.bookletsList toCashWithPlistFileName:CASH_BOOKLETS_PLIST];
}

///
- (void)loadLocalCash_brochuresList
{
    [_mBrochuresList removeAllObjects];
    NSArray * objectsFromPlist = [[[self class] arrayFromCashWithPlistFileName:CASH_BROCHURES_PLIST] retain];
    
    for (NSDictionary* dictionary in objectsFromPlist)
    {
        Brochure* book = [[Brochure alloc] initWithDictionary:dictionary];
        [_mBrochuresList addObject:book];
        [book release];
    }
    
    [objectsFromPlist release];
}

- (void)saveToCash_brochuresList
{
    [[self class] saveArray:self.brochuresList toCashWithPlistFileName:CASH_BROCHURES_PLIST];
}
///

- (void)loadLocalCash_FAQList
{
    [_mFAQList removeAllObjects];
    NSArray * objectsFromPlist = [[[self class] arrayFromCashWithPlistFileName:CASH_FAQ_PLIST] retain];
    
    for (NSDictionary* dictionary in objectsFromPlist)
    {
        FAQItem* faqItem = [[FAQItem alloc] initWithDictionary:dictionary];
        [_mFAQList addObject:faqItem];
        [faqItem release];
    }
    
    [objectsFromPlist release];
}

- (void)saveToCash_FAQList
{
    [[self class] saveArray:self.FAQList toCashWithPlistFileName:CASH_FAQ_PLIST];
}

///

#pragma Server updates
#pragma -

- (void)updateFromServer_hospitalsList
{
    CBServerCommunication* serverCommunication = [CBServerCommunication sharedCBServerCommunication];
    serverCommunication.connectionDelegate = self;
    [serverCommunication getAllHospitals];
}

- (void)updateFromServer_articlesList
{
    CBServerCommunication* serverCommunication = [CBServerCommunication sharedCBServerCommunication];
    serverCommunication.connectionDelegate = self;
    [serverCommunication getAllArticles];
}

- (void)updateFromServer_bookletsList
{
    CBServerCommunication* serverCommunication = [CBServerCommunication sharedCBServerCommunication];
    serverCommunication.connectionDelegate = self;
    [serverCommunication getAllBooklets];
}

- (void)updateFromServer_brochuresList
{
    CBServerCommunication* serverCommunication = [CBServerCommunication sharedCBServerCommunication];
    serverCommunication.connectionDelegate = self;
    [serverCommunication getAllAmalBrochures];
}

- (void)updateFromServer_FAQList
{
    CBServerCommunication* serverCommunication = [CBServerCommunication sharedCBServerCommunication];
    serverCommunication.connectionDelegate = self;
    [serverCommunication getAllQuestions];
}
// adel
- (void)updateFromServer_StoriesList{
    CBServerCommunication* serverCommunication = [CBServerCommunication sharedCBServerCommunication];
    serverCommunication.connectionDelegate = self;
    [serverCommunication getAllStories];
}
//adel
#pragma -

- (void)serverAnswerParsed:(NSString*)answer
{
}
- (void)serverAnswerParsedWithArticlesArray:(NSArray*)articlesArray
{
    self.mArticlesList = [NSMutableArray arrayWithArray:articlesArray];
}
//
- (void)serverAnswerParsedWithStoriesArray:(NSArray*)articlesArray
{
    self.mStoriesList = [NSMutableArray arrayWithArray:articlesArray];
}

//
- (void)serverAnswerParsedWithQuestionsArray:(NSArray*)questionsArray
{
    self.mFAQList = [NSMutableArray arrayWithArray:questionsArray];
}
- (void)serverAnswerParsedWithBookletsArray:(NSArray*)bookletsArray
{
    self.mBookletsList = [NSMutableArray arrayWithArray:bookletsArray];
}
- (void)serverAnswerParsedWithAmalBrochuresArray:(NSArray*)brochuresArray
{
    self.mBrochuresList = [NSMutableArray arrayWithArray:brochuresArray];
}
- (void)serverAnswerParsedWithHospitalsArray:(NSArray*)hospitalsArray
{
    self.mHospitalsList = [NSMutableArray arrayWithArray:hospitalsArray];
}
@end
