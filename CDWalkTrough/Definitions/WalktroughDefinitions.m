//
//  WalktroughDefinitions.m
//  simplicy walktrough demo
//
//  Created by Bayarbaatar Gonchigsuren on 10/26/14.
//  Copyright (c) 2014 bbaatarg. All rights reserved.
//

#import "WalktroughDefinitions.h"
#import "CoDesignHelper.h"

#define kButtonTitleMinWidth 100.0f

@implementation WalktroughDefinitions


#pragma mark default colors

+(UIColor*)themeColor
{
    return [CoDesignHelper colorFromHex:@"#F56918"];
}

+(UIColor*)textColor
{
    return [UIColor whiteColor];
}

+(UIColor*)indicatorActiveColor
{
    return [UIColor whiteColor];
}

+(UIColor*)indicatorInactiveColor
{
    return [UIColor colorWithWhite:1.0 alpha: 100.0/255.0f];
}

#pragma mark label font

+(UIFont*)titleLabelFont
{
    return [UIFont fontWithName:@"Helvetica Neue" size:24.0f];
}

+(UIFont*)detailLabelFont
{
    return [UIFont fontWithName:@"Helvetica Neue" size:15.0f];
}

+(UIFont*)skipButtonTitleFont
{
    return [UIFont fontWithName:@"Helvetica Neue" size:14];
}


#pragma mark default string

+(NSString*)skipButtonTitle
{
    return @"Skip";
}


#pragma mark calculating dynamic skip button width

+(CGFloat)skipButtonTitleWidth
{
    CGSize btnSize=[[WalktroughDefinitions skipButtonTitle] sizeWithAttributes:@{NSFontAttributeName:[WalktroughDefinitions skipButtonTitleFont]}];
    
    if (btnSize.width+50.0f<kButtonTitleMinWidth) {
        return btnSize.width+50.0f;
    }
    else
        return kButtonTitleMinWidth;
}

+(CGFloat)photoImageBlurRatio
{
    return 3.0f;
}
+(CGFloat)photoImageDarkRatio
{
    return 0.2;
}


@end
