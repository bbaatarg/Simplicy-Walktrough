//
//  WDataView.m
//  CIMS new
//
//  Created by Gonchigsuren Bayraa on 10/1/14.
//  Copyright (c) 2014 bbaatarg. All rights reserved.
//

#import "WDataView.h"

#import "WalktroughDefinitions.h"

#define TEXT_ICON_WIDTH 100.0f
#define LABEL_MARGIN 30.0f
#define HORIZONAL_MARGIN 7.0f
#define HORIZONAL_MIDDLE_TEXT_ICON_MARGIN 24.0f
#define kFooterViewHeight 170.0f
#define kTransparentViewAlpha 0.94f
#define kInvisiblerDuringScrollMAXY 160.0

@implementation WDataView

@synthesize titleLabel=_titleLabel;
@synthesize detailLabel=_detailLabel;
@synthesize screenView=_screenView;

-(id)initWithFrame:(CGRect)frame dataObject:(WDataObject*)dataObject screenType:(CDScreenType)screenType
{
    self=[super initWithFrame:frame];
    
    if (self) {
        
        self.wDataObject = dataObject;
        self.screenType = screenType;

        self.screenView=[[UIView alloc] init];
        self.screenView.translatesAutoresizingMaskIntoConstraints=NO;
        self.screenView.backgroundColor=[UIColor clearColor];
        self.screenView.contentMode=UIViewContentModeCenter;
        [self addSubview:self.screenView];

        _transparentView=[[UIView alloc] init];
        [_transparentView setBackgroundColor:[WalktroughDefinitions themeColor]];
        [_transparentView setAlpha:0.94];
        _transparentView.translatesAutoresizingMaskIntoConstraints=NO;
        [self addSubview:_transparentView];


        self.titleLabel=[[UILabel alloc] init];
        self.titleLabel.translatesAutoresizingMaskIntoConstraints=NO;
        self.titleLabel.attributedText=[WalktroughConfig attributedTitleWithString:_wDataObject.wTitle lineSpacing:7];
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
        self.titleLabel.textColor=[WalktroughDefinitions textColor];
        self.titleLabel.numberOfLines=2;
        self.titleLabel.font=[WalktroughDefinitions titleLabelFont];
        [self addSubview:self.titleLabel];
        
        self.detailLabel=[[UILabel alloc] init];
        self.detailLabel.translatesAutoresizingMaskIntoConstraints=NO;
        self.detailLabel.attributedText=[WalktroughConfig attributedDetailWithString:_wDataObject.wDetail lineSpacing:6];
        self.detailLabel.textAlignment=NSTextAlignmentCenter;
        self.detailLabel.textColor=[WalktroughDefinitions textColor];
        self.detailLabel.numberOfLines=5;
        self.detailLabel.font=[WalktroughDefinitions detailLabelFont];
        [self addSubview:self.detailLabel];
        
        switch (screenType) {
            case CDScreenTypeIcon: [self initializeTextIconView];
                break;
            case CDScreenTypeScreenshot: [self initializeScreenshotView];
                break;
            default: [self initializeIphoneViewWithIphoneType:screenType];
                break;
        }
    }
    
    return self;
}

-(void)scrolled:(CGFloat)yCoordinate
{
    if(_wDataObject.objectLayout==WDataViewLayoutUp && [WalktroughConfig isPhoneScreen:self.screenType])
    {
        if (0.0f<yCoordinate<kInvisiblerDuringScrollMAXY) {
            
            _transparentView.alpha = kTransparentViewAlpha/kInvisiblerDuringScrollMAXY*(kInvisiblerDuringScrollMAXY-yCoordinate);
//            _titleLabel.textColor = [self labelColorChangeWithYCoordinate:yCoordinate];
//            _detailLabel.textColor = [self labelColorChangeWithYCoordinate:yCoordinate];
        }

    }

}

-(UIColor*)labelColorChangeWithYCoordinate:(CGFloat)coordinateY
{
    
    CGFloat alphaFromComponent = 30 + (70.0f/kInvisiblerDuringScrollMAXY*(kInvisiblerDuringScrollMAXY-coordinateY));
    NSLog(@"LABEL COLOR CHANGE: %f",coordinateY);
    return [[WalktroughDefinitions textColor] colorWithAlphaComponent:alphaFromComponent];
}

