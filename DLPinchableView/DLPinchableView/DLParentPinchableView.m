//
//  DLParentPinchableVIew.m
//  DLPinchableView
//
//  Created by Dheina Lundi Ahirsya on 25/11/2016.
//  Copyright © 2016 dheina.com. All rights reserved.
//

#import "DLParentPinchableView.h"

@interface DLParentPinchableView()
<
UIGestureRecognizerDelegate
>

@end


@implementation DLParentPinchableView

float originalScale = 1;


- (id)initWithView:(UIImageView *)src
{
    self = [super init];
    if (self) {
        self.srcView = src;
        [self initialization:src];
    }
    return self;
}

-(void)initialization:(UIImageView *)src
{
    
    [src layoutIfNeeded];
    UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
    CGPoint pointInWindow = [src.superview convertPoint:src.center toView:nil];
    CGPoint pointInScreen = [src.window convertPoint:pointInWindow toWindow:nil];
    
    pointInScreen.x = pointInScreen.x-(src.frame.size.width/2);
    pointInScreen.y = pointInScreen.y-(src.frame.size.height/2);
    
    self.frame = CGRectMake(0, 0, mainWindow.frame.size.width, mainWindow.frame.size.height);
    self.backgroundColor = [UIColor clearColor];
    self.backgroundView = [[UIButton alloc]initWithFrame:self.frame];
    self.backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7f];
    [self.backgroundView addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.backgroundView];
    
    self.originFrame = CGRectMake(pointInScreen.x, pointInScreen.y, src.frame.size.width, src.frame.size.height);
    self.cloneView = [[UIImageView alloc]initWithFrame:self.originFrame];
    self.cloneView.image = src.image;
    self.cloneView.contentMode = src.contentMode;
    self.cloneView.userInteractionEnabled = YES;
    
    [self.cloneView becomeFirstResponder];
    
    [self addSubview:self.cloneView];
    
    [mainWindow addSubview:self];
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:[UIDevice currentDevice]];
}

- (void) orientationChanged:(NSNotification *)note
{
    [self dismiss];
}

-(void)dismiss
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(DLParentPinchableView:onDissmisedFinish:)]){
        [self.delegate DLParentPinchableView:self onDissmisedFinish:NO];
    }
    [UIView animateWithDuration:0.2f animations:^{
                self.cloneView.center = CGPointMake(self.originFrame.origin.x+(self.originFrame.size.width/2),self.originFrame.origin.y+(self.originFrame.size.height/2));
                self.cloneView.transform = CGAffineTransformMakeScale(1, 1);
                self.cloneView.transform = CGAffineTransformMakeRotation(0);
                self.alpha = 1;
    } completion:^(BOOL finished) {
        if(finished){
            if(self.delegate && [self.delegate respondsToSelector:@selector(DLParentPinchableView:onDissmisedFinish:)]){
                [self.delegate DLParentPinchableView:self onDissmisedFinish:YES];
            }
            [self removeFromSuperview];
        }
    }];
}


- (void)handlePanA:(UIPanGestureRecognizer *)recognizer {
    CGPoint translation = [recognizer translationInView:self.cloneView.superview];
    self.cloneView.center = CGPointMake(self.cloneView.center.x + translation.x,
                                         self.cloneView.center.y + translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.cloneView.superview];
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        [self dismiss];
    }
}

-(void)handlePinchA:(UIPinchGestureRecognizer*)recognizer
{
    self.scaleTemp = recognizer.scale;
    self.cloneView.transform = CGAffineTransformScale(self.cloneView.transform, recognizer.scale, recognizer.scale);
    float backgroundAlpha = (self.cloneView.transform.a+(MAX(self.cloneView.transform.b, self.cloneView.transform.c)))-1;
    if(self.cloneView.transform.a<=0){
        backgroundAlpha = ((self.cloneView.transform.a)-1)*-1;
    }
    self.backgroundView.alpha = backgroundAlpha;
    recognizer.scale = 1;
}

- (void)handleRotateA:(UIRotationGestureRecognizer *)recognizer
{
    self.cloneView.transform = CGAffineTransformRotate(self.cloneView.transform, recognizer.rotation);
    recognizer.rotation = 0;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
