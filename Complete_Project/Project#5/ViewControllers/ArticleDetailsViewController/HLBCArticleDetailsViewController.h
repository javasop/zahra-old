//
//  MTSNewsDetailsViewController.h
//  MTSFunGuide
//
//  Created by iberezan on 2/14/12.
//  Copyright (c) 2012 Ирочка. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLBCAbstractTableView.h"

@class Article;
@class HLBCArticleDetailsTableViewCell;

@interface HLBCArticleDetailsViewController : HLBCAbstractTableView <UIActionSheetDelegate>
{
    Article* _article;
    
    HLBCArticleDetailsTableViewCell* _newsTableViewCell;
}

@property (nonatomic, retain, readonly) Article* artcle;
@property (nonatomic, retain) IBOutlet  HLBCArticleDetailsTableViewCell* newsTableViewCell;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil article:(Article*)article;
@end
