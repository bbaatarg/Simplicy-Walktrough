//
//  WalktroughView.h
//  CIMS new
//
//  Created by Gonchigsuren Bayraa on 10/1/14.
//  Copyright (c) 2014 bbaatarg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WDataObject.h"
#import "WDataView.h"
#import "WalktroughConfig.h"

@class WalktroughView;

@protocol WalktroughDataSource <NSObject>

- (NSUInteger)numberOfPagesInScrollView;

@end

@protocol WalktroughDelegate <NSObject>

- (WDataObject *)scrollView:(WalktroughView *)scrollView wDataViewForIndex:(NSUInteger)index;
- (WalktroughConfig *)configForScrollView;

-(void)backButtonClicked;

@optional
- (void)scrollViewSizeHasBeenUpdated;

@end

@interface WalktroughView : UIView<UIScrollViewDelegate>
{
    NSInteger currentPageIndex;
    CGSize _screenSize;
    UIView* backgroundView;
}

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *scrollIndicator;
@property (nonatomic,strong) UIButton* skipButton;
@property (nonatomic, weak) id<WalktroughDataSource> dataSource;
@property (nonatomic, weak) id<WalktroughDelegate> delegate;

- (void)createViews;
- (void)updateScrollViewAfterOrientationChangeToPage:(NSUInteger)page;


@end
