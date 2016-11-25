//
//  ViewController.m
//  DLPinchableView
//
//  Created by Dheina Lundi Ahirsya on 24/11/2016.
//  Copyright © 2016 dheina.com. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.scrollView addSubview:self.viewCat];
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:[UIDevice currentDevice]];
}

-(void)resizeUI
{
    [self.scrollView layoutIfNeeded];
    self.viewCat.frame = CGRectMake(0, 0, self.scrollView.frame.size.width, self.viewCat.frame.size.height);
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width, self.viewCat.frame.size.height)];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self resizeUI];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) orientationChanged:(NSNotification *)note
{
    [self resizeUI];
}


@end
