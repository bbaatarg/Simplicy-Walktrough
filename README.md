Setup on your project

Drag CDWalkthrough folder into your xcode project.

	•	import CDWalkthrought classes to you class

#import "CDataObject.h"
#import "WalktroughConfig.h"
#import "WalktroughViewController.h"
#import "CoDesignHelper.h"

     2. 	Create page data objects:
		
CDataObject class

CDataView is single page of Walkthrough Screen. It has UIImage of imageName, titleLabel text of wTitle, detailLabel text of wDetail, page layout of objectLayout. CDataView initialize from CDataView.

CDataObject* screen1=[[CDataObject alloc] initWithViewLayout:layout
                                                               imageName:@"screenshot-1"
                                                               title:@"Main messages"
                                                              detail:@"Lorem Ipsum is simply dummy text of the printing"];
	
		
CDataObject can font-icon code for text-icon style for example: 

CDataObject* icon2=[[CDataObject alloc] initWithViewLayout:CDataViewLayoutMiddle
                                                       imageName:@"\ue723"
                                                           title:@"App features"
                                                          detail:@"Lorem Ipsum has been the industry's standard text ever"];

		
     3. Initiliazing WalkthroughViewController from WalkthroughConfig:

WalkthroughConfig class is defining Walkthrough Screen objects. It will initialize background styles. 

Initialize by flat style you can use setFlatStyleWithThemeColor:

- (instancetype)setFlatStyleWithThemeColor:(UIColor *)flatColor CDObjects:(NSArray *)CDObjects screenType:(CDScreenType)screenType;

Initialize by pattern style you can use setPatternStyleWithThemeColor:

- (instancetype)setPatternStyleWithThemeColor:(UIColor *)themeColor patternImage:(UIImage *)patternImage CDObjects:(NSArray *)CDObjects screenType:(CDScreenType)screenType;

Initialize by photo style you can use setPhotoStyleWithThemeColor:

- (instancetype)setPhotoStyleWithThemeColor:(UIColor*)themeColor photoImage:(UIImage *)photoImage CDObjects:(NSArray *)CDObjects screenType:(CDScreenType)screenType;

WalktroughConfig* config = [[WalktroughConfig alloc] setPatternStyleWithThemeColor:[
CoDesignHelper colorFromHex:@"F56918"]
                                                            patternImage:[UIImage imageNamed:@"pattern"]
                                                               CDObjects:contents
                                                              screenType:screenType];


4. Create WalkthroughViewController with configuration

WalkthroughViewController must initialize with configuration 

 WalktroughViewController* loginVC=[[WalktroughViewController alloc] initWithWalktroughConfig:config];
	
	
5. Start displaying WalkthroughViewController
	
	You created WalkthroughViewController with configuration so you can display it.
	
	So you can use: 

[self.navigationController pushViewController:(UIViewController*) animated:(boolean)];
[self presentViewController:(UIViewController *)\ animated:(BOOL) completion:^(void)completion];







Customizing Walkthrough 

We created WalkthroughDefinitions class for customizing definition values and it has few methods to customize.

+(UIColor*)themeColor; 
//text icon color & background color but it will given from configuration

+(UIColor*)textColor; 
 //title, detail label text color

+(UIColor*)indicatorActiveColor; 
//indicator active color
+(UIColor*)indicatorInactiveColor; 
//indicator inactive color

+(UIFont*)titleLabelFont;
//title label font

+(UIFont*)detailLabelFont;
//detail label font
+(UIFont*)skipButtonTitleFont;
//skip button font

+(NSString*)skipButtonTitle;
//can localized string from “skip” key
+(CGFloat)skipButtonTitleWidth;
//it generates skip button width from text string

+(CGFloat)photoImageBlurRatio;
//when you use photo background style the photo will be automatically blured this ratio
+(CGFloat)photoImageDarkRatio;
//when you use photo background style the photo will be automatically will be draked maximum is 1.0





Adding phone images

If you want to add your custom iphone image on Walktrough Screen you should do few things. 

	•	Add phone mockup image to images.xcassets 
	•	open phoneSizes.plist file and insert new dictionary and give image name and screen frame
	•	add phone to configuration:
	
Open WalkthroughConfig.h and add your phone name type on CDScreenType
enum & give index
	•	If above steps are not error it will be works correctly :)

Supports

	•	System -  iOS 7 or higher.
	•	Only portrait orientation.
	•	all iPads and iPhone 6, 6plus 
	•	retina hd 
	•	font - icon for text icon style

Credits
	
	Designed and developed by CoDesign

Contact

	Contact us codesign2015@gmail.com
	Test from our demo APP from testflight - http://tinyurl.com/simplecy






