//
//  BanksTableViewCell.m
//  Complete_Project
//
//  Created by Rebecca Sable on 6/28/14.
//  Copyright (c) 2014 nitin.gupta@ongraph.com. All rights reserved.
//

#import "BanksTableViewCell.h"

@implementation BanksTableViewCell

@synthesize bank_iban,bank_image;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setbImage:(UIImage *)image
{

    self.bank_image.image = image;
}

- (void)setbIban:(NSString *)iban
{

    self.bank_iban.text = iban;
    
}


@end
