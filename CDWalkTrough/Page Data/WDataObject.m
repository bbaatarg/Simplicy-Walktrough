//
//  WDataObject.m
//  CIMS new
//
//  Created by Gonchigsuren Bayraa on 10/1/14.
//  Copyright (c) 2014 bbaatarg. All rights reserved.
//

#import "WDataObject.h"

@implementation WDataObject

-(instancetype)initWithViewLayout:(WDataViewLayout)viewLayout imageName:(NSString *)imageName title:(NSString *)title detail:(NSString *)detail
{
    self=[super init];
    if (self) {

        self.imageName=imageName;
        self.wTitle=title;
        self.wDetail=detail;
        self.objectLayout=viewLayout;
    }
    
    return self;
}

//- (NSString *)description {
//    return [NSString stringWithFormat:@"WDataObject"];
//}

@end
