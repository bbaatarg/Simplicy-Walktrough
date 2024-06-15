//
//  CoDesignHelper.m
//  Simplicy Walktrough Demo
//
//  Created by Synergy Digital on 11/22/14.
//  Copyright (c) 2014 bbaatarg. All rights reserved.
//

#import "CoDesignHelper.h"

@implementation CoDesignHelper

+(UIColor*)colorFromHex:(NSString *)hexString
{
    unsigned int hexInt = 0;
    
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@"#"]];
    [scanner scanHexInt:&hexInt];

    
    // Create color object, specifying alpha as well
    UIColor *color =
    [UIColor colorWithRed:((CGFloat) ((hexInt & 0xFF0000) >> 16))/255
                    green:((CGFloat) ((hexInt & 0xFF00) >> 8))/255
                     blue:((CGFloat) (hexInt & 0xFF))/255
                    alpha:1.0];
    return color;
}


+(UIView*)getPatternViewWithImage:(UIImage *)patternImage backgroundColor:(UIColor *)backgroundColor
{
    CGRect frame = [[UIScreen mainScreen] bounds];

    UIView* bgView = [[UIView alloc] initWithFrame:frame];
    [bgView setBackgroundColor:backgroundColor];
    
    UIView* patternView = [[UIView alloc] initWithFrame:frame];
    [patternView setBackgroundColor:[UIColor colorWithPatternImage:patternImage]];
    [bgView addSubview:patternView];
    
    return bgView;
}

+(UIView*)getFlatViewWithColor:(UIColor*)color
{
    UIView* flatView = [[UIView alloc] init];
    [flatView setBackgroundColor:color];
    
    return flatView;

}

+(UIView*)getPhotoViewWithImage:(UIImage*)photo blur:(CGFloat)blurRatio darkRatio:(CGFloat)darkRatio
{

    
    CGRect frame = [[UIScreen mainScreen] bounds];
    
    CIImage *inputImage = [[CIImage alloc] initWithImage:photo];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CIFilter *blurFilter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [blurFilter setDefaults];
    [blurFilter setValue:@(blurRatio) forKey:@"inputRadius"];
    [blurFilter setValue:inputImage forKey:kCIInputImageKey];
    CIImage *blurredImage = [blurFilter outputImage];
    
    CGImageRef cgimg = [context createCGImage:blurredImage fromRect:inputImage.extent];
    UIImage *blurredAndDarkenedImage = [UIImage imageWithCGImage:cgimg];
    CGImageRelease(cgimg);

    
    UIImageView* photoView = [[UIImageView alloc] initWithImage:blurredAndDarkenedImage];
    [photoView setFrame:frame];
    
    UIView* darkView = [[UIView alloc] initWithFrame:frame];
    [darkView setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:darkRatio]];
    [photoView addSubview:darkView];
    
    return photoView;
}

+(UIView*)getPhotoViewWithImage:(UIImage*)photo blur:(CGFloat)blurRatio
{
    return [CoDesignHelper getPhotoViewWithImage:photo blur:blurRatio darkRatio:0.0];
}

+(UIView*)getPhotoViewWithImage:(UIImage*)photo dark:(CGFloat)darkRatio
{
    return [CoDesignHelper getPhotoViewWithImage:photo blur:0.0 darkRatio:darkRatio];
}

+(UIView*)getPhotoViewWithImage:(UIImage*)photo
{
    return [CoDesignHelper getPhotoViewWithImage:photo blur:0.0 darkRatio:0.0];

}


@end