-(void)resetView
{
    _transparentView.alpha = kTransparentViewAlpha;
    _titleLabel.textColor = [WalktroughDefinitions textColor];
    _detailLabel.textColor = [WalktroughDefinitions textColor];

}

#pragma mark
#pragma mark initialize subviews

-(void)initializeTextIconView
{
    
    UIImage* iconImage = [UIImage imageNamed:_wDataObject.imageName];
    
    if (iconImage == nil) {
        
        //if not image try font icon
        [self.screenView addSubview:[self textIconViewWithTextIcon:_wDataObject.imageName]];
    }
    else
    {
        [self.screenView addSubview:[self textIconViewWithImage:iconImage]];

    }
    
    
    //titleLabel
    NSLayoutConstraint* constraint=[NSLayoutConstraint constraintWithItem:self.titleLabel
                                                                attribute:NSLayoutAttributeLeft
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self
                                                                attribute:NSLayoutAttributeLeft
                                                               multiplier:1.0 constant:LABEL_MARGIN];
    [self addConstraint:constraint];
    
    constraint=[NSLayoutConstraint constraintWithItem:self.titleLabel
                                            attribute:NSLayoutAttributeRight
                                            relatedBy:NSLayoutRelationEqual
                                               toItem:self
                                            attribute:NSLayoutAttributeRight
                                           multiplier:1.0 constant:-LABEL_MARGIN];
    [self addConstraint:constraint];

    //detailLabel
    constraint=[NSLayoutConstraint constraintWithItem:self.detailLabel
                                                                attribute:NSLayoutAttributeLeft
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self
                                                                attribute:NSLayoutAttributeLeft
                                                               multiplier:1.0 constant:LABEL_MARGIN];
    [self addConstraint:constraint];
    
    constraint=[NSLayoutConstraint constraintWithItem:self.detailLabel
                                            attribute:NSLayoutAttributeRight
                                            relatedBy:NSLayoutRelationEqual
                                               toItem:self
                                            attribute:NSLayoutAttributeRight
                                           multiplier:1.0 constant:-LABEL_MARGIN];
    [self addConstraint:constraint];
    
    //screenView
    constraint=[NSLayoutConstraint constraintWithItem:self.screenView
                                            attribute:NSLayoutAttributeRight
                                            relatedBy:NSLayoutRelationEqual
                                               toItem:self
                                            attribute:NSLayoutAttributeRight
                                           multiplier:1.0 constant:0.0];
    [self addConstraint:constraint];
    
    constraint=[NSLayoutConstraint constraintWithItem:self.screenView
                                            attribute:NSLayoutAttributeLeft
                                            relatedBy:NSLayoutRelationEqual
                                               toItem:self
                                            attribute:NSLayoutAttributeLeft
                                           multiplier:1.0 constant:0.0];
    [self addConstraint:constraint];

    constraint=[NSLayoutConstraint constraintWithItem:self.screenView
                                            attribute:NSLayoutAttributeHeight
                                            relatedBy:NSLayoutRelationEqual
                                               toItem:nil
                                            attribute:NSLayoutAttributeNotAnAttribute
                                           multiplier:1.0 constant:100.0];
    [self addConstraint:constraint];


    switch (_wDataObject.objectLayout) {
        case WDataViewLayoutUp:
        {
            NSLog(@"WDataViewLayoutUp");
            constraint=[NSLayoutConstraint constraintWithItem:self.titleLabel
                                                    attribute:NSLayoutAttributeTop
                                                    relatedBy:NSLayoutRelationEqual
                                                       toItem:self
                                                    attribute:NSLayoutAttributeTop
                                                   multiplier:1.0 constant:256.0f];
            [self addConstraint:constraint];

            constraint=[NSLayoutConstraint constraintWithItem:self.detailLabel
                                                    attribute:NSLayoutAttributeTop
                                                    relatedBy:NSLayoutRelationEqual
                                                       toItem:self.titleLabel
                                                    attribute:NSLayoutAttributeBottom
                                                   multiplier:1.0 constant:HORIZONAL_MARGIN];
            [self addConstraint:constraint];
            
            constraint=[NSLayoutConstraint constraintWithItem:self.screenView
                                                    attribute:NSLayoutAttributeTop
                                                    relatedBy:NSLayoutRelationEqual
                                                       toItem:self
                                                    attribute:NSLayoutAttributeTop
                                                   multiplier:1.0 constant:120.0f];
            [self addConstraint:constraint];
            

        }
            break;
        case WDataViewLayoutMiddle:
        {
            NSLog(@"WDataViewLayoutMiddle");
            constraint=[NSLayoutConstraint constraintWithItem:self.titleLabel
                                                    attribute:NSLayoutAttributeTop
                                                    relatedBy:NSLayoutRelationEqual
                                                       toItem:self
                                                    attribute:NSLayoutAttributeTop
                                                   multiplier:1.0 constant:106.0f];
            [self addConstraint:constraint];
            
            constraint=[NSLayoutConstraint constraintWithItem:self.screenView
                                                    attribute:NSLayoutAttributeTop
                                                    relatedBy:NSLayoutRelationEqual
                                                       toItem:self
                                                    attribute:NSLayoutAttributeTop
                                                   multiplier:1.0 constant:180.0f];
            [self addConstraint:constraint];

            constraint=[NSLayoutConstraint constraintWithItem:self.detailLabel
                                                    attribute:NSLayoutAttributeTop
                                                    relatedBy:NSLayoutRelationEqual
                                                       toItem:self.screenView
                                                    attribute:NSLayoutAttributeBottom
                                                   multiplier:1.0 constant:24.0f];
            [self addConstraint:constraint];
            

        }
            break;
        case WDataViewLayoutDown:
        {
            NSLog(@"WDataViewLayoutDown");
            constraint=[NSLayoutConstraint constraintWithItem:self.titleLabel
                                                    attribute:NSLayoutAttributeTop
                                                    relatedBy:NSLayoutRelationEqual
                                                       toItem:self
                                                    attribute:NSLayoutAttributeTop
                                                   multiplier:1.0 constant:120.0f];
            [self addConstraint:constraint];
            
            constraint=[NSLayoutConstraint constraintWithItem:self.detailLabel
                                                    attribute:NSLayoutAttributeTop
                                                    relatedBy:NSLayoutRelationEqual
                                                       toItem:self.titleLabel
                                                    attribute:NSLayoutAttributeBottom
                                                   multiplier:1.0 constant:HORIZONAL_MARGIN];
            [self addConstraint:constraint];
            
            constraint=[NSLayoutConstraint constraintWithItem:self.screenView
                                                    attribute:NSLayoutAttributeTop
                                                    relatedBy:NSLayoutRelationEqual
                                                       toItem:self
                                                    attribute:NSLayoutAttributeTop
                                                   multiplier:1.0 constant:237.5];
            [self addConstraint:constraint];


        }
            break;
            
        default:
            break;
    }
}

