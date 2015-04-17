//
//  BanksTableViewCell.h
//  Complete_Project
//
//  Created by Rebecca Sable on 6/28/14.
//  Copyright (c) 2014 nitin.gupta@ongraph.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BanksTableViewCell : UITableViewCell <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *bank_image;

@property (weak, nonatomic) IBOutlet UITextView *bank_iban;




- (void)setbImage:(UIImage *)image;

- (void)setbIban:(NSString *)iban;




@end
