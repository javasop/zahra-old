//
//  HECBFAQListViewController.h
//  HealthEducationBreastCancer
//
//  Created by Irene Berezan on 10.05.12.
//  Copyright (c) 2012 Irene Berezan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HEBCModelManager.h"
#import "HEBCAbstractTableView.h"

@interface HECBFAQListViewController : HEBCAbstractTableView <UITextViewDelegate>
{
    NSArray* _faqList;
    
    UITextView* _questionTextView;
    UIButton* _textViewImageBackButton;
}

@property (nonatomic, retain, readonly) NSArray* faqList;

@property (nonatomic, retain) IBOutlet UITextView* questionTextView;
@property (nonatomic, retain) IBOutlet UIButton* textViewImageBackButton;

- (IBAction)askQuestion:(id)sender;
@end
