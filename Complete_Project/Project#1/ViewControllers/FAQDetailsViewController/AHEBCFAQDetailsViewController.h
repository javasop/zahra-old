//
//  MTSNewsDetailsViewController.h
//  MTSFunGuide
//
//  Created by iberezan on 2/14/12.
//  Copyright (c) 2012 Ирочка. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AHEBCAbstractTableView.h"

@class FAQItem;
@class AHEBCArticleDetailsTableViewCell;

@interface AHEBCFAQDetailsViewController : AHEBCAbstractTableView <UIActionSheetDelegate>
{
    FAQItem* _question;
    
    AHEBCArticleDetailsTableViewCell* _newsTableViewCell;
}

@property (nonatomic, retain, readonly) FAQItem* question;
@property (nonatomic, retain) IBOutlet  AHEBCArticleDetailsTableViewCell* newsTableViewCell;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil question:(FAQItem*)question;
@end
