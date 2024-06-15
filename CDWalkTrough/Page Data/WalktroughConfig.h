//
//  WalktroughConfig.h
//  CIMS new
//
//  Created by Gonchigsuren Bayraa on 10/1/14.
//  Copyright (c) 2014 bbaatarg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WalktroughConfig : NSObject

typedef enum{
    CDScreenTypeIcon,
    CDScreenTypeScreenshot,
    CDScreenTypePhone5cBlue,
    CDScreenTypePhone5cGreen,
    CDScreenTypePhone5cPink,
    CDScreenTypePhone5cWhite,
    CDScreenTypePhone5cYellow,
    CDScreenTypePhone5sGold,
    CDScreenTypePhone5sSilver,
    CDScreenTypePhone5sSpaceGray,
    CDScreenTypePhone6Gold,
    CDScreenTypePhone6Silver,
    CDScreenTypePhone6SpaceGray,
    CDScreenTypePhone6PlusGold,
    CDScreenTypePhone6PlusSilver,
    CDScreenTypePhone6PlusSpaceGray,
}CDScreenType;


typedef NS_OPTIONS(NSUInteger, WDataViewLayout) {
    WDataViewLayoutUp = 0,
    WDataViewLayoutMiddle = 1,
    WDataViewLayoutDown = 2
};

typedef enum{
    CDBackgroundStyleFlatColor,
    CDBackgroundStylePattern,
    CDBackgroundStylePhotoImage,
    
}CDBackgroundStyle;

@property (nonatomic, strong) NSArray *colorDataObjects;

@property (nonatomic) CDBackgroundStyle backgroundStyle;
@property (nonatomic) CDScreenType screenType;

//it can be pattern, photo image
@property (nonatomic, strong) UIImage* backgroundImage;

- (instancetype)initWithColorDataObjects:(NSArray *)colorDataObjects screenType:(CDScreenType)screenType backgroundStyle:(CDBackgroundStyle)backgroundStyle backgroundImage:(UIImage *)bgImage;
- (instancetype)initWithColorDataObjects:(NSArray *)colorDataObjects screenType:(CDScreenType)screenType backgroundStyle:(CDBackgroundStyle)backgroundStyle;

+(NSMutableAttributedString*)attributedTitleWithString:(NSString*)string lineSpacing:(CGFloat)lineSpacing;
+(NSMutableAttributedString*)attributedDetailWithString:(NSString*)string lineSpacing:(CGFloat)lineSpacing;

+(BOOL)isPhoneScreen:(CDScreenType)screenType;
+(CDBackgroundStyle)backgroundStyleFromTitle:(NSString*)titleStr;


@end
