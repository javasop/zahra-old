//
//  ViewController.h
//  IntroducingCollectionViews
//
//  Created by Mark Pospesel on 10/4/12.
//  Copyright (c) 2012 Mark Pospesel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReaderViewController.h"


enum {
    SpeakerLayoutGrid,
    SpeakerLayoutLine,
    SpeakerLayoutCoverFlow,
    SpeakerLayoutStacks,
    SpeakerLayoutSpiral,
    
    SpeakerLayoutCount
}
typedef SpeakerLayout;

@interface StoryBookViewController : UICollectionViewController<UICollectionViewDelegate, UICollectionViewDataSource,ReaderViewControllerDelegate>

@property (nonatomic, assign, readonly) SpeakerLayout layoutStyle;
@property (nonatomic, strong) NSString *type;


@end
