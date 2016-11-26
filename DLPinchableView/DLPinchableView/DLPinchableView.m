//
//  DLPinchableView.m
//  DLPinchableView
//
//  Created by Dheina Lundi Ahirsya on 24/11/2016.
//  Copyright © 2016 dheina.com. All rights reserved.
//

#import "DLPinchableView.h"

@interface DLPinchableView()
<
UIGestureRecognizerDelegate,
DLParentPinchableViewDelegate
>

@end

@implementation DLPinchableView
@synthesize parentView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialization];
        [UIImage imageNamed:@"ImgCat1"];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self initialization];
    }
    return self;
}

-(void)initialization
{

    self.userInteractionEnabled = YES;
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(handlePinch:)];
    pinchGesture.delegate = self;
    [self addGestureRecognizer:pinchGesture];
    
    UIRotationGestureRecognizer *rotateGesture = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(handleRotate:)];
    rotateGesture.delegate = self;
    [self addGestureRecognizer:rotateGesture];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
    panGesture.delegate = self;
    [self addGestureRecognizer:panGesture];
    
}

- (IBAction)handlePan:(UIPanGestureRecognizer *)recognizer {
    [self.parentView handlePanA:recognizer];
}

- (IBAction)handlePinch:(UIPinchGestureRecognizer *)recognizer {
    [self duplicateCurrentView];
    [self.parentView handlePinchA:recognizer];
    self.alpha = 0;
}

- (IBAction)handleRotate:(UIRotationGestureRecognizer *)recognizer {
    [self.parentView handleRotateA:recognizer];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}


-(void)duplicateCurrentView
{
    if (!parentView) {
        parentView = [[DLParentPinchableView alloc] initWithView:self];
        parentView.delegate = self;
        [self setParent:self.superview userInteraction:NO];
    }
}


#pragma mark DLParentPinchableVIew

-(void)DLParentPinchableView:(DLParentPinchableView*)view onDissmisedFinish:(BOOL)finished
{
    if(finished){
        self.alpha = 1;
        parentView = nil;
        [self setParent:self.superview userInteraction:YES];
    }
}

-(void)setParent:(UIView*)view userInteraction:(BOOL)enable
{
    if(view.superview){
        view.superview.userInteractionEnabled = enable;
        if([view.superview isKindOfClass:[UIScrollView class]]){
            [(UIScrollView*)view.superview setScrollEnabled:enable];
        }
        if(view.superview.superview){
            [self setParent:view.superview.superview userInteraction:enable];
        }
    }
}


@end


