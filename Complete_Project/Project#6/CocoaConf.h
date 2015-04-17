//
//  CocoaConf.h
//  IntroducingCollectionViews
//
//  Created by Mark Pospesel on 10/8/12.
//  Copyright (c) 2012 Mark Pospesel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StacksLayout.h"
#import "HEBCModelManager.h"
#import "AppDelegate.h"




@interface CocoaConf : NSObject<UICollectionViewDataSource>{
    
    AppDelegate *thedelegate;

    
}

@property (strong, nonatomic) NSDictionary *bookletDetail;
@property (nonatomic, strong) NSArray *conferences;


+ (CocoaConf *)combined;
+ (CocoaConf *)all:(NSString*)type;
+ (CocoaConf *)currentCocoaConf;
+ (CocoaConf *)recent;

+ (NSString *)smallHeaderReuseID;

- (BOOL)deleteSpeakerAtPath:(NSIndexPath *)indexPath;
- (BOOL)restoreSpeakerInSection:(int)section;

@end
