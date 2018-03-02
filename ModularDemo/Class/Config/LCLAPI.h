//
//  API.h
//  ModularDemo
//
//  Created by ZeroHour on 2018/3/1.
//  Copyright © 2018年 hbweipai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCLAPI : NSObject

+ (instancetype)shareInstance;

/**
 baseUrl
 */
@property (nonatomic, strong) NSString * baseUrl;

/**
 登录
 */
@property (nonatomic, strong) NSString * loginUrl;

/**
 上传头像地址
 */
@property (nonatomic, strong) NSString * headImageUrl;


/**
 获取验证码
 */
@property (nonatomic, strong) NSString * codeUrl;

/**
 注册
 */
@property (nonatomic, strong) NSString * registerUrl;

/**
 昵称是还被占用
 */
@property (nonatomic, strong) NSString * validateNameUrl;

/**
 手机号是否被占用
 */
@property (nonatomic, strong) NSString * validatePhoneUrl;

/**
 忘记密码
 */
@property (nonatomic, strong) NSString * forgePasswordUrl;

/**
 修改密码
 */
@property (nonatomic, strong) NSString * changePasswordUrl;
@end
