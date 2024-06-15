//
//  WalktroughViewController.h
//  CIMS new
//
//  Created by Gonchigsuren Bayraa on 10/1/14.
//  Copyright (c) 2014 bbaatarg. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WalktroughView.h"
#import "WalktroughConfig.h"


@interface WalktroughViewController : UIViewController<WalktroughDataSource,WalktroughDelegate>

@property(nonatomic,strong) WalktroughView* walkView;
@property(nonatomic,strong) WalktroughConfig* config;

-(instancetype)initWithWalktroughConfig:(WalktroughConfig*)wConfig;


@end
