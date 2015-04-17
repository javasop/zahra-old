//
//  ViewController.m
//  IntroducingCollectionViews
//
//  Created by Mark Pospesel on 10/4/12.
//  Copyright (c) 2012 Mark Pospesel. All rights reserved.
//

#import "StoryBookViewController.h"
#import "SpeakerCell.h"
#import "GridLayout.h"
#import "LineLayout.h"
#import "CoverFlowLayout.h"
#import "StacksLayout.h"
#import "SpiralLayout.h"
#import "ConferenceHeader.h"
#import "HEBCModelManager.h"
#import "CocoaConf.h"



@interface StoryBookViewController ()

@property (nonatomic, assign) SpeakerLayout layoutStyle;

@end

@implementation StoryBookViewController

@synthesize type;

- (id)init
{
    self = [super init];
    if (self)
    {
        [self doInit];
    }
    return self;
}
- (id)initWithType:(NSString*)type
{
    self = [super init];
    
    self.type = type;
    
    if (self)
    {
        [self doInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self doInit];
    }
    return self;
}

- (id)initWithCollectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithCollectionViewLayout:layout];
    if (self)
    {
        [self doInit];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        [self doInit];
    }
    return self;
}

- (void)doInit
{
    _layoutStyle = SpeakerLayoutGrid;
}

