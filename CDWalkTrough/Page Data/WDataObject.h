//
//  WDataObject.h
//  CIMS new
//
//  Created by Gonchigsuren Bayraa on 10/1/14.
//  Copyright (c) 2014 bbaatarg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "WalktroughConfig.h"





@interface WDataObject : NSObject

@property(nonatomic,strong) NSString* imageName;
@property(nonatomic,strong) NSString* wTitle;
@property(nonatomic,strong) NSString* wDetail;
@property(nonatomic) WDataViewLayout objectLayout;


-(instancetype)initWithViewLayout:(WDataViewLayout)viewLayout imageName:(NSString*)imageName title:(NSString*)title detail:(NSString*)detail;

@end
