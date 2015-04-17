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

@class AboutAmalGroupViewController;

@interface AHEBCViewController : UIViewController{

 IBOutlet UIImageView *large_bright, *large_dim, *small_bright, *small_dim;     
}


@property (nonatomic, retain) IBOutlet UIImageView *large_bright; 
@property (nonatomic, retain) IBOutlet UIImageView *large_dim;
@property (nonatomic, retain) IBOutlet UIImageView *small_bright;
@property (nonatomic, retain) IBOutlet UIImageView *small_dim; 

@property (strong, nonatomic) AboutAmalGroupViewController *aagvc;

- (IBAction)openFAQ:(id)sender;
- (IBAction)openSelfExam:(id)sender;
- (IBAction)openArticles:(id)sender;
- (IBAction)openLibrary:(id)sender;
- (IBAction)openHospitalsList:(id)sender;
- (IBAction)openBroshures:(id)sender;
- (IBAction)openAbout:(id)sender;

@end
