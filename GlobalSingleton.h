//
//  Person.h
//  gongpai
//
//  Created by ZeroHour on 2017/10/23.
//  Copyright © 2017年 hbweipai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalSingleton : NSObject

@property (nonatomic, strong) UIColor * globalColor;
+ (instancetype)shareInstance;
@end
