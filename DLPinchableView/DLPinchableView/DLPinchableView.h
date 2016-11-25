//
//  DLPinchableView.h
//  DLPinchableView
//
//  Created by Dheina Lundi Ahirsya on 24/11/2016.
//  Copyright © 2016 dheina.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLParentPinchableView.h"

@interface DLPinchableView : UIImageView

@property(nonatomic, readonly, strong) DLParentPinchableView *parentView;

@end