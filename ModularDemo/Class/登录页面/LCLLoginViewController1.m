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
    UIScrollView * _loginView;
    UITextField * _nameTF;
    UITextField * _pwdTF;
    NSString * _inputCode;
    NSTimer * _timer;
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
    [CLTool globalSetting:self isNavigationBarHidden:NO backgroundColor:[GlobalSingleton shareInstance].globalColor title:@"登录"];
}

#pragma mark - 配置属性
- (void)config {
    
}
- (void)initView {
    
    UIScrollView * view = [UIScrollView new];
    view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    view.contentSize = CGSizeMake(kScreenWidth, 1000);
    [self.view addSubview:view];
    view.backgroundColor = kWhiteColor;
    view.scrollEnabled = NO;
    _loginView = view;
    self.firstView = view;
    
    UILabel * titleLabel = [UILabel new];
    titleLabel.frame = CGRectMake(0, 0, kScreenWidth, 80);
    [_loginView addSubview:titleLabel];
    titleLabel.text = @"验证手机号登录";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    
    _nameTF = [UITextField new];
    _nameTF.frame = CGRectMake(20, 80, kScreenWidth - 40, 50);
    [_loginView addSubview:_nameTF];
    _nameTF.placeholder = @"请输入手机号码";
    _nameTF.layer.borderColor = kBlackColor.CGColor;
    _nameTF.layer.borderWidth = 1;
    _nameTF.keyboardType = UIKeyboardTypePhonePad;
    
    _pwdTF = [UITextField new];
    _pwdTF.frame = CGRectMake(CGRectGetMinX(_nameTF.frame), CGRectGetMaxY(_nameTF.frame) + 10, kScreenWidth - 40, 50);
    [_loginView addSubview:_pwdTF];
    _pwdTF.placeholder = @"请输入密码";
    _pwdTF.secureTextEntry = YES;
    _pwdTF.layer.borderColor = kBlackColor.CGColor;
    _pwdTF.layer.borderWidth = 1;
    
    //    UIView * lineView = [UIView new];
    //    lineView.frame = CGRectMake(_pwdTF.frame.size.width - 116, 10, 1, 30);
    //    [_pwdTF addSubview:lineView];
    //    lineView.backgroundColor = kBlackColor;
    //
    //    // 获取验证码
    //    UIButton * subscribeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    subscribeBtn.frame = CGRectMake(_pwdTF.frame.size.width - 116, 0, 116, 50);
    //    [_pwdTF addSubview:subscribeBtn];
    //    subscribeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    //    [subscribeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    //    [subscribeBtn addTarget:self action:@selector(subscribeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //    [subscribeBtn setTitleColor:kBlackColor forState:UIControlStateNormal];
    
    // 登录
    UIButton * loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(20, CGRectGetMaxY(_pwdTF.frame) + 30, kScreenWidth - 40, 44);
    [_loginView addSubview:loginBtn];
    loginBtn.backgroundColor = [GlobalSingleton shareInstance].globalColor;
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [loginBtn addTarget:self action:@selector(loginBtnClik:) forControlEvents:UIControlEventTouchUpInside];
    
    // 忘记密码
    UIButton * forgetPwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetPwdBtn.frame = CGRectMake(20, CGRectGetMaxY(loginBtn.frame) + 12, (kScreenWidth - 40) / 2, 44);
    [_loginView addSubview:forgetPwdBtn];
    [forgetPwdBtn setTitleColor:kBlackColor forState:UIControlStateNormal];
    [forgetPwdBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetPwdBtn addTarget:self action:@selector(forgetPwdBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    forgetPwdBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    // 立即注册
    UIButton * registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registerBtn.frame = CGRectMake(CGRectGetMaxX(forgetPwdBtn.frame), CGRectGetMaxY(loginBtn.frame) + 12, (kScreenWidth - 40) / 2, 44);
    [_loginView addSubview:registerBtn];
    [registerBtn setTitleColor:kBlackColor forState:UIControlStateNormal];
    [registerBtn setTitle:@"立即注册" forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(registerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    registerBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    
    // QQ快速登录
    UIButton * qqLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    qqLoginBtn.frame = CGRectMake(kScreenWidth / 2 - 20 - 44, kScreenHeight - 64 - kTabbarHeight - 10 - 44, 44, 44);
    //    [_loginView addSubview:qqLoginBtn];
    [qqLoginBtn setTitleColor:kGlobalColor forState:UIControlStateNormal];
    [qqLoginBtn setBackgroundImage:kImageNamed(@"login_fast_qq.png") forState:UIControlStateNormal];
    [qqLoginBtn addTarget:self action:@selector(qqLoginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 微信快速登录
    UIButton * wxLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    wxLoginBtn.frame = CGRectMake(kScreenWidth / 2 + 20, kScreenHeight - 64 - kTabbarHeight - 10 - 44, 44, 44);
    //    [_loginView addSubview:wxLoginBtn];
    [wxLoginBtn setTitleColor:kGlobalColor forState:UIControlStateNormal];
    [wxLoginBtn setBackgroundImage:kImageNamed(@"login_fast_weixin.png") forState:UIControlStateNormal];
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
