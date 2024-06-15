//
//  WDataView.h
//  CIMS new
//
//  Created by Gonchigsuren Bayraa on 10/1/14.
//  Copyright (c) 2014 bbaatarg. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WDataObject.h"

@interface WDataView : UIView
{
    UIImageView* _iPhoneImageView;
    UIImageView* _ssImageView;
    UIView* _bottomView;
    
    UIPageControl* _scrollIndicator;
    UIButton* _skipButton;
    
    UILabel* _titleLabel;
    UILabel* _detailLabel;
    UIView* _screenView;
    
    UIView* _transparentView;

}
@property(nonatomic,strong) UILabel* titleLabel;
@property(nonatomic,strong) UILabel* detailLabel;
@property(nonatomic,strong) UIView* screenView;

@property(nonatomic,strong) WDataObject* wDataObject;
@property(nonatomic) CDScreenType screenType;

-(id)initWithFrame:(CGRect)frame dataObject:(WDataObject*)dataObject screenType:(CDScreenType)screenType;

-(void)resetView;
-(void)scrolled:(CGFloat)yCoordinate;

@end
