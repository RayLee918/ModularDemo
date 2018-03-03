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

// ------------------- URL类 -------------------
/**
 API: baseUrl
 */
@property (nonatomic, strong) NSString * baseUrl;

/**
 API: 登录
 */
@property (nonatomic, strong) NSString * loginUrl;

/**
 API: 上传头像地址
 */
@property (nonatomic, strong) NSString * headImageUrl;

/**
 API: 获取验证码
 */
@property (nonatomic, strong) NSString * codeUrl;

/**
 API: 注册
 */
@property (nonatomic, strong) NSString * registerUrl;

/**
 API: 昵称是还被占用
 */
@property (nonatomic, strong) NSString * validateNameUrl;

/**
 API: 手机号是否被占用
 */
@property (nonatomic, strong) NSString * validatePhoneUrl;

/**
 API: 忘记密码
 */
@property (nonatomic, strong) NSString * forgePasswordUrl;

/**
 API: 修改密码
 */
@property (nonatomic, strong) NSString * changePasswordUrl;

// ------------------- 参数名 -------------------

/**
 param: 昵称
 */
@property (nonatomic, strong) NSString * nickName;

/**
 param: 手机号
 */
@property (nonatomic, strong) NSString * phoneNumber;

/**
 param: 头像
 */
@property (nonatomic, strong) NSString * headPic;

/**
 param: 验证码
 */
@property (nonatomic, strong) NSString * verifyCode;

/**
 param: 登录密码
 */
@property (nonatomic, strong) NSString * loginPassword;

/**
 param: 第一次注册密码
 */
@property (nonatomic, strong) NSString * firstPassword;

/**
 param: 第二次注册密码
 */
@property (nonatomic, strong) NSString * secondPassword;

/**
 param: 邀请码
 */
@property (nonatomic, strong) NSString * inviteCode;

// ------------------- 提示信息 -------------------

/**
 tips: 登录成功
 */
@property (nonatomic, strong) NSString * loginSuccessTip;

/**
 tips: 退出成功
 */
@property (nonatomic, strong) NSString * logoutSuccessTip;

/**
 tips: 手机号为11位
 */
@property (nonatomic, strong) NSString * phoneTip;

/**
 tips: 密码不一致
 */
@property (nonatomic, strong) NSString * passwordTip;


@end
