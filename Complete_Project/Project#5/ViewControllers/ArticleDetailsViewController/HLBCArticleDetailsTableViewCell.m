//
//  MTSPlacesTableViewCell.m
//  MTSFunGuide
//
//  Created by iberezan on 2/6/12.
//  Copyright (c) 2012 iFree Ukraine. All rights reserved.
//

#import "HLBCArticleDetailsTableViewCell.h"

@implementation HLBCArticleDetailsTableViewCell

@synthesize titleLabel = _titleLabel;
@synthesize detailInfoTextField = _detailInfoTextField;
@synthesize dateLabel = _dateLabel;
@synthesize smallImageView = _smallImageView;

@synthesize fullDescriptionTextView = _fullDescriptionTextView;
@synthesize sourceTextField = _sourceTextField;

- (void)dealloc
{
    [_titleLabel release];
    [_detailInfoTextField release];
    [_dateLabel release];
    
    [_smallImageView release];
    [_fullDescriptionTextView release];
    [_sourceTextField release];
    
    [super dealloc];
}


@end