-(void)initializeScreenshotView
{
    NSLog(@"initializeScreenshotView");

    [self.screenView addSubview:[self screenshotViewWithImage]];

    //titleLabel
    NSLayoutConstraint* constraint=[NSLayoutConstraint constraintWithItem:self.titleLabel
                                                                attribute:NSLayoutAttributeLeft
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self
                                                                attribute:NSLayoutAttributeLeft
                                                               multiplier:1.0 constant:LABEL_MARGIN];
    [self addConstraint:constraint];
    
    constraint=[NSLayoutConstraint constraintWithItem:self.titleLabel
                                            attribute:NSLayoutAttributeRight
                                            relatedBy:NSLayoutRelationEqual
                                               toItem:self
                                            attribute:NSLayoutAttributeRight
                                           multiplier:1.0 constant:-LABEL_MARGIN];
    [self addConstraint:constraint];
    
    //detailLabel
    constraint=[NSLayoutConstraint constraintWithItem:self.detailLabel
                                            attribute:NSLayoutAttributeLeft
                                            relatedBy:NSLayoutRelationEqual
                                               toItem:self
                                            attribute:NSLayoutAttributeLeft
                                           multiplier:1.0 constant:LABEL_MARGIN];
    [self addConstraint:constraint];
    
    constraint=[NSLayoutConstraint constraintWithItem:self.detailLabel
                                            attribute:NSLayoutAttributeRight
                                            relatedBy:NSLayoutRelationEqual
                                               toItem:self
                                            attribute:NSLayoutAttributeRight
                                           multiplier:1.0 constant:-LABEL_MARGIN];
    [self addConstraint:constraint];
    
    //screenView
    constraint=[NSLayoutConstraint constraintWithItem:self.screenView
                                            attribute:NSLayoutAttributeRight
                                            relatedBy:NSLayoutRelationEqual
                                               toItem:self
                                            attribute:NSLayoutAttributeRight
                                           multiplier:1.0 constant:0.0];
    [self addConstraint:constraint];
    
    constraint=[NSLayoutConstraint constraintWithItem:self.screenView
                                            attribute:NSLayoutAttributeLeft
                                            relatedBy:NSLayoutRelationEqual
                                               toItem:self
                                            attribute:NSLayoutAttributeLeft
                                           multiplier:1.0 constant:0.0];
    [self addConstraint:constraint];
    
    constraint=[NSLayoutConstraint constraintWithItem:self.screenView
                                            attribute:NSLayoutAttributeHeight
                                            relatedBy:NSLayoutRelationEqual
                                               toItem:nil
                                            attribute:NSLayoutAttributeNotAnAttribute
                                           multiplier:1.0 constant:100.0];
    [self addConstraint:constraint];

    switch (_wDataObject.objectLayout) {
        case WDataViewLayoutUp:
        {
            [self screenshotUpStyling];

        }
            break;
        case WDataViewLayoutMiddle:
        {
            [self screenshotMiddleStyling];
            
        }
            break;
        case WDataViewLayoutDown:
        {
            [self screenshotDownStyling];
        }
            break;
            
        default:
            break;
    }

}

