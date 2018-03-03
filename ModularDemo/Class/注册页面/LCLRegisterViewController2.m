//
//  RegisterViewController.m
//  gongpai
//
//  Created by ZeroHour on 2017/10/23.
//  Copyright © 2017年 hbweipai. All rights reserved.

#import "LCLRegisterViewController2.h"

@interface LCLRegisterViewController2 () <UITextFieldDelegate>
{
    UIScrollView * _loginView;      // 登录视图
    UITextField * _nameTF;          // 用户名
    UITextField * _codeTF;          // 验证码
    UITextField * _pwdTF1;          // 第一次密码
    UITextField * _pwdTF2;          // 第二次密码
    UITextField * _recommendTF;     // 推荐码
    
    NSTimer * _timer;               // 计时器
}
@end

@implementation LCLRegisterViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [LCLTool globalSetting:self isNavigationBarHidden:NO backgroundColor:[GlobalSingleton shareInstance].globalColor title:@"注册"];
}

#pragma mark - 创建注册视图
- (void)initView {
    UIScrollView * view = [UIScrollView new];
    view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    view.contentSize = CGSizeMake(kScreenWidth, kScreenHeight + 200);
    [self.view addSubview:view];
    view.backgroundColor = kWhiteColor;
    view.showsVerticalScrollIndicator = NO;
    _loginView = view;
    
    // 手机号
    UILabel * titleLabel = [UILabel new];
    titleLabel.frame = CGRectMake(0, 0, kScreenWidth, 80);
    [_loginView addSubview:titleLabel];
    titleLabel.text = @"输入手机号注册";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    
    _nameTF = [UITextField new];
    _nameTF.frame = CGRectMake(20, 80, kScreenWidth - 40, 50);
    [_loginView addSubview:_nameTF];
    _nameTF.delegate = self;
    _nameTF.placeholder = @"请输入手机号码";
    _nameTF.layer.borderColor = [GlobalSingleton shareInstance].globalColor.CGColor;
    _nameTF.layer.borderWidth = 1;
    _nameTF.keyboardType = UIKeyboardTypePhonePad;
    
    
    // 验证码
    _codeTF = [UITextField new];
    _codeTF.frame = CGRectMake(CGRectGetMinX(_nameTF.frame), CGRectGetMaxY(_nameTF.frame) + 10, kScreenWidth - 40, 50);
    [_loginView addSubview:_codeTF];
    _codeTF.placeholder = @"请输入验证码";
    _codeTF.secureTextEntry = YES;
    _codeTF.layer.borderColor = [GlobalSingleton shareInstance].globalColor.CGColor;
    _codeTF.layer.borderWidth = 1;
    
    // 第一次密码
    _pwdTF1 = [UITextField new];
    _pwdTF1.frame = CGRectMake(CGRectGetMinX(_nameTF.frame), CGRectGetMaxY(_codeTF.frame) + 10, kScreenWidth - 40, 50);
    [_loginView addSubview:_pwdTF1];
    _pwdTF1.placeholder = @"请输入密码";
    _pwdTF1.secureTextEntry = YES;
    _pwdTF1.layer.borderColor = [GlobalSingleton shareInstance].globalColor.CGColor;
    _pwdTF1.layer.borderWidth = 1;
    
    // 第二次密码
    _pwdTF2 = [UITextField new];
    _pwdTF2.frame = CGRectMake(CGRectGetMinX(_nameTF.frame), CGRectGetMaxY(_pwdTF1.frame) + 10, kScreenWidth - 40, 50);
    [_loginView addSubview:_pwdTF2];
    _pwdTF2.placeholder = @"请两次输入密码";
    _pwdTF2.secureTextEntry = YES;
    _pwdTF2.layer.borderColor = [GlobalSingleton shareInstance].globalColor.CGColor;
    _pwdTF2.layer.borderWidth = 1;
    
    // 推荐码
    _recommendTF = [UITextField new];
    _recommendTF.frame = CGRectMake(CGRectGetMinX(_nameTF.frame), CGRectGetMaxY(_pwdTF2.frame) + 10, kScreenWidth - 40, 50);
    [_loginView addSubview:_recommendTF];
    _recommendTF.placeholder = @"请输入推荐码(必填)";
    _recommendTF.layer.borderColor = [GlobalSingleton shareInstance].globalColor.CGColor;
    _recommendTF.layer.borderWidth = 1;
    
    // 获取验证码
    UIView * lineView = [UIView new];
    lineView.frame = CGRectMake(_codeTF.frame.size.width - 116, 10, 1, 30);
    [_codeTF addSubview:lineView];
    lineView.backgroundColor = [GlobalSingleton shareInstance].globalColor;
    
    UIButton * subscribeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    subscribeBtn.frame = CGRectMake(kScreenWidth - 136, CGRectGetMinY(_codeTF.frame), 116, 50);
    [_loginView addSubview:subscribeBtn];
    subscribeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [subscribeBtn setTitleColor:kBlackColor forState:UIControlStateNormal];
    [subscribeBtn addTarget:self action:@selector(subscribeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [subscribeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    
    // 注册
    UIButton * registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registerBtn.frame = CGRectMake(20, CGRectGetMaxY(_recommendTF.frame) + 30, kScreenWidth - 40, 44);
    [_loginView addSubview:registerBtn];
    registerBtn.backgroundColor = [GlobalSingleton shareInstance].globalColor;
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [registerBtn addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 注册
- (void)registerBtnClick {
    NSLog(@"%s", __func__);
    if (_nameTF.text.length >= 1) {     // 昵称
        if (_codeTF.text.length >= 1) { // 验证码
            if (_pwdTF1.text.length >= 1 && _pwdTF2.text.length >= 1) { // 密码是还为空
                if ([_pwdTF1.text isEqualToString:_pwdTF2.text]) {      // 两次密码是一致
                    if (_recommendTF.text.length >= 1) {                // 推荐码
#warning 参数设置
                        NSDictionary * param = nil;
                        [[AFHTTPSessionManager manager] GET:[NSString stringWithFormat:@"%@%@", kUrl, [LCLAPI shareInstance].registerUrl] parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                            
                            if ([[responseObject objectForKey:kStatus] integerValue] == 200) {
                                
                            } else {
                                
                            }
                        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                            
                        }];
                    } else {
                        [LCLTool showAlert:@"请输入推荐码" target:self];
                    }
                } else {
                    [LCLTool showAlert:[LCLAPI shareInstance].passwordTip target:self];
                }
            } else {
                [LCLTool showAlert:@"密码至少为6位" target:self];
            }
        } else {
            [LCLTool showAlert:@"验证码不能为空" target:self];
        }
    } else {
        [LCLTool showAlert:[LCLAPI shareInstance].phoneTip target:self];
    }
}

#pragma mark - 获取验证码
- (void)subscribeBtnClick:(UIButton *)sender {
    NSLog(@"%s", __func__);
    if (_nameTF.text.length == 11) {
        
        // 获取验证码
        NSString * urlStr = [NSString stringWithFormat:@"%@/register/sendCode", kUrl];
#warning 参数设置
        NSDictionary * param = @{@"type":@"1", @"phone":_nameTF.text};
        [[AFHTTPSessionManager manager] GET:urlStr parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([[responseObject objectForKey:kStatus] integerValue] == 200) {
                
            } else {
        
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        }];
        
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
        [LCLTool showAlert:[LCLAPI shareInstance].phoneTip target:self];
    }
}

@end
