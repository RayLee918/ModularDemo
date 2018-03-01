//
//  API.m
//  ModularDemo
//
//  Created by ZeroHour on 2018/3/1.
//  Copyright © 2018年 hbweipai. All rights reserved.
//

#import "LCLAPI.h"

@implementation LCLAPI

- (instancetype)init {
    if (self = [super init]) {
        self.baseUrl = @"base";
        self.loginUrl = [NSString stringWithFormat:@"%@%@", self.baseUrl,
                      @"login"];
    }
    return self;
}
@end