-(void)initializeIphoneViewWithIphoneType:(CDScreenType)iphoneType
{
    _screenView.translatesAutoresizingMaskIntoConstraints = YES;
    _screenView.frame = CGRectZero;
    [_screenView addSubview:[self iphoneViewIphone:iphoneType]];


    //titleLabel
    NSLayoutConstraint* constraint=[NSLayoutConstraint constraintWithItem:self.titleLabel
                                                                attribute:NSLayoutAttributeLeft
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self
                                                                attribute:NSLayoutAttributeLeft
                                                               multiplier:1.0 constant:LABEL_MARGIN];
    [self addConstraint:constraint];
    
    constraint=[NSLayoutConstraint constraintWithItem:self.titleLabel
                                            attribute:NSLayoutAttributeRight
                                            relatedBy:NSLayoutRelationEqual
                                               toItem:self
                                            attribute:NSLayoutAttributeRight
                                           multiplier:1.0 constant:-LABEL_MARGIN];
    [self addConstraint:constraint];
    
    //detailLabel
    constraint=[NSLayoutConstraint constraintWithItem:self.detailLabel
                                            attribute:NSLayoutAttributeLeft
                                            relatedBy:NSLayoutRelationEqual
                                               toItem:self
                                            attribute:NSLayoutAttributeLeft
                                           multiplier:1.0 constant:LABEL_MARGIN];
    [self addConstraint:constraint];
    
    constraint=[NSLayoutConstraint constraintWithItem:self.detailLabel
                                            attribute:NSLayoutAttributeRight
                                            relatedBy:NSLayoutRelationEqual
                                               toItem:self
                                            attribute:NSLayoutAttributeRight
                                           multiplier:1.0 constant:-LABEL_MARGIN];
    [self addConstraint:constraint];
    
    switch (_wDataObject.objectLayout) {
        case WDataViewLayoutUp:
        {
            NSLog(@"WDataViewLayoutUp");
            
            //titleLabel
            NSLayoutConstraint* constraint=[NSLayoutConstraint constraintWithItem:self.titleLabel
                                                                        attribute:NSLayoutAttributeTop
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self
                                                                        attribute:NSLayoutAttributeBottom
                                                                       multiplier:1.0 constant:-150.0f];
            [self addConstraint:constraint];

            //detailLabel
            constraint=[NSLayoutConstraint constraintWithItem:self.detailLabel
                                                    attribute:NSLayoutAttributeTop
                                                    relatedBy:NSLayoutRelationEqual
                                                       toItem:self.titleLabel
                                                    attribute:NSLayoutAttributeBottom
                                                   multiplier:1.0 constant:HORIZONAL_MARGIN];
            [self addConstraint:constraint];
            
            //_transparentView
            constraint=[NSLayoutConstraint constraintWithItem:_transparentView
                                                    attribute:NSLayoutAttributeRight
                                                    relatedBy:NSLayoutRelationEqual
                                                       toItem:self
                                                    attribute:NSLayoutAttributeRight
                                                   multiplier:1.0 constant:0.0];
            [self addConstraint:constraint];
            
            constraint=[NSLayoutConstraint constraintWithItem:_transparentView
                                                    attribute:NSLayoutAttributeLeft
                                                    relatedBy:NSLayoutRelationEqual
                                                       toItem:self
                                                    attribute:NSLayoutAttributeLeft
                                                   multiplier:1.0 constant:0.0];
            [self addConstraint:constraint];
            
            constraint=[NSLayoutConstraint constraintWithItem:_transparentView
                                                    attribute:NSLayoutAttributeHeight
                                                    relatedBy:NSLayoutRelationEqual
                                                       toItem:nil
                                                    attribute:NSLayoutAttributeNotAnAttribute
                                                   multiplier:1.0 constant:kFooterViewHeight];
            [self addConstraint:constraint];
            
            constraint=[NSLayoutConstraint constraintWithItem:_transparentView
                                                    attribute:NSLayoutAttributeBottom
                                                    relatedBy:NSLayoutRelationEqual
                                                       toItem:self
                                                    attribute:NSLayoutAttributeBottom
                                                   multiplier:1.0 constant:0.0];
            [self addConstraint:constraint];
            
        }
            break;
        case WDataViewLayoutMiddle:
        {
            NSLog(@"WDataViewLayoutMiddle");
            
            //titleLabel
            NSLayoutConstraint* constraint=[NSLayoutConstraint constraintWithItem:self.titleLabel
                                                                        attribute:NSLayoutAttributeTop
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self
                                                                        attribute:NSLayoutAttributeTop
                                                                       multiplier:1.0 constant:36.0f];
            [self addConstraint:constraint];
            
            //detailLabel
            constraint=[NSLayoutConstraint constraintWithItem:self.detailLabel
                                                    attribute:NSLayoutAttributeTop
                                                    relatedBy:NSLayoutRelationEqual
                                                       toItem:self
                                                    attribute:NSLayoutAttributeBottom
                                                   multiplier:1.0 constant:-104.0f];
            [self addConstraint:constraint];

        }
            break;
        case WDataViewLayoutDown:
        {
            NSLog(@"WDataViewLayoutDown");
            
            
            //titleLabel
            NSLayoutConstraint* constraint=[NSLayoutConstraint constraintWithItem:self.titleLabel
                                                                        attribute:NSLayoutAttributeTop
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self
                                                                        attribute:NSLayoutAttributeTop
                                                                       multiplier:1.0 constant:36.0f];
            [self addConstraint:constraint];
            
            //detailLabel
            constraint=[NSLayoutConstraint constraintWithItem:self.detailLabel
                                                    attribute:NSLayoutAttributeTop
                                                    relatedBy:NSLayoutRelationEqual
                                                       toItem:self.titleLabel
                                                    attribute:NSLayoutAttributeBottom
                                                   multiplier:1.0 constant:HORIZONAL_MARGIN];
            [self addConstraint:constraint];

        }
            break;
            
        default:
            break;
    }


}

