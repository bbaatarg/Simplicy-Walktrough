//
//  WalktroughViewController.m
//  CIMS new
//
//  Created by Gonchigsuren Bayraa on 10/1/14.
//  Copyright (c) 2014 bbaatarg. All rights reserved.
//

#import "WalktroughViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface WalktroughViewController ()

@end

@implementation WalktroughViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }
    
    return self;
}

-(instancetype)initWithWalktroughConfig:(WalktroughConfig *)wConfig
{
    self.config=wConfig;
    
    return [self initWithNibName:nil bundle:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //if it have navigationcontroller then hide
    self.navigationController.navigationBarHidden=YES;

    self.walkView = [[WalktroughView alloc] initWithFrame:self.view.bounds];
    
    self.walkView.dataSource = self;
    self.walkView.delegate = self;
    
    [self.walkView createViews];
    [self.view addSubview:self.walkView];
    
}



- (NSUInteger)numberOfPagesInScrollView {
    
    return self.config.colorDataObjects.count;
}

#pragma mark - TNColorScrollViewDelegate methods

- (WDataObject *)scrollView:(WalktroughView *)scrollView wDataViewForIndex:(NSUInteger)index{
    
    return [self.config.colorDataObjects objectAtIndex:index];
    
}

- (WalktroughConfig *)configForScrollView {
    
    return self.config;
    
}

- (void)scrollViewSizeHasBeenUpdated {
    
    self.walkView.scrollView.bounces = YES;
    self.walkView.scrollView.showsHorizontalScrollIndicator = NO;
    self.walkView.scrollView.showsVerticalScrollIndicator = NO;
    self.walkView.scrollView.pagingEnabled = YES;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)backButtonClicked
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end
