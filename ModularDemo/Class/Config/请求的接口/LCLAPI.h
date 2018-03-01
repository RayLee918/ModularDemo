//
//  API.h
//  ModularDemo
//
//  Created by ZeroHour on 2018/3/1.
//  Copyright © 2018年 hbweipai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCLAPI : NSObject

/**
 baseUrl
 */
@property (nonatomic, strong) NSString * baseUrl;

/**
 登录
 */
@property (nonatomic, strong) NSString * loginUrl;
@property (nonatomic, strong) NSString * registerUrl;
@property (nonatomic, strong) NSString * forgePasswordUrl;
@property (nonatomic, strong) NSString * changePasswordUrl;
@end
