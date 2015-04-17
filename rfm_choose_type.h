//
//  rfm_choose_type.h
//  Complete_Project
//
//  Created by adel alahmed on 12/10/12.
//  Copyright (c) 2012 nitin.gupta@ongraph.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface rfm_choose_type : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource>{

    IBOutlet UIPickerView *picker;
    NSMutableDictionary *dic;
}

@property(nonatomic, retain) IBOutlet UIPickerView *picker;
@property (nonatomic, retain) NSMutableDictionary *dic;
@end
