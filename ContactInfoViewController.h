//
//  ContactInfoViewController.h
//  Complete_Project
//
//  Created by adel alahmed on 11/24/12.
//  Copyright (c) 2012 nitin.gupta@ongraph.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ContactInfoViewController : UIViewController
{
    IBOutlet UIImageView *large_bright, *small_bright, *large_dim, *small_dim;
    NSString *city_name;
    IBOutlet UIImageView *image_placeholder;
    UIImage *img;
}

@property (nonatomic,retain) IBOutlet UIImageView *large_bright;

@property (nonatomic,retain) IBOutlet UIImageView *small_bright;

@property (nonatomic,retain) IBOutlet UIImageView *large_dim;

@property (nonatomic,retain) IBOutlet UIImageView *small_dim;
@property (nonatomic, retain) NSString *city_name;
@property (nonatomic, retain) IBOutlet UIImageView *image_placeholder;
@property (nonatomic, retain) UIImage *img;



@end
