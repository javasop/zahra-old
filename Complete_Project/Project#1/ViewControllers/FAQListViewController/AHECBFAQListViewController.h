//
//  HECBFAQListViewController.h
//  HealthEducationBreastCancer
//
//  Created by Irene Berezan on 10.05.12.
//  Copyright (c) 2012 Irene Berezan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HEBCModelManager.h"
#import "AHEBCAbstractTableView.h"

@interface AHECBFAQListViewController : AHEBCAbstractTableView <UITextViewDelegate>
{
    NSArray* _faqList;
    UITextField* _questionTextView;
    UIButton* _textViewImageBackButton;
}

@property (nonatomic, retain, readonly) NSArray* faqList;

@property (weak, nonatomic) IBOutlet UITextField *questionTextView;

@property (nonatomic, retain) IBOutlet UIButton* textViewImageBackButton;

- (IBAction)askQuestion:(id)sender;
@end
