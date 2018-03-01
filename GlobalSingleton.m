//
//  Person.m
//  gongpai
//
//  Created by ZeroHour on 2017/10/23.
//  Copyright © 2017年 hbweipai. All rights reserved.
//

#import "GlobalSingleton.h"

@implementation GlobalSingleton

// 创建静态对象 防止外部访问
static GlobalSingleton * _instance;
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    // 也可以使用一次性代码
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_instance == nil) {
            _instance = [super allocWithZone:zone];
        }
    });
    return _instance;
}

// 为了使实例易于外界访问 我们一般提供一个类方法
// 类方法命名规范 share类名|default类名|类名
+ (instancetype)shareInstance {
    // 最好用self 用Tools他的子类调用时会出现错误
    return [[self alloc]init];
}

// 为了严谨，也要重写copyWithZone 和 mutableCopyWithZone
- (id)copyWithZone:(NSZone *)zone {
    return _instance;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return _instance;
}

@end
