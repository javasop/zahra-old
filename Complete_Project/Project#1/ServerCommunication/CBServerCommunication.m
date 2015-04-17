//
//  PCPServerCommunication.m
//  PureChartPhoto
//
//  Created by Irene Berezan on 12.04.12.
//  Copyright (c) 2012 iFree Ukraine. All rights reserved.
//

#import "CBServerCommunication.h"
#import "ASIFormDataRequest.h"
#import "ASIHTTPRequest.h"

#import "HEBCModelManager.h"

#import "JSON.h"

#import "Hospital.h"
#import "Article.h"
#import "Booklet.h"
#import "Brochure.h"
#import "FAQItem.h"

@interface CBServerCommunication (Private)
- (void)articlesReceivedWithResponseString:(NSString*)response;
- (void)questionsReceivedWithResponseString:(NSString*)response;
- (void)bookletsReceivedWithResponseString:(NSString*)response;
- (void)amalBrochuresReceivedWithResponseString:(NSString*)response;
- (void)hospitalsReceivedWithResponseString:(NSString*)response;
- (void)askQuestionReceivedWithResponseString:(NSString*)response;
//
-(void)storiesReceivedWithResponseString:(NSString*)response;
//
- (void)startGetRequestWithText:(NSString*)requestText tag:(NSUInteger)tag;
@end

@implementation CBServerCommunication

SYNTHESIZE_SINGLETON_FOR_CLASS(CBServerCommunication)

@synthesize connectionDelegate = _connectionDelegate;

#pragma GET REQUESTS
- (void)startGetRequestWithText:(NSString*)text tag:(NSUInteger)tag
{
    NSString* requstText = [NSString stringWithFormat:@"%@%@", kServerHostName, text];
    
    NSLog(@"%@", requstText);
    NSURL *url = [NSURL URLWithString:requstText];
    
    
    thedelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    
    if(thedelegate.isNetworkAvailable){
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    request.tag = tag;
    request.delegate = self;
    request.responseEncoding = NSUTF8StringEncoding;
    request.timeOutSeconds = kServerMaxWaitingTimeInSeconds;
    [request startAsynchronous];
    }
    else{
        return;
    }
}

- (void)getAllArticles
{
    [self startGetRequestWithText:kServerGetAllArticles tag:101];
}

- (void)getAllQuestions
{
    [self startGetRequestWithText:kServerGetAllQuestions tag:102]; 
}

- (void)getAllBooklets
{
    [self startGetRequestWithText:kServerGetAllBooklets tag:103];    
}

- (void)getAllAmalBrochures
{
    [self startGetRequestWithText:kServerGetAllAmalBrochures tag:104];  
}

- (void)getAllHospitals
{
    [self startGetRequestWithText:kServerGetAllHospitals tag:105];   
}


//
-(void)getAllStories{
    [self startGetRequestWithText:kServerGetAllStories tag:106];
}
//

