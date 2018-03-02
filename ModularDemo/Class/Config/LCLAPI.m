//
//  API.m
//  ModularDemo
//
//  Created by ZeroHour on 2018/3/1.
//  Copyright © 2018年 hbweipai. All rights reserved.
//

#import "LCLAPI.h"

@implementation LCLAPI

// 创建静态对象 防止外部访问
static LCLAPI * _instance;
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    // 也可以使用一次性代码
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_instance == nil) {
            _instance = [super allocWithZone:zone];
        }
    });
    
    // 基础地址
    _instance.baseUrl = @"";
    
    // 上传头像地址
    _instance.headImageUrl = [NSString stringWithFormat:@"%@%@", _instance.baseUrl, @""];
    
    // 获取验证码
    _instance.codeUrl = [NSString stringWithFormat:@"%@%@", _instance.baseUrl, @""];
    
    // 注册
    _instance.registerUrl = [NSString stringWithFormat:@"%@%@", _instance.baseUrl, @""];
    
    // 登录
    _instance.loginUrl = [NSString stringWithFormat:@"%@%@", _instance.baseUrl, @""];
    
    // 忘记密码
    _instance.forgePasswordUrl = [NSString stringWithFormat:@"%@%@", _instance.baseUrl, @""];
    
    // 修改密码
    _instance.changePasswordUrl = [NSString stringWithFormat:@"%@%@", _instance.baseUrl, @""];
    
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