- (void)viewDidLoad
{

    [super viewDidLoad];
    


}
-(void)viewWillAppear:(BOOL)animated{
    
    [self.collectionView setCollectionViewLayout:[[GridLayout alloc] init]];
    
    
    [self.collectionView setDataSource:[CocoaConf all:self.type]];
    
    [self.collectionView reloadData];
    
    self.collectionView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Wood-Planks"]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setLayoutStyle:(SpeakerLayout)layoutStyle animated:(BOOL)animated
{
    if (layoutStyle == self.layoutStyle)
        return;
    
    UICollectionViewLayout *newLayout = nil;
    BOOL delayedInvalidate = NO;
    
    switch (layoutStyle)
    {
        case SpeakerLayoutGrid:
            newLayout = [[GridLayout alloc] init];
            break;
            
        case SpeakerLayoutLine:
            newLayout = [[LineLayout alloc] init];
            delayedInvalidate = YES;
            break;
            
        case SpeakerLayoutCoverFlow:
            newLayout = [[CoverFlowLayout alloc] init];
            delayedInvalidate = YES;
            break;
            
        case SpeakerLayoutStacks:
            newLayout = [[StacksLayout alloc] init];
            break;
            
        case SpeakerLayoutSpiral:
            newLayout = [[SpiralLayout alloc] init];
            break;
            
        default:
            break;
    }
    
    if (!newLayout)
        return;
    
    self.layoutStyle = layoutStyle;
    [self.collectionView setCollectionViewLayout:newLayout animated:animated];
    self.collectionView.pagingEnabled = (layoutStyle == SpeakerLayoutSpiral);
    
    if (delayedInvalidate)
    {
        [self.collectionView.collectionViewLayout performSelector:@selector(invalidateLayout) withObject:nil afterDelay:0.4];
    }
    
    // WORKAROUND: There's a UICollectionView bug where the supplementary views from StacksLayout are leftover and remain in other layouts
    /*if (layoutStyle != SpeakerLayoutStacks)
     {
     NSMutableArray *leftoverViews = [NSMutableArray array];
     for (UIView *subview in self.collectionView.subviews)
     {
     // Find all the leftover supplementary views
     if ([subview isKindOfClass:[SmallConferenceHeader class]])
     {
     [leftoverViews addObject:subview];
     }
     }
     
     // remove them from the view hierarchy
     for (UIView *subview in leftoverViews)
     [subview removeFromSuperview];
     }*/
}

- (BOOL)layoutSupportsInsert
{
    return self.layoutStyle == SpeakerLayoutSpiral;
}

- (BOOL)layoutSupportsDelete
{
    return self.layoutStyle == SpeakerLayoutSpiral;
}

#pragma mark - UIGestureRecognizerDelegate methods

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{

    if ([gestureRecognizer isKindOfClass:[UIPinchGestureRecognizer class]])
    {
        // recognize pinch gesture only if we're in stacks layout and pinch is on a stack
        if (self.layoutStyle != SpeakerLayoutStacks)
            return NO;
        
        CGPoint touchPoint = [touch locationInView:self.collectionView];
        NSIndexPath* cellPath = [self.collectionView indexPathForItemAtPoint:touchPoint];
        return cellPath != nil;
    }
    else if ([gestureRecognizer isKindOfClass:[UISwipeGestureRecognizer class]])
    {
        // recognize swipe gesture only if we're in a layout that supports delete
        if (![self layoutSupportsDelete])
            return NO;
        
        CGPoint touchPoint = [touch locationInView:self.collectionView];
        NSIndexPath* cellPath = [self.collectionView indexPathForItemAtPoint:touchPoint];
        return cellPath != nil;
    }
    
    return YES;
}

#pragma mark - Touch gesture


//recognize that an image is selected?
- (void)handleTap:(UITapGestureRecognizer *)gestureRecognizer
{
    
    //NSArray *indexPaths = [self.collectionView indexPathsForSelectedItems];

    
    CGPoint point = [gestureRecognizer locationInView:self.collectionView];
    
    int sectionCount = [self.collectionView numberOfSections];

    for (int section = 0; section < sectionCount; section++)
    {
        NSString *kind = (self.layoutStyle == SpeakerLayoutStacks)? [SmallConferenceHeader kind] : UICollectionElementKindSectionHeader;
        UICollectionViewLayoutAttributes *attributes = [self.collectionView.collectionViewLayout layoutAttributesForSupplementaryViewOfKind:kind atIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
        
        if (attributes)
        {
            if (CGRectContainsPoint(attributes.frame, point))
            {
                //how to know what item was selcted?
                int speakerCount = [self.collectionView numberOfItemsInSection:section];
                id cocoaConf = self.collectionView.dataSource;
//                if ([cocoaConf restoreSpeakerInSection:section])
//                {
//                    // WORKAROUND: inserting cell to empty section often yields NSInternalInconsistencyException in UICollectionView
//                    // we'll just call reloadData instead
////                    if (speakerCount == 0)
////                        [self.collectionView reloadData];
////                    else
////                        [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:speakerCount inSection:section]]];
//                }
                
                break;
            }
        }
    }
}

- (void)handle2FingerTap:(UITapGestureRecognizer *)gestureRecognizer
{
    SpeakerLayout newLayout = self.layoutStyle + 1;
    if (newLayout >= SpeakerLayoutCount)
        newLayout = 0;
    [self setLayoutStyle:newLayout animated:YES];
}

- (void)handle3FingerTap:(UITapGestureRecognizer *)gestureRecognizer
{
    SpeakerLayout newLayout = self.layoutStyle - 1;
    if ((int)newLayout < 0)
        newLayout = SpeakerLayoutCount - 1;
    [self setLayoutStyle:newLayout animated:YES];
}

- (void)handlePinch:(UIPinchGestureRecognizer *)gestureRecognizer
{
    StacksLayout *stacksLayout = (StacksLayout *)self.collectionView.collectionViewLayout;
    
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan)
    {
        CGPoint initialPinchPoint = [gestureRecognizer locationInView:self.collectionView];
        NSIndexPath* pinchedCellPath = [self.collectionView indexPathForItemAtPoint:initialPinchPoint];
        if (pinchedCellPath)
            [stacksLayout setPinchedStackIndex:pinchedCellPath.section];
    }
    else if (stacksLayout.pinchedStackIndex >= 0)
    {
        if (gestureRecognizer.state == UIGestureRecognizerStateChanged)
        {
            stacksLayout.pinchedStackScale = gestureRecognizer.scale;
            stacksLayout.pinchedStackCenter = [gestureRecognizer locationInView:self.collectionView];
        }
        
        else
        {
            if (stacksLayout.pinchedStackScale > 2.5)
            {
                // switch to GridLayout
                [self setLayoutStyle:SpeakerLayoutGrid animated:YES];
            }
            else
            {
                // collapse items back into stack
                
                // WORKAROUND: There's a UICollectionView bug where the supplementary views are leftover after animation completes
                NSMutableArray *leftoverViews = [NSMutableArray array];
                for (UIView *subview in self.collectionView.subviews)
                {
                    // Find all the supplementary views
                    if ([subview isKindOfClass:[SmallConferenceHeader class]])
                    {
                        [leftoverViews addObject:subview];
                    }
                }
                
                stacksLayout.collapsing = YES;
                [self.collectionView performBatchUpdates:^{
                    stacksLayout.pinchedStackIndex = -1;
                    stacksLayout.pinchedStackScale = 1.0;
                } completion:^(BOOL finished) {
                    stacksLayout.collapsing = NO;
                    // manually remove leftover supplementary views from the view hierarchy
                    for (UIView *subview in leftoverViews)
                        [subview removeFromSuperview];
                }];
            }
        }
    }
}

- (void)handleSwipeUp:(UISwipeGestureRecognizer *)gestureRecognizer
{
//    if (![self layoutSupportsDelete])
//        return;
//    
//    CGPoint startPoint = [gestureRecognizer locationInView:self.collectionView];
//    NSIndexPath* cellPath = [self.collectionView indexPathForItemAtPoint:startPoint];
//    if (cellPath)
//    {
//        CocoaConf *cocoaConf = (CocoaConf *)self.collectionView.dataSource;
//        int speakerCount = [self.collectionView numberOfItemsInSection:cellPath.section];
//        if ([cocoaConf deleteSpeakerAtPath:cellPath])
//        {
//            // WORKAROUND: deleting last cell from section often yields NSInternalInconsistencyException in UICollectionView
//            // we'll just call reloadData instead
//            if (speakerCount <= 1)
//                [self.collectionView reloadData];
//            else
//                [self.collectionView deleteItemsAtIndexPaths:@[cellPath]];
//        }
//    }
}

//UI Collectionview delegate methods
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    int selected = indexPath.item;
    CocoaConf *cocoa = self.collectionView.dataSource;
    
    NSArray *t = cocoa.conferences;
    
    NSDictionary *dic = t[indexPath.section][indexPath.item];
    
    
    NSURL *pdf_url = [dic objectForKey:@"pdf_file"];
    NSString *pdf_string = [dic objectForKey:@"pdf_file"];

    
    
    
        NSArray *documentsPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString* filaPath = [[documentsPaths objectAtIndex:0]
                              stringByAppendingPathComponent:[pdf_url lastPathComponent]];
    
        NSLock* lock = [[NSLock alloc] init];
        [lock lock];
        {
            NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:pdf_string]];
            [data writeToFile:filaPath atomically:YES];
        }
        [lock unlock];
    
    
        ReaderDocument *document = [ReaderDocument withDocumentFilePath:filaPath password:nil];
    
    	if (document != nil) // Must have a valid ReaderDocument object in order to proceed with things
    	{
    		ReaderViewController *readerViewController = [[ReaderViewController alloc] initWithReaderDocument:document];

    		readerViewController.delegate = self; // Set the ReaderViewController delegate to self
    
    
    		[self.navigationController pushViewController:readerViewController animated:YES];
    
    	}
    


    
    
    

    
}



@end
