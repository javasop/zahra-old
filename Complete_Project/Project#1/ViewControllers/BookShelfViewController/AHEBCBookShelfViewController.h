//
//  HEBCBookShelfViewController.h
//  HealthEducationBreastCancer
//
//  Created by Irene Berezan on 10.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GSBookShelfView.h"
#import "ReaderViewController.h"

@class MyBelowBottomView;

typedef enum {
    AHBOOK_UNSELECTED,
    AHBOOK_SELECTED
}ABookStatus;

@interface AHEBCBookShelfViewController : UIViewController <GSBookShelfViewDelegate, GSBookShelfViewDataSource,ReaderViewControllerDelegate>
{
    GSBookShelfView *_bookShelfView;
    
    NSMutableArray *_bookArray;
    NSMutableArray *_bookStatus;
}

@end


@interface AHEBCBookShelfViewController (Protected) 
- (NSArray*)bookArray;
- (void)updateItems:(id)sender;
@end
