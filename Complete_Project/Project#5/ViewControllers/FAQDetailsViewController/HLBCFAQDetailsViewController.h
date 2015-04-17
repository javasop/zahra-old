//
//  MTSNewsDetailsViewController.h
//  MTSFunGuide
//
//  Created by iberezan on 2/14/12.
//  Copyright (c) 2012 Ирочка. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HLBCAbstractTableView.h"

@class FAQItem;
@class HLBCArticleDetailsTableViewCell;

@interface HLBCFAQDetailsViewController : HLBCAbstractTableView <UIActionSheetDelegate>
{
    FAQItem* _question;
    
    HLBCArticleDetailsTableViewCell* _newsTableViewCell;
}

@property (nonatomic, retain, readonly) FAQItem* question;
@property (nonatomic, retain) IBOutlet  HLBCArticleDetailsTableViewCell* newsTableViewCell;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil question:(FAQItem*)question;

@end
