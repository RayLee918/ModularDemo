//
//  LCLLoginViewController1.m
//  ModularDemo
//
//  Created by ZeroHour on 2018/3/1.
//  Copyright © 2018年 hbweipai. All rights reserved.
//

#import "LCLLoginViewController1.h"

@interface LCLLoginViewController1 ()
{
    UIScrollView * _loginView;  // 登录视图
    UITextField * _nameTF;      // 用户名
    UITextField * _pwdTF;       // 密码
    NSString * _inputCode;      // 验证码
    NSTimer * _timer;           // 计时器
}
@end

@implementation LCLLoginViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 创建视图
    [self initView];
    
    // 配置属性
    [self config];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [LCLTool globalSetting:self isNavigationBarHidden:NO backgroundColor:kWhiteColor title:@"登录"];
}

#pragma mark - 配置属性
- (void)config {
    
}
- (void)initView {
    
    UIScrollView * view = [UIScrollView new];
    view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    view.contentSize = CGSizeMake(kScreenWidth, kScreenHeight + 200);
    [self.view addSubview:view];
    view.backgroundColor = kWhiteColor;
    view.scrollEnabled = NO;
    _loginView = view;
    
    UILabel * titleLabel = [UILabel new];
    titleLabel.frame = CGRectMake(0, 0, kScreenWidth, 80);
    [_loginView addSubview:titleLabel];
    titleLabel.text = @"验证手机号登录";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    
    // 用户名
    _nameTF = [UITextField new];
    _nameTF.frame = CGRectMake(20, 80, kScreenWidth - 40, 50);
    [_loginView addSubview:_nameTF];
    _nameTF.placeholder = @"请输入手机号码";
    _nameTF.layer.borderColor = [GlobalSingleton shareInstance].globalColor.CGColor;
    _nameTF.layer.borderWidth = 1;
    _nameTF.keyboardType = UIKeyboardTypePhonePad;
    
    // 密码
    _pwdTF = [UITextField new];
    _pwdTF.frame = CGRectMake(CGRectGetMinX(_nameTF.frame), CGRectGetMaxY(_nameTF.frame) + 10, kScreenWidth - 40, 50);
    [_loginView addSubview:_pwdTF];
    _pwdTF.placeholder = @"请输入密码";
    _pwdTF.secureTextEntry = YES;
    _pwdTF.layer.borderColor = [GlobalSingleton shareInstance].globalColor.CGColor;
    _pwdTF.layer.borderWidth = 1;
    
    // 登录
    UIButton * loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(20, CGRectGetMaxY(_pwdTF.frame) + 30, kScreenWidth - 40, 44);
    [_loginView addSubview:loginBtn];
    loginBtn.backgroundColor = [GlobalSingleton shareInstance].globalColor;
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:18];
//    [loginBtn addTarget:self action:@selector(loginBtnClik) forControlEvents:UIControlEventTouchUpInside];
    
    // 忘记密码
    UIButton * forgetPwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetPwdBtn.frame = CGRectMake(20, CGRectGetMaxY(loginBtn.frame) + 12, (kScreenWidth - 40) / 2, 44);
    [_loginView addSubview:forgetPwdBtn];
    [forgetPwdBtn setTitleColor:[GlobalSingleton shareInstance].globalColor forState:UIControlStateNormal];
    [forgetPwdBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
//    [forgetPwdBtn addTarget:self action:@selector(forgetPwdBtnClick) forControlEvents:UIControlEventTouchUpInside];
    forgetPwdBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    // 立即注册
    UIButton * registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registerBtn.frame = CGRectMake(CGRectGetMaxX(forgetPwdBtn.frame), CGRectGetMaxY(loginBtn.frame) + 12, (kScreenWidth - 40) / 2, 44);
    [_loginView addSubview:registerBtn];
    [registerBtn setTitleColor:[GlobalSingleton shareInstance].globalColor forState:UIControlStateNormal];
    [registerBtn setTitle:@"立即注册" forState:UIControlStateNormal];
    registerBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    //    [registerBtn addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    // QQ快速登录
    UIButton * qqLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    qqLoginBtn.frame = CGRectMake(kScreenWidth / 2 - 20 - 44, kScreenHeight - 64 - kTabbarHeight - 10 - 44, 44, 44);
    [_loginView addSubview:qqLoginBtn];
    [qqLoginBtn setTitleColor:kGlobalColor forState:UIControlStateNormal];
    [qqLoginBtn setBackgroundImage:kImageNamed(@"login_fast_qq") forState:UIControlStateNormal];
//    [qqLoginBtn addTarget:self action:@selector(qqLoginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    // 微信快速登录
    UIButton * wxLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    wxLoginBtn.frame = CGRectMake(kScreenWidth / 2 + 20, kScreenHeight - 64 - kTabbarHeight - 10 - 44, 44, 44);
    [_loginView addSubview:wxLoginBtn];
    [wxLoginBtn setTitleColor:kGlobalColor forState:UIControlStateNormal];
    [wxLoginBtn setBackgroundImage:kImageNamed(@"login_fast_weixin") forState:UIControlStateNormal];
//    [wxLoginBtn addTarget:self action:@selector(wxLoginBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
