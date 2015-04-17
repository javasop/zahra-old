//
//  MTSNewsDetailsViewController.h
//  MTSFunGuide
//
//  Created by iberezan on 2/14/12.
//  Copyright (c) 2012 Ирочка. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AHEBCAbstractTableView.h"

@class Article;
@class AHEBCArticleDetailsTableViewCell;

@interface AHEBCArticleDetailsViewController : AHEBCAbstractTableView <UIActionSheetDelegate>
{
    Article* _article;
    
    AHEBCArticleDetailsTableViewCell* _newsTableViewCell;
}

@property (nonatomic, retain, readonly) Article* artcle;
@property (nonatomic, retain) IBOutlet  AHEBCArticleDetailsTableViewCell* newsTableViewCell;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil article:(Article*)article;
@end
