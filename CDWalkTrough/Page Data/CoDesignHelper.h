//
//  CoDesignHelper.h
//  Simplicy Walktrough Demo
//
//  Created by Synergy Digital on 11/22/14.
//  Copyright (c) 2014 bbaatarg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CoDesignHelper : NSObject

+(UIColor*)colorFromHex:(NSString*)hexString;

+(UIView*)getPatternViewWithImage:(UIImage *)patternImage backgroundColor:(UIColor *)backgroundColor;
+(UIView*)getFlatViewWithColor:(UIColor*)color;
+(UIView*)getPhotoViewWithImage:(UIImage*)photo blur:(CGFloat)blurRatio darkRatio:(CGFloat)darkRatio;
+(UIView*)getPhotoViewWithImage:(UIImage*)photo blur:(CGFloat)blurRatio;
+(UIView*)getPhotoViewWithImage:(UIImage*)photo dark:(CGFloat)darkRatio;
+(UIView*)getPhotoViewWithImage:(UIImage*)photo;


@end
