//
//  WalktroughView.m
//  CIMS new
//
//  Created by Gonchigsuren Bayraa on 10/1/14.
//  Copyright (c) 2014 bbaatarg. All rights reserved.
//

#import "WalktroughView.h"
#import "WalktroughDefinitions.h"
#import "CoDesignHelper.h"

@implementation WalktroughView
#pragma mark - Lifecycle

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self ) {
        
        _screenSize = frame.size;
        [self createScrollView];
        
    }
    
    return self;
}

#pragma mark - NSCopying

#pragma mark - Private methods
- (void)createScrollView {
    
    backgroundView = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:backgroundView];

    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.scrollView.backgroundColor=[UIColor clearColor];
    self.scrollView.delegate=self;
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:self.scrollView];
    
    self.scrollIndicator=[[UIPageControl alloc] initWithFrame:CGRectZero];
    self.scrollIndicator.currentPage = 0;
    self.scrollIndicator.currentPageIndicatorTintColor = [WalktroughDefinitions indicatorActiveColor];
    self.scrollIndicator.pageIndicatorTintColor = [WalktroughDefinitions indicatorInactiveColor];
    [self addSubview:self.scrollIndicator];

    self.skipButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.skipButton setBackgroundColor:[UIColor clearColor]];
    [self.skipButton setTitleColor:[WalktroughDefinitions textColor] forState:UIControlStateNormal];
    [self.skipButton addTarget:self.delegate action:@selector(backButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    self.skipButton.titleLabel.font=[WalktroughDefinitions skipButtonTitleFont];
    [self addSubview:self.skipButton];

}



- (void)updateScrollView {
    

    UIView* someView;
    
    switch ([self config].backgroundStyle) {
        case CDBackgroundStyleFlatColor:
        {
            //flat color style
            someView = [CoDesignHelper getFlatViewWithColor:[WalktroughDefinitions themeColor]];
            
        }
            break;
            
        case CDBackgroundStylePattern:
        {
            //pattern style
            someView = [CoDesignHelper getPatternViewWithImage:[self config].backgroundImage
                                               backgroundColor:[WalktroughDefinitions themeColor]];

        }
            break;
        default:
        {
            //photo style
            someView = [CoDesignHelper getPhotoViewWithImage:[self config].backgroundImage
                                                        blur:[WalktroughDefinitions photoImageBlurRatio]
                                                   darkRatio:  [WalktroughDefinitions photoImageDarkRatio]];
            
        }
            break;
    }
    
    [someView setFrame:backgroundView.bounds];
    [backgroundView addSubview:someView];
    
    switch ([self config].screenType) {
        case CDScreenTypeIcon:
        {
            [self.scrollIndicator setFrame:CGRectMake(_screenSize.width/2.0 - 80.0, _screenSize.height - 100.0, 160.0f, 8.0f)];
            
            [self.skipButton setFrame:CGRectMake((_screenSize.width-[WalktroughDefinitions skipButtonTitleWidth])/2.0f, _screenSize.height - 65.0, [WalktroughDefinitions skipButtonTitleWidth], 35.0f)];
            [self.skipButton setTitle:[WalktroughDefinitions skipButtonTitle] forState:UIControlStateNormal];
            
            self.skipButton.layer.cornerRadius=9.0f;
            
            self.skipButton.layer.borderColor=[UIColor whiteColor].CGColor;
            self.skipButton.layer.borderWidth=1.0f;
            
        }
            break;
            
        default:
        {
            [self.scrollIndicator setFrame:CGRectMake(_screenSize.width/2.0 - 80.0, _screenSize.height - 33.0, 160.0f, 8.0f)];
            
            [self.skipButton setFrame:CGRectMake(_screenSize.width-[WalktroughDefinitions skipButtonTitleWidth], _screenSize.height - 48.0, [WalktroughDefinitions skipButtonTitleWidth], 35.0f)];
            [self.skipButton setTitle:[WalktroughDefinitions skipButtonTitle] forState:UIControlStateNormal];

        }
            break;
    }

    
    NSUInteger amountOfViews = 0;
    if ([self.delegate respondsToSelector:@selector(numberOfPagesInScrollView)]) {
        amountOfViews = [self.dataSource numberOfPagesInScrollView];
    }
    self.scrollIndicator.numberOfPages=amountOfViews;
    
    CGSize sizeForScrollView = CGSizeMake( amountOfViews * self.bounds.size.width, 0 );

    self.scrollView.contentSize = sizeForScrollView;
    
    if ([self.delegate respondsToSelector:@selector(scrollViewSizeHasBeenUpdated)]) {
        [self.delegate scrollViewSizeHasBeenUpdated];
    }
    
}

#pragma mark - Public methods
- (void)createViews {

    
    NSUInteger amountOfViews = 0;
    if ([self.delegate respondsToSelector:@selector(numberOfPagesInScrollView)]) {
        amountOfViews = [self.dataSource numberOfPagesInScrollView];
    }
    
    NSUInteger position = 0;
    
    for ( NSUInteger i = 0; i < amountOfViews; i++) {
        
        WDataObject *data = nil;
        if ([self.delegate respondsToSelector:@selector(scrollView:wDataViewForIndex:)]) {
            data = [self.delegate scrollView:self wDataViewForIndex:i];
        }
        
        WDataView* view=[[WDataView alloc] initWithFrame:self.bounds dataObject:data screenType:[self config].screenType];
        view.tag=100+i;
        view.frame = CGRectMake(position, 0, view.bounds.size.width, view.bounds.size.height);
        position += view.bounds.size.width;
        
        [self.scrollView addSubview:view];
        
    }
    
    
//    [self changeLabelAtIndex:0];
    self.scrollIndicator.currentPage = 0;

    [self updateScrollView];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x / scrollView.frame.size.width;
    WDataView* view = (WDataView*)[self.scrollView viewWithTag:100+self.scrollIndicator.currentPage];

    if (page != self.scrollIndicator.currentPage) {
        
        [view resetView];
    }
    else
    {
        CGFloat differenceBetweenViews = scrollView.contentOffset.x - (scrollView.frame.size.width*self.scrollIndicator.currentPage);
        [view scrolled:differenceBetweenViews];

    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x / scrollView.frame.size.width;
    self.scrollIndicator.currentPage = page;

    WDataView* view = (WDataView*)[self.scrollView viewWithTag:100+page];
    [view resetView];
}

-(WalktroughConfig*)config
{
    WalktroughConfig *config = nil;
    if ([self.delegate respondsToSelector:@selector(configForScrollView)]) {
        config = [self.delegate configForScrollView];
    }

    return config;
}

- (void)updateScrollViewAfterOrientationChangeToPage:(NSUInteger)page {
    
    self.scrollIndicator.currentPage=page;
    NSUInteger position = 0;
    
    for (WDataView *colorView in self.scrollView.subviews) {
        
        colorView.frame = CGRectMake(position, 0, colorView.bounds.size.width, colorView.bounds.size.height);
        position += colorView.bounds.size.width;
        
    }
    
    CGPoint newContentOffset = CGPointMake( page * self.bounds.size.width, 0);
    
    
    [self.scrollView setContentOffset:newContentOffset];
    [self updateScrollView];
}
@end
