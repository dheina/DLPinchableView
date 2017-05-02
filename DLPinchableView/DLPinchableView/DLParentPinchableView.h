//
//  DLParentPinchableVIew.h
//  DLPinchableView
//
//  Created by Dheina Lundi Ahirsya on 25/11/2016.
//  Copyright © 2016 dheina.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DLParentPinchableView;

@protocol DLParentPinchableViewDelegate <NSObject>
@optional
-(void)DLParentPinchableView:(DLParentPinchableView*)view onDissmisedFinish:(BOOL)finished;

@end

@interface DLParentPinchableView : UIView

- (id)initWithView:(UIImageView *)src;
-(void)dismiss;

- (void)handlePanA:(UIPanGestureRecognizer *)recognizer;

-(void)handlePinchA:(UIPinchGestureRecognizer*)recognizer;

- (void)handleRotateA:(UIRotationGestureRecognizer *)recognizer;

@property(nonatomic, weak) id<DLParentPinchableViewDelegate> delegate;
@property(nonatomic, weak) UIImageView *srcView;
@property(nonatomic, strong) UIImageView *cloneView;
@property(nonatomic, strong) UIButton *backgroundView;

@property(nonatomic) CGRect originFrame;
@property(nonatomic) float scaleTemp;



@end