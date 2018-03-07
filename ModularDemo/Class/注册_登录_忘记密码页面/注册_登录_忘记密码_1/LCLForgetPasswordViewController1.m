//
//  ForgetPasswordViewController.m
//  gongpai
//
//  Created by ZeroHour on 2017/10/23.
//  Copyright © 2017年 hbweipai. All rights reserved.
//

#import "LCLForgetPasswordViewController1.h"

@interface LCLForgetPasswordViewController1 () <UITextFieldDelegate>
{
    UIScrollView * _loginView;
    UITextField * _nameTF;
    UITextField * _codeTF;
    UITextField * _pwdTF1;
    UITextField * _pwdTF2;
    NSTimer * _timer;
    NSString * _code;
}
@end

@implementation LCLForgetPasswordViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initForgetPasswordView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [LCLTool globalSetting:self isNavigationBarHidden:NO backgroundColor:kWhiteColor title:@"找回密码"];
}

#pragma mark - 创建视图
- (void)initForgetPasswordView {
    UIScrollView * scrollView = [UIScrollView new];
    scrollView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - kTabbarHeight);
    scrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight + 100);
    [self.view addSubview:scrollView];
    scrollView.backgroundColor = kWhiteColor;
    scrollView.scrollEnabled = NO;
    _loginView = scrollView;
    
    UILabel * titleLabel = [UILabel new];
    titleLabel.frame = CGRectMake(0, 0, kScreenWidth, 80);
    [_loginView addSubview:titleLabel];
    titleLabel.text = @"输入手机号找回";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    
    UITextField * nameTF = [UITextField new];
    nameTF.frame = CGRectMake(20, 80, kScreenWidth - 40, 50);
    [scrollView addSubview:nameTF];
    nameTF.delegate = self;
    nameTF.placeholder = @"请输入手机号码";
    nameTF.layer.borderColor = [GlobalSingleton shareInstance].globalColor.CGColor;
    nameTF.layer.borderWidth = 1;
    _nameTF = nameTF;
    
    UITextField * codeTF = [UITextField new];
    codeTF.frame = CGRectMake(CGRectGetMinX(nameTF.frame), CGRectGetMaxY(_nameTF.frame) + 10, kScreenWidth - 40, 50);
    [scrollView addSubview:codeTF];
    codeTF.placeholder = @"请输入验证码";
    codeTF.secureTextEntry = YES;
    codeTF.layer.borderColor = [GlobalSingleton shareInstance].globalColor.CGColor;
    codeTF.layer.borderWidth = 1;
    _codeTF = codeTF;
    
    UITextField * pwdTF1 = [UITextField new];
    pwdTF1.frame = CGRectMake(CGRectGetMinX(nameTF.frame), CGRectGetMaxY(codeTF.frame) + 10, kScreenWidth - 40, 50);
    [scrollView addSubview:pwdTF1];
    pwdTF1.placeholder = @"请输入新密码";
    pwdTF1.secureTextEntry = YES;
    pwdTF1.layer.borderColor = [GlobalSingleton shareInstance].globalColor.CGColor;
    pwdTF1.layer.borderWidth = 1;
    _pwdTF1 = pwdTF1;
    
    UITextField * pwdTF2 = [UITextField new];
    pwdTF2.frame = CGRectMake(CGRectGetMinX(nameTF.frame), CGRectGetMaxY(pwdTF1.frame) + 10, kScreenWidth - 40, 50);
    [scrollView addSubview:pwdTF2];
    pwdTF2.placeholder = @"请再次输入密码";
    pwdTF2.secureTextEntry = YES;
    pwdTF2.layer.borderColor = [GlobalSingleton shareInstance].globalColor.CGColor;
    pwdTF2.layer.borderWidth = 1;
    _pwdTF2 = pwdTF2;
    
    // 获取验证码
    UIView * lineView = [UIView new];
    lineView.frame = CGRectMake(codeTF.frame.size.width - 116, 10, 1, 30);
    [codeTF addSubview:lineView];
    lineView.backgroundColor = [GlobalSingleton shareInstance].globalColor;
    
    UIButton * subscribeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    subscribeBtn.frame = CGRectMake(kScreenWidth - 136, CGRectGetMinY(codeTF.frame), 116, 50);
    [scrollView addSubview:subscribeBtn];
    subscribeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [subscribeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [subscribeBtn addTarget:self action:@selector(subscribeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [subscribeBtn setTitleColor:kBlackColor forState:UIControlStateNormal];
    
    // 找回密码
    UIButton * forgetPasswordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetPasswordBtn.frame = CGRectMake(20, CGRectGetMaxY(pwdTF2.frame) + 30, kScreenWidth - 40, 44);
    [scrollView addSubview:forgetPasswordBtn];
    forgetPasswordBtn.backgroundColor = [GlobalSingleton shareInstance].globalColor;
    [forgetPasswordBtn setTitle:@"找回密码" forState:UIControlStateNormal];
    forgetPasswordBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [forgetPasswordBtn addTarget:self action:@selector(forgetPasswordBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 找回密码
- (void)forgetPasswordBtnClick {
    NSLog(@"%s", __func__);
}

#pragma mark - 获取验证码
- (void)subscribeBtnClick:(UIButton *)sender {
    NSLog(@"%s", __func__);
    if (_nameTF.text.length == 11) {
        // 获取验证码
        
        // 验证码按钮展示
        __block NSInteger value = 60;
        sender.userInteractionEnabled = NO;
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            NSLog(@"subscribeBtnClick - %ld", value);
            NSString * str = [NSString stringWithFormat:@"%ld重新获取", --value];
            if (value == 0) {
                [sender setTitle:@"获取验证码" forState:UIControlStateNormal];
                sender.userInteractionEnabled = YES;
                [_timer invalidate];
            } else {
                [sender setTitle:str forState:UIControlStateNormal];
            }
        }];
    } else {
        [MBProgressHUD showTipMessageInWindow:@"手机号为11位"];
    }
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