-(void)screenshotUpStyling
{
    NSLayoutConstraint* constraint=[NSLayoutConstraint constraintWithItem:self.titleLabel
                                            attribute:NSLayoutAttributeTop
                                            relatedBy:NSLayoutRelationEqual
                                               toItem:self
                                            attribute:NSLayoutAttributeTop
                                           multiplier:1.0 constant:432.5f];
    [self addConstraint:constraint];
    
    constraint=[NSLayoutConstraint constraintWithItem:self.detailLabel
                                            attribute:NSLayoutAttributeTop
                                            relatedBy:NSLayoutRelationEqual
                                               toItem:self.titleLabel
                                            attribute:NSLayoutAttributeBottom
                                           multiplier:1.0 constant:HORIZONAL_MARGIN];
    [self addConstraint:constraint];
    
    constraint=[NSLayoutConstraint constraintWithItem:self.screenView
                                            attribute:NSLayoutAttributeTop
                                            relatedBy:NSLayoutRelationEqual
                                               toItem:self
                                            attribute:NSLayoutAttributeTop
                                           multiplier:1.0 constant:43.0f];
    [self addConstraint:constraint];
    

}

-(void)screenshotMiddleStyling
{

    NSLayoutConstraint* constraint=[NSLayoutConstraint constraintWithItem:self.titleLabel
                                            attribute:NSLayoutAttributeTop
                                            relatedBy:NSLayoutRelationEqual
                                               toItem:self
                                            attribute:NSLayoutAttributeTop
                                           multiplier:1.0 constant:36.0f];
    [self addConstraint:constraint];
    
    constraint=[NSLayoutConstraint constraintWithItem:self.screenView
                                            attribute:NSLayoutAttributeTop
                                            relatedBy:NSLayoutRelationEqual
                                               toItem:self
                                            attribute:NSLayoutAttributeTop
                                           multiplier:1.0 constant:90.0f];
    [self addConstraint:constraint];
    
    constraint=[NSLayoutConstraint constraintWithItem:self.detailLabel
                                            attribute:NSLayoutAttributeTop
                                            relatedBy:NSLayoutRelationEqual
                                               toItem:self
                                            attribute:NSLayoutAttributeBottom
                                           multiplier:1.0 constant:-100.0];
    [self addConstraint:constraint];
    
}

-(void)screenshotDownStyling
{
    NSLayoutConstraint* constraint=[NSLayoutConstraint constraintWithItem:self.titleLabel
                                            attribute:NSLayoutAttributeTop
                                            relatedBy:NSLayoutRelationEqual
                                               toItem:self
                                            attribute:NSLayoutAttributeTop
                                           multiplier:1.0 constant:36.0f];
    [self addConstraint:constraint];
    
    constraint=[NSLayoutConstraint constraintWithItem:self.detailLabel
                                            attribute:NSLayoutAttributeTop
                                            relatedBy:NSLayoutRelationEqual
                                               toItem:self.titleLabel
                                            attribute:NSLayoutAttributeBottom
                                           multiplier:1.0 constant:HORIZONAL_MARGIN];
    [self addConstraint:constraint];
    
    constraint=[NSLayoutConstraint constraintWithItem:self.screenView
                                            attribute:NSLayoutAttributeTop
                                            relatedBy:NSLayoutRelationEqual
                                               toItem:self
                                            attribute:NSLayoutAttributeTop
                                           multiplier:1.0 constant:141.5];
    [self addConstraint:constraint];
    
    
}


#pragma mark -Custom accessories
-(UIView*)textIconViewWithImage:(UIImage*)image
{
    CGFloat screenWidth=self.frame.size.width;
    
    UIImageView* imageView=[[UIImageView alloc] initWithImage:image];
    imageView.contentMode=UIViewContentModeScaleAspectFit;
    [imageView setFrame:CGRectMake((screenWidth - TEXT_ICON_WIDTH)/2.0f, 0.0, TEXT_ICON_WIDTH, TEXT_ICON_WIDTH)];
    
    return imageView;

}

-(UIView*)textIconViewWithTextIcon:(NSString*)iconCode
{
    CGFloat screenWidth=self.frame.size.width;
    
    UIImageView* imageView=[[UIImageView alloc] initWithFrame:CGRectMake((screenWidth - TEXT_ICON_WIDTH)/2.0f, 0.0, TEXT_ICON_WIDTH, TEXT_ICON_WIDTH)];
//    [imageView setImage:[UIImage imageNamed:@"font_icon_background"]];
    [imageView setBackgroundColor:[UIColor whiteColor]];
    
    imageView.layer.cornerRadius = 23.0f;
    imageView.layer.shadowOpacity = 1.0;
    imageView.layer.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.25].CGColor;
    imageView.layer.shadowOffset = CGSizeMake(1.0, 1.0);
    imageView.layer.shadowRadius = 4.0;
    
    
    
    UILabel* fontIconLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, TEXT_ICON_WIDTH, TEXT_ICON_WIDTH)];
    [fontIconLabel setFont:[UIFont fontWithName:@"Entypo" size:93]];
    [fontIconLabel setText:iconCode];
    [fontIconLabel setTextAlignment:NSTextAlignmentCenter];
    [fontIconLabel setTextColor:[WalktroughDefinitions themeColor]];
    [imageView addSubview:fontIconLabel];
    
    return imageView;
    
}

