//
//  ViewController.m
//  testviews
//
//  Created by Jamie Ly on 6/23/14.
//  Copyright (c) 2014 Jamie Ly. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIGestureRecognizerDelegate>
@property (nonatomic, strong) IBOutlet UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UIView *topView;
@property (nonatomic, assign) BOOL pulledUp;
@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
    [self initScrollViewOffset];
}

// Called when a user pans
- (IBAction)handlePan: (UIPanGestureRecognizer*) panGestureRecognizer {
    CGFloat velocity = [self verticalPanVelocity: panGestureRecognizer];
    if(![self isPanVelocitySufficientToToggleViews: velocity]) return;
    
    if(velocity > 0) {
        [self pullDown];
    } else {
        [self pullUp];
    }
    
}

// Performs initialization of the scroll content offset to show only the primary view
- (void) initScrollViewOffset {
    self.scrollView.contentOffset = CGPointMake(0,
                                                self.topView.frame.size.height);
    self.pulledUp = YES;
}

// Toggles the position of the scroll content offset using the secondary view height
- (void) toggleViewContentOffset: (BOOL) positiveOffset {
    self.scrollView.contentOffset = CGPointMake(0,
                                                self.scrollView.contentOffset.y +
                                                self.topView.frame.size.height * (positiveOffset ? 1 : -1));
}

// Called when the user pans down
- (void) pullDown {
    if(!self.pulledUp) return;
    
    NSLog(@"Pull down");
    [self toggleViewContentOffset: NO];
    self.pulledUp = NO;
}


// Called when the user pans up
- (void) pullUp {
    if(self.pulledUp) return;
    
    NSLog(@"Pull up");
    [self toggleViewContentOffset: YES];
    self.pulledUp = YES;
}

// Extracts the vertical pan velocity from the gesture recognizer
- (CGFloat) verticalPanVelocity: (UIPanGestureRecognizer*) panGestureRecognizer {
    return [panGestureRecognizer velocityInView: self.view].y;
}

// Determines if the user is panning fast enough
- (BOOL) isPanVelocitySufficientToToggleViews: (CGFloat) verticalVelocity {
    return ABS(verticalVelocity) > 2000;
}

@end