#pragma POST REQUESTS
- (void)postQuestionWithText:(NSString*)questionText
{
    NSString* requstText = [NSString stringWithFormat:@"%@%@%@", kServerHostName,kServerPostQuestionRequest, [questionText stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSLog(@"%@", requstText);
    NSURL *url = [NSURL URLWithString:requstText];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    request.tag = 201;
    request.delegate = self;
    request.timeOutSeconds = kServerMaxWaitingTimeInSeconds;
    request.requestMethod = [NSString stringWithFormat:@"POST"];
    [request startAsynchronous];
}


#pragma -
#pragma Asynchronized requests RECEIVE METHODS
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    
    if (!error)
    {
        NSString *response = [request responseString];
        NSLog(@"response: %@", response);
        
        if ([self.connectionDelegate respondsToSelector:@selector(serverAnswerParsed:)])
        {
            [self.connectionDelegate  serverAnswerParsed:response];
        }
        
        switch (request.tag)
        {
            case 101:
                [self articlesReceivedWithResponseString:response];
                break;
                
            case 102:
                [self questionsReceivedWithResponseString:response];
                break;
                
            case 103:
                [self bookletsReceivedWithResponseString:response];
                break;
            case 104:
                [self amalBrochuresReceivedWithResponseString:response];
                break;
            case 105:
                [self hospitalsReceivedWithResponseString:response];
                break;
            case 106:
                [self storiesReceivedWithResponseString:response];
                break;
            case 201:
                [self askQuestionReceivedWithResponseString:response];
                break;
            default:
                break;
        }
        
        
    }
}


- (NSArray*)arrayWithJSONResponseString:(NSString*)response
{
    SBJsonParser* parser = [[SBJsonParser alloc] init];
    id parserObject = [parser objectWithString:response];
    NSArray* array = nil;
    if (!parserObject)
    {
        NSLog(@"Can't parse server response");
    } 
    else
    {
        array = [NSArray arrayWithArray:(NSArray*)parserObject];
    }
    [parser release];
    return array;
}
- (void)articlesReceivedWithResponseString:(NSString*)response
{
    NSArray* objectsInfo = [self arrayWithJSONResponseString:response];
    if (objectsInfo)
    {
        NSMutableArray* articles = [NSMutableArray new];
        
        for (NSDictionary* dictionary  in objectsInfo)
        {
            Article* article = [[Article alloc] initWithDictionary:dictionary];
            [articles addObject:article];
            [article release];
        }
        
        if ([self.connectionDelegate respondsToSelector:@selector(serverAnswerParsedWithArticlesArray:)])
        {
            [self.connectionDelegate serverAnswerParsedWithArticlesArray:[NSArray arrayWithArray:articles]];
        }
        [articles release];
    }
}


// adel
- (void)storiesReceivedWithResponseString:(NSString*)response
{
    NSArray* objectsInfo = [self arrayWithJSONResponseString:response];
    if (objectsInfo)
    {
        NSMutableArray* articles = [NSMutableArray new];
        
        for (NSDictionary* dictionary  in objectsInfo)
        {
            Article* article = [[Article alloc] initWithDictionary:dictionary];
            [articles addObject:article];
            [article release];
        }
        
        if ([self.connectionDelegate respondsToSelector:@selector(serverAnswerParsedWithStoriesArray:)])
        {
            [self.connectionDelegate serverAnswerParsedWithStoriesArray:[NSArray arrayWithArray:articles]];
        }
        [articles release];
    }
}
// adel
- (void)questionsReceivedWithResponseString:(NSString*)response
{
    NSArray* objectsInfo = [self arrayWithJSONResponseString:response];
    if (objectsInfo)
    {
        NSMutableArray* mFaqList = [NSMutableArray new];
        
        for (NSDictionary* dictionary  in objectsInfo)
        {
            FAQItem* faqItem = [[FAQItem alloc] initWithDictionary:dictionary];
            [mFaqList addObject:faqItem];
            [faqItem release];
        }
        
        if ([self.connectionDelegate respondsToSelector:@selector(serverAnswerParsedWithQuestionsArray:)])
        {
            [self.connectionDelegate serverAnswerParsedWithQuestionsArray:[NSArray arrayWithArray:mFaqList]];
        }
        [mFaqList release];
    }
}

//

- (void)bookletsReceivedWithResponseString:(NSString*)response
{
    NSArray* objectsInfo = [self arrayWithJSONResponseString:response];
    if (objectsInfo)
    {
        NSMutableArray* mBooklets = [NSMutableArray new];
        
        for (NSDictionary* dictionary  in objectsInfo)
        {
            Booklet* booklet = [[Booklet alloc] initWithDictionary:dictionary];
            [mBooklets addObject:booklet];
            [booklet release];
        }
        
        if ([self.connectionDelegate respondsToSelector:@selector(serverAnswerParsedWithBookletsArray:)])
        {
            [self.connectionDelegate serverAnswerParsedWithBookletsArray:[NSArray arrayWithArray:mBooklets]];
        }
        [mBooklets release];
    }
}

- (void)amalBrochuresReceivedWithResponseString:(NSString*)response
{
    NSArray* objectsInfo = [self arrayWithJSONResponseString:response];
    if (objectsInfo)
    {
        NSMutableArray* mBooklets = [NSMutableArray new];
        
        for (NSDictionary* dictionary  in objectsInfo)
        {
            Brochure* booklet = [[Brochure alloc] initWithDictionary:dictionary];
            [mBooklets addObject:booklet];
            [booklet release];
        }
        
        if ([self.connectionDelegate respondsToSelector:@selector(serverAnswerParsedWithAmalBrochuresArray:)])
        {
            [self.connectionDelegate serverAnswerParsedWithAmalBrochuresArray:[NSArray arrayWithArray:mBooklets]];
        }
        [mBooklets release];
    }
}

- (void)hospitalsReceivedWithResponseString:(NSString*)response
{
    NSArray* objectsInfo = [self arrayWithJSONResponseString:response];
    if (objectsInfo)
    {
        NSMutableArray* mHospitals = [NSMutableArray new];
        
        for (NSDictionary* dictionary  in objectsInfo)
        {
            Hospital* hospital = [[Hospital alloc] initWithDictionary:dictionary];
            [mHospitals addObject:hospital];
            [hospital release];
        }
        
        if ([self.connectionDelegate respondsToSelector:@selector(serverAnswerParsedWithHospitalsArray:)])
        {
            [self.connectionDelegate serverAnswerParsedWithHospitalsArray:[NSArray arrayWithArray:mHospitals]];
        }
        [mHospitals release];
    }
}

- (void)askQuestionReceivedWithResponseString:(NSString*)response
{
    SBJsonParser* parser = [[SBJsonParser alloc] init];
    id parserObject = [parser objectWithString:response];
    
    if (!parserObject)
    {
        NSLog(@"Can't parse server response");
    } 
    else
    {
        NSUInteger result = [[(NSDictionary*)parserObject objectForKey:@"inserted"] intValue];
        if (result)
        {
            UIAlertView* nilImageAlert = [[UIAlertView alloc] initWithTitle:@"تأكيد" message:@"تم إرسال سؤالك وسيظهر في حال الإجابة عليه" delegate:nil cancelButtonTitle:@"موافق" otherButtonTitles:nil];
            [nilImageAlert show];
            [nilImageAlert release];
            [[HEBCModelManager sharedHEBCModelManager] updateFromServer_FAQList];
        }
        else
        {
            UIAlertView* nilImageAlert = [[UIAlertView alloc] initWithTitle:@"خطأ" message: @"لم يتم إرسال السؤال ، الرجاء المحاولة مرة أخرى" delegate:nil cancelButtonTitle:@"موافق" otherButtonTitles:nil];
            [nilImageAlert show];
            [nilImageAlert release];
        }
    }
    [parser release];
}


@end