-(UIView*)screenshotViewWithImage
{
    CGFloat screenWidth=self.frame.size.width;
    
    UIImageView* imageView=[[UIImageView alloc] initWithImage:nil];
    imageView.contentMode=UIViewContentModeScaleAspectFit;
    [imageView setImage:[UIImage imageNamed:_wDataObject.imageName]];
    [imageView setFrame:CGRectMake(0.0, 0.0, screenWidth, 368.5)];
    
    return imageView;

}

-(UIView*)iphoneViewIphone:(CDScreenType)iphone
{
    
    UIImage* iphoneImage;
    
    switch (iphone) {
        case CDScreenTypePhone5cBlue:
        {
            iphoneImage=[UIImage imageNamed:@"iPhone-5c-Blue"];
        }
            break;
        case CDScreenTypePhone5cGreen:
        {
            iphoneImage=[UIImage imageNamed:@"iPhone-5c-Green"];
        }
            break;
        case CDScreenTypePhone5cPink:
        {
            iphoneImage=[UIImage imageNamed:@"iPhone-5c-Pink"];
        }
            break;
        case CDScreenTypePhone5cWhite:
        {
            iphoneImage=[UIImage imageNamed:@"iPhone-5c-White"];
        }
            break;
        case CDScreenTypePhone5cYellow:
        {
            iphoneImage=[UIImage imageNamed:@"iPhone-5c-Yellow"];
        }
            break;
        case CDScreenTypePhone5sGold:
        {
            iphoneImage=[UIImage imageNamed:@"iPhone-5s-Gold"];
        }
            break;
        case CDScreenTypePhone5sSilver:
        {
            iphoneImage=[UIImage imageNamed:@"iPhone-5s-Silver"];
        }
            break;
        case CDScreenTypePhone5sSpaceGray:
        {
            iphoneImage=[UIImage imageNamed:@"iPhone-5s-Spacegray"];
        }
            break;
        case CDScreenTypePhone6Gold:
        {
            iphoneImage=[UIImage imageNamed:@"iPhone-6-Gold"];
        }
            break;
        case CDScreenTypePhone6Silver:
        {
            iphoneImage=[UIImage imageNamed:@"iPhone-6-Silver"];
        }
            break;
        case CDScreenTypePhone6SpaceGray:
        {
            iphoneImage=[UIImage imageNamed:@"iPhone-6-Spacegray"];
        }
            break;
        case CDScreenTypePhone6PlusGold:
        {
            iphoneImage=[UIImage imageNamed:@"iPhone-6-Plus-Gold"];
        }
            break;
        case CDScreenTypePhone6PlusSilver:
        {
            iphoneImage=[UIImage imageNamed:@"iPhone-6-Plus-Silver"];
        }
            break;
        case CDScreenTypePhone6PlusSpaceGray:
        {
            iphoneImage=[UIImage imageNamed:@"iPhone-6-Plus-Spacegray"];
        }
            break;
        default:
        {
            iphoneImage=[UIImage imageNamed:@"iPhone-5c-Blue"];
        }
            break;
    }
    
    UIImageView* imageView=[[UIImageView alloc] initWithImage:iphoneImage];
    imageView.contentMode=UIViewContentModeScaleAspectFit;
    
    CGFloat widthAspect=iphoneImage.size.height/iphoneImage.size.width;
    
    CGRect imageFrame = CGRectZero;
    
    switch (self.wDataObject.objectLayout) {
        case WDataViewLayoutUp:
        {
            imageFrame = CGRectMake(35.0f, 20.0f + (self.frame.size.height -widthAspect*250.0f-20.0f)/2.0f, 250.0f, widthAspect*250.0f);

        }
            break;
            
        case WDataViewLayoutMiddle:
        {
            imageFrame = CGRectMake(70.0f, 80.0, 180.0f, widthAspect * 180.0f);

        }
            break;
            
        case WDataViewLayoutDown:
        {
            imageFrame = CGRectMake(70.0f, 130.0, 180.0f, widthAspect * 180.0f);

        }
            break;
            
        default:
            break;
    }
    CGFloat aspect = self.frame.size.width / 320.0f;
    CGRect phoneFrame = CGRectMake(imageFrame.origin.x * aspect, imageFrame.origin.y*aspect, imageFrame.size.width*aspect, imageFrame.size.height*aspect);
    NSLog(@"NEW FRAME: %@\nOLD FRAME: %@",NSStringFromCGRect(imageFrame),NSStringFromCGRect(phoneFrame));
    [imageView setFrame:phoneFrame];
    [imageView addSubview:[self screenshotImageWithIphoneType:iphone]];
    
    return imageView;
    
}

