//
//  LCLLoginViewController2.m
//  ModularDemo
//
//  Created by ZeroHour on 2018/3/1.
//  Copyright © 2018年 hbweipai. All rights reserved.
//

#import "LCLLoginViewController2.h"

@interface LCLLoginViewController2 ()
{
    UIView * _loginView;    // 登录视图
    UITextField * _nameTF;  // 用户名
    UITextField * _pwdTF;   // 密码

}
@end

@implementation LCLLoginViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 创建视图
    [self initView];
    
    [self config];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [LCLTool globalSetting:self isNavigationBarHidden:NO backgroundColor:kWhiteColor title:@"登录"];
}

#pragma mark - 配置
- (void)config {
#pragma mark - test
//    _nameTF.text = @"18233989618";
//    _pwdTF.text = @"123456";
}

- (void)initView {
    _loginView = [UIView new];
    _loginView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    [self.view addSubview:_loginView];
    _loginView.backgroundColor = kWhiteColor;
    
    UIImageView * imageView = [UIImageView new];
    imageView.frame = CGRectMake((kScreenWidth - 75) / 2, 20, 75, 75);
    [_loginView addSubview:imageView];
    imageView.image = [UIImage imageNamed:@"head_default"];
    
    // 帐号
    UILabel * nameLabel = [UILabel new];
    nameLabel.frame = CGRectMake(20, 75 + 44, 66, 48);
    [_loginView addSubview:nameLabel];
    nameLabel.textColor = kColor(0x1F1F1F);
    nameLabel.font = [UIFont systemFontOfSize:15];
    nameLabel.text = @"帐号";
    nameLabel.textAlignment = NSTextAlignmentLeft;
    
    _nameTF = [UITextField new];
    _nameTF.frame = CGRectMake(CGRectGetMaxX(nameLabel.frame), CGRectGetMinY(nameLabel.frame), kScreenWidth - 96 - 18, 48);
    [_loginView addSubview:_nameTF];
    _nameTF.placeholder = @"用户名/手机号/邮箱";
    
    UIView * line1 = [UIView new];
    line1.frame = CGRectMake(0, CGRectGetMaxY(nameLabel.frame), kScreenWidth, 1);
    [_loginView addSubview:line1];
    line1.backgroundColor = [GlobalSingleton shareInstance].globalColor;
    
    // 密码
    UILabel * pwdLabel = [UILabel new];
    pwdLabel.frame = CGRectMake(20, CGRectGetMaxY(line1.frame) + 1, 66, 48);
    [_loginView addSubview:pwdLabel];
    pwdLabel.textColor = kColor(0x1F1F1F);
    pwdLabel.font = [UIFont systemFontOfSize:15];
    pwdLabel.text = @"密码";
    pwdLabel.textAlignment = NSTextAlignmentLeft;
    
    _pwdTF = [UITextField new];
    _pwdTF.frame = CGRectMake(CGRectGetMaxX(pwdLabel.frame), CGRectGetMinY(pwdLabel.frame), kScreenWidth - 96 - 18, 48);
    [_loginView addSubview:_pwdTF];
    _pwdTF.placeholder = @"请输入的您的密码";
    _pwdTF.secureTextEntry = YES;
    
    UIButton * pwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    pwdBtn.frame = CGRectMake(kScreenWidth - 44, CGRectGetMinY(_pwdTF.frame), 44, 44);
    [_loginView addSubview:pwdBtn];
    [pwdBtn setImage:kImageNamed(@"password") forState:UIControlStateNormal];;
//    [pwdBtn addTarget:self action:@selector(pwdBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIView * line2 = [UIView new];
    line2.frame = CGRectMake(0, CGRectGetMaxY(pwdLabel.frame), kScreenWidth, 1);
    [_loginView addSubview:line2];
    line2.backgroundColor = [GlobalSingleton shareInstance].globalColor;
    
    // 登录
    UIButton * loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(30, CGRectGetMaxY(line2.frame) + 12, kScreenWidth - 60, 44);
    [_loginView addSubview:loginBtn];
    loginBtn.backgroundColor = [GlobalSingleton shareInstance].globalColor;
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:18];
//    [loginBtn addTarget:self action:@selector(loginBtn:) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.layer.cornerRadius = 5;
    loginBtn.layer.masksToBounds = YES;
    
    // 忘记密码
    UIButton * forgetPwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetPwdBtn.frame = CGRectMake(30, CGRectGetMaxY(loginBtn.frame) + 12, (kScreenWidth - 60) / 2, 44);
    [_loginView addSubview:forgetPwdBtn];
    [forgetPwdBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
//    [forgetPwdBtn addTarget:self action:@selector(forgetPwdBtnClick) forControlEvents:UIControlEventTouchUpInside];
    forgetPwdBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [forgetPwdBtn setTitleColor:[GlobalSingleton shareInstance].globalColor forState:UIControlStateNormal];
     
    // 快速注册
    UIButton * registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registerBtn.frame = CGRectMake(CGRectGetMaxX(forgetPwdBtn.frame), CGRectGetMaxY(loginBtn.frame) + 12, (kScreenWidth - 60) / 2, 44);
    [_loginView addSubview:registerBtn];
    [registerBtn setTitle:@"快速注册" forState:UIControlStateNormal];
//    [registerBtn addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    registerBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [registerBtn setTitleColor:[GlobalSingleton shareInstance].globalColor forState:UIControlStateNormal];
    
    // QQ快速登录
    UIButton * qqLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    qqLoginBtn.frame = CGRectMake(kScreenWidth / 2 - 10 - 44, kScreenHeight - 64 - kTabbarHeight - 10 - 44, 44, 44);
    [_loginView addSubview:qqLoginBtn];
    [qqLoginBtn setBackgroundImage:kImageNamed(@"login_fast_qq.png") forState:UIControlStateNormal];
//    [qqLoginBtn addTarget:self action:@selector(qqLoginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    // 微信快速登录
    UIButton * wxLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    wxLoginBtn.frame = CGRectMake(kScreenWidth / 2 + 10, kScreenHeight - 64 - 49 - 10 - 44, 44, 44);
    [_loginView addSubview:wxLoginBtn];
    [wxLoginBtn setBackgroundImage:kImageNamed(@"login_fast_weixin.png") forState:UIControlStateNormal];
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
