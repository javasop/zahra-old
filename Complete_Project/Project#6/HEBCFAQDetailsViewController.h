//
//  MTSNewsDetailsViewController.h
//  MTSFunGuide
//
//  Created by iberezan on 2/14/12.
//  Copyright (c) 2012 Ирочка. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HEBCAbstractTableView.h"

@class FAQItem;
@class HEBCArticleDetailsTableViewCell;

@interface HEBCFAQDetailsViewController : HEBCAbstractTableView <UIActionSheetDelegate>
{
    FAQItem* _question;
    
    HEBCArticleDetailsTableViewCell* _newsTableViewCell;
}

@property (nonatomic, retain, readonly) FAQItem* question;
@property (nonatomic, retain) IBOutlet  HEBCArticleDetailsTableViewCell* newsTableViewCell;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil question:(FAQItem*)question;
@end