-(UIImageView*)screenshotImageWithIphoneType:(CDScreenType)iphoneType
{
    CGRect screenshotFrame=CGRectZero;
    
    switch (iphoneType) {
        case CDScreenTypePhone5cBlue:
        {
            screenshotFrame=CGRectMake(22.0f, 77.0f, 209.0f, 372.0f);
        }
            break;
        case CDScreenTypePhone5cGreen:
        {
            screenshotFrame=CGRectMake(22.0f, 77.0f, 209.0f, 372.0f);
        }
            break;
        case CDScreenTypePhone5cPink:
        {
            screenshotFrame=CGRectMake(22.0f, 77.0f, 209.0f, 372.0f);
        }
            break;
        case CDScreenTypePhone5cWhite:
        {
            screenshotFrame=CGRectMake(22.0f, 77.0f, 209.0f, 372.0f);
        }
            break;
        case CDScreenTypePhone5cYellow:
        {
            screenshotFrame=CGRectMake(21.0f, 74.5f, 211.5f, 375.5f);
        }
            break;
        case CDScreenTypePhone5sGold:
        {
            screenshotFrame=CGRectMake(21.0f, 74.5f, 211.5f, 375.5f);
        }
            break;
        case CDScreenTypePhone5sSilver:
        {
            screenshotFrame=CGRectMake(21.0f, 74.5f, 211.5f, 375.5f);
        }
            break;
        case CDScreenTypePhone5sSpaceGray:
        {
            screenshotFrame=CGRectMake(21.0f, 74.5f, 211.5f, 375.5f);
        }
            break;
        case CDScreenTypePhone6Gold:
        {
            screenshotFrame=CGRectMake(18.0f, 62.5f, 214.0f, 382.0f);
        }
            break;
        case CDScreenTypePhone6Silver:
        {
            screenshotFrame=CGRectMake(18.0f, 62.5f, 214.0f, 382.0f);
        }
            break;
        case CDScreenTypePhone6SpaceGray:
        {
            screenshotFrame=CGRectMake(18.0f, 62.5f, 214.0f, 382.0f);
        }
            break;
        case CDScreenTypePhone6PlusGold:
        {
            screenshotFrame=CGRectMake(18.0f, 62.5f, 214.0f, 381.0f);
        }
            break;
        case CDScreenTypePhone6PlusSilver:
        {
            screenshotFrame=CGRectMake(18.0f, 62.5f, 214.0f, 381.0f);
        }
            break;
        case CDScreenTypePhone6PlusSpaceGray:
        {
            screenshotFrame=CGRectMake(18.0f, 64.0f, 215.0f, 383.0f);
        }
            break;
        default:
        {
            screenshotFrame=CGRectMake(18.0f, 62.5f, 214.0f, 381.0f);
        }
            break;
    }
    
    if (self.wDataObject.objectLayout!=WDataViewLayoutUp) {
        
        CGFloat aspectRatio=180.0/250.0f;
        CGRect newFrame=CGRectMake(screenshotFrame.origin.x*aspectRatio, screenshotFrame.origin.y*aspectRatio, screenshotFrame.size.width*aspectRatio, screenshotFrame.size.height*aspectRatio);
        screenshotFrame=newFrame;
    }
    CGFloat aspect = self.frame.size.width / 320.0f;
    
    CGRect ssFrame = CGRectMake(screenshotFrame.origin.x*aspect, screenshotFrame.origin.y*aspect, screenshotFrame.size.width*aspect, screenshotFrame.size.height*aspect);
    
    UIImageView* screenshotImage=[[UIImageView alloc] initWithFrame:ssFrame];
    [screenshotImage setBackgroundColor:[UIColor blackColor]];
    [screenshotImage setImage:[UIImage imageNamed:_wDataObject.imageName]];
    return screenshotImage;
}



@end
