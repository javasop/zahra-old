//
//  MTSPlacesTableViewCell.h
//  MTSFunGuide
//
//  Created by iberezan on 2/6/12.
//  Copyright (c) 2012 iFree Ukraine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLBCArticleDetailsTableViewCell : UITableViewCell
{
    UILabel* _titleLabel;
    UITextField* _detailInfoTextField;
    UITextView* _fullDescriptionTextView;
    UILabel* _dateLabel;
    
    UIImageView * _smallImageView;
    UITextField* _sourceTextField;
}

@property (nonatomic, retain) IBOutlet UILabel* titleLabel;
@property (nonatomic, retain) IBOutlet UITextField* detailInfoTextField;
@property (nonatomic, retain) IBOutlet UITextView* fullDescriptionTextView;
@property (nonatomic, retain) IBOutlet UILabel* dateLabel;
@property (nonatomic, retain) IBOutlet UITextField* sourceTextField;

@property (nonatomic, retain) IBOutlet UIImageView * smallImageView;
@end
