//
//  MTSNewsDetailsViewController.h
//  MTSFunGuide
//
//  Created by iberezan on 2/14/12.
//  Copyright (c) 2012 Ирочка. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HEBCAbstractTableView.h"

@class Article;
@class HEBCArticleDetailsTableViewCell;

@interface HEBCArticleDetailsViewController : HEBCAbstractTableView <UIActionSheetDelegate>
{
    Article* _article;
    
    HEBCArticleDetailsTableViewCell* _newsTableViewCell;
}

@property (nonatomic, retain, readonly) Article* artcle;
@property (nonatomic, retain) IBOutlet  HEBCArticleDetailsTableViewCell* newsTableViewCell;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil article:(Article*)article;
@end
