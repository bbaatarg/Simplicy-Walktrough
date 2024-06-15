//
//  WalktroughConfig.m
//  CIMS new
//
//  Created by Gonchigsuren Bayraa on 10/1/14.
//  Copyright (c) 2014 bbaatarg. All rights reserved.
//

#import "WalktroughConfig.h"


@implementation WalktroughConfig

- (instancetype)initWithColorDataObjects:(NSArray *)colorDataObjects screenType:(CDScreenType)screenType backgroundStyle:(CDBackgroundStyle)backgroundStyle backgroundImage:(UIImage *)bgImage
{
    self.colorDataObjects = colorDataObjects;
    self.screenType = screenType;
    self.backgroundStyle = backgroundStyle;
    self.backgroundImage = bgImage;
    
    return [self init];
    
}

- (instancetype)initWithColorDataObjects:(NSArray *)colorDataObjects screenType:(CDScreenType)screenType backgroundStyle:(CDBackgroundStyle)backgroundStyle
{
    self.colorDataObjects = colorDataObjects;
    self.screenType = screenType;
    self.backgroundStyle = backgroundStyle;
    
    return [self init];

}


#pragma mark
#pragma mark definition attributed string

+(NSMutableAttributedString*)attributedTitleWithString:(NSString*)string lineSpacing:(CGFloat)lineSpacing
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *paragrahStyle = [[NSMutableParagraphStyle alloc] init];
    [paragrahStyle setLineSpacing:lineSpacing];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragrahStyle range:NSMakeRange(0, [string length])];
    
    return attributedString;
    
}

+(NSMutableAttributedString*)attributedDetailWithString:(NSString*)string lineSpacing:(CGFloat)lineSpacing
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *paragrahStyle = [[NSMutableParagraphStyle alloc] init];
    [paragrahStyle setLineSpacing:lineSpacing];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragrahStyle range:NSMakeRange(0, [string length])];
    
    return attributedString;
}

#pragma mark
#pragma mark definition fonts

+(UIFont*)sectionTitleFont
{
    return [UIFont fontWithName:@"HelveticaNeue-Light" size:12];
}


+(UIFont*)chainButtonTitleFont
{
    return [UIFont fontWithName:@"HelveticaNeue" size:14];
}



+(BOOL)isPhoneScreen:(CDScreenType)screenType
{
    switch (screenType) {
        case CDScreenTypeIcon:
            return NO;
            break;

        case CDScreenTypeScreenshot:
            return NO;
            break;
        default:
            return YES;
            break;
    }
}

+(CDBackgroundStyle)backgroundStyleFromTitle:(NSString*)titleStr
{
    
    if ([titleStr isEqualToString:@"Flat color"]) {
        
        return CDBackgroundStyleFlatColor;
    }
    else if ([titleStr isEqualToString:@"Pattern"])
    {
        return CDBackgroundStylePattern;
        
    }
    else
    {
        return CDBackgroundStylePhotoImage;
    }
    
}

@end
