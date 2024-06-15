//
//  WalktroughDefinitions.h
//  simplicy walktrough demo
//
//  Created by Bayarbaatar Gonchigsuren on 10/26/14.
//  Copyright (c) 2014 bbaatarg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WalktroughDefinitions : NSObject

+(UIColor*)themeColor;
+(UIColor*)textColor;

+(UIColor*)indicatorActiveColor;
+(UIColor*)indicatorInactiveColor;

+(UIFont*)titleLabelFont;
+(UIFont*)detailLabelFont;
+(UIFont*)skipButtonTitleFont;

+(NSString*)skipButtonTitle;
+(CGFloat)skipButtonTitleWidth;

+(CGFloat)photoImageBlurRatio;
+(CGFloat)photoImageDarkRatio;

@end
