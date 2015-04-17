//
//  HEBCViewController.h
//  HealthEducationBreastCancer
//
//  Created by Irene Berezan on 04.05.12.
//  Copyright (c) 2012 Irene Berezan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "GlobalConsts.h"
#import "StoryBookViewController.h"

@class StoryBookViewController;

@interface HEBCViewController : UIViewController{
    IBOutlet UIImageView *large_bright, *large_dim, *small_bright, *small_dim; 
}
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *image_text;

@property (nonatomic, retain) IBOutlet UIImageView *large_bright; 
@property (nonatomic, retain) IBOutlet UIImageView *large_dim;
@property (nonatomic, retain) IBOutlet UIImageView *small_bright;
@property (nonatomic, retain) IBOutlet UIImageView *small_dim;
@property (strong, nonatomic) StoryBookViewController *bok;



- (IBAction)openFAQ:(id)sender;
- (IBAction)openSelfExam:(id)sender;
- (IBAction)openArticles:(id)sender;
- (IBAction)openLibrary:(id)sender;
- (IBAction)openHospitalsList:(id)sender;
- (IBAction)openBroshures:(id)sender;
@end
