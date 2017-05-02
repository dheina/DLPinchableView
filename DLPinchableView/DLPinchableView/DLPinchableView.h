//
//  DLPinchableView.h
//  DLPinchableView
//
//  Created by Dheina Lundi Ahirsya on 24/11/2016.
//  Copyright © 2016 dheina.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLParentPinchableView.h"

@class DLPinchableView;

@protocol DLPinchableViewDelegate <NSObject>
@optional

-(void)DLPinchableViewOnTapped:(DLPinchableView*)view;
-(void)DLPinchableViewOnPinchStart:(DLPinchableView*)view;
-(void)DLPinchableViewOnPinchDone:(DLPinchableView*)view;

@end

@interface DLPinchableView : UIImageView

@property(nonatomic, readonly, strong) DLParentPinchableView *parentView;
@property(nonatomic, weak) id<DLPinchableViewDelegate> delegate;

@end