//
//  PCPServerCommunication.h
//  PureChartPhoto
//
//  Created by Irene Berezan on 12.04.12.
//  Copyright (c) 2012 iFree Ukraine. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ASIHTTPRequest.h"

#import "SynthesizeSingleton.h"

#import "AppDelegate.h"

// This class assemblies all about communication with server
// Uses asynchronized requsets
// Some other request could be simply added there

@protocol ASIHTTPRequestDelegate;
@protocol PCPServerCommunicationDelegate;


// Host name & request parameters &  success response text are setting there, as constants
static NSString* const kServerHostName = @"http://www.galamr.com/services/index.php/welcome/";

static NSString* const kServerGetAllArticles = @"get_all_articles";
static NSString* const kServerGetAllQuestions = @"get_all_questions";
static NSString* const kServerGetAllBooklets = @"get_all_booklets";
static NSString* const kServerGetAllAmalBrochures = @"get_all_amal_brochures";
static NSString* const kServerGetAllHospitals = @"hospitals_list_json";
//
static NSString* const kServerGetAllStories = @"get_all_stories";
//
static NSString* const kServerPostQuestionRequest = @"ask_question?&q=";
static NSString* const kServerPostQuestionRequestTextParameter = @"question";

static const NSTimeInterval kServerMaxWaitingTimeInSeconds = 20;

@interface CBServerCommunication : NSObject <ASIHTTPRequestDelegate>
{
    id <PCPServerCommunicationDelegate> _connectionDelegate;
    AppDelegate *thedelegate;

}

+ (CBServerCommunication*)sharedCBServerCommunication;
@property (nonatomic, assign) id <PCPServerCommunicationDelegate> connectionDelegate;

- (void)getAllArticles;
// returns list of all articles. 

- (void)getAllQuestions;
// returns list of all questions.

- (void)getAllBooklets;
// returns a list of all booklets. 

- (void)getAllAmalBrochures;
// returns list of all brochures.

- (void)getAllHospitals;
// returns list of all brochures.

//adel
-(void) getAllStories;
// returns list of all stories;
//

- (void)postQuestionWithText:(NSString*)questionText;
// posts new question to the server. 

@end


@protocol PCPServerCommunicationDelegate <NSObject>
// redirect received from server answer to delegate object for parsing
@optional
- (void)serverAnswerParsed:(NSString*)answer;
- (void)serverAnswerParsedWithArticlesArray:(NSArray*)articlesArray;
- (void)serverAnswerParsedWithQuestionsArray:(NSArray*)questionsArray;
- (void)serverAnswerParsedWithBookletsArray:(NSArray*)bookletsArray;
- (void)serverAnswerParsedWithAmalBrochuresArray:(NSArray*)brochuresArray;
- (void)serverAnswerParsedWithHospitalsArray:(NSArray*)hospitalsArray;
//
- (void)serverAnswerParsedWithStoriesArray:(NSArray*)storiesArray;
//
- (void)serverAnswerParsedWithAskQuestionResult:(BOOL)success;
@end
