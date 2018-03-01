//
//  RegisterViewController.m
//  gongpai
//
//  Created by ZeroHour on 2017/10/23.
//  Copyright © 2017年 hbweipai. All rights reserved.

#import "LCLRegisterViewController2.h"

@interface LCLRegisterViewController2 () <UITextFieldDelegate>
{
    UIScrollView * _loginView;
    UITextField * _nameTF;
    UITextField * _codeTF;
    UITextField * _pwdTF1;
    UITextField * _pwdTF2;
    UITextField * _recommendTF;
    NSString * _inputCode;
    
    NSTimer * _timer;
}
@end

@implementation LCLRegisterViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _inputCode = @"";
    [CLTool globalSetting:self isNavigationBarHidden:NO backgroundColor:[GlobalSingleton shareInstance].globalColor title:@"注册"];
    
    [self initRegisterView];
}
#pragma mark - 退出键盘
- (void)hiddeKeyboard {
    [self.view endEditing:YES];
}

#pragma mark - 创建注册视图
- (void)initRegisterView {
    _loginView = [UIScrollView new];
    _loginView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - kTabbarHeight);
    _loginView.contentSize = CGSizeMake(kScreenWidth, 1000);
    [self.view addSubview:_loginView];
    _loginView.backgroundColor = kWhiteColor;
//    _loginView.scrollEnabled = NO;
    _loginView.showsVerticalScrollIndicator = NO;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddeKeyboard)];
    [_loginView addGestureRecognizer:tap];
    
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
    _nameTF.layer.borderColor = kBlackColor.CGColor;
    _nameTF.layer.borderWidth = 1;
    _nameTF.keyboardType = UIKeyboardTypePhonePad;
    
    _codeTF = [UITextField new];
    _codeTF.frame = CGRectMake(CGRectGetMinX(_nameTF.frame), CGRectGetMaxY(_nameTF.frame) + 10, kScreenWidth - 40, 50);
    [_loginView addSubview:_codeTF];
    _codeTF.placeholder = @"请输入验证码";
    _codeTF.secureTextEntry = YES;
    _codeTF.layer.borderColor = kBlackColor.CGColor;
    _codeTF.layer.borderWidth = 1;
    
    _pwdTF1 = [UITextField new];
    _pwdTF1.frame = CGRectMake(CGRectGetMinX(_nameTF.frame), CGRectGetMaxY(_codeTF.frame) + 10, kScreenWidth - 40, 50);
    [_loginView addSubview:_pwdTF1];
    _pwdTF1.placeholder = @"请输入密码";
    _pwdTF1.secureTextEntry = YES;
    _pwdTF1.layer.borderColor = kBlackColor.CGColor;
    _pwdTF1.layer.borderWidth = 1;
    
    _pwdTF2 = [UITextField new];
    _pwdTF2.frame = CGRectMake(CGRectGetMinX(_nameTF.frame), CGRectGetMaxY(_pwdTF1.frame) + 10, kScreenWidth - 40, 50);
    [_loginView addSubview:_pwdTF2];
    _pwdTF2.placeholder = @"请两次输入密码";
    _pwdTF2.secureTextEntry = YES;
    _pwdTF2.layer.borderColor = kBlackColor.CGColor;
    _pwdTF2.layer.borderWidth = 1;
    
    _recommendTF = [UITextField new];
    _recommendTF.frame = CGRectMake(CGRectGetMinX(_nameTF.frame), CGRectGetMaxY(_pwdTF2.frame) + 10, kScreenWidth - 40, 50);
    [_loginView addSubview:_recommendTF];
    _recommendTF.placeholder = @"请输入推荐码(必填)";
    _recommendTF.layer.borderColor = kBlackColor.CGColor;
    _recommendTF.layer.borderWidth = 1;
    
    // 获取验证码
    UIView * lineView = [UIView new];
    lineView.frame = CGRectMake(_codeTF.frame.size.width - 116, 10, 1, 30);
    [_codeTF addSubview:lineView];
    lineView.backgroundColor = kBlackColor;
    
    UIButton * subscribeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    subscribeBtn.frame = CGRectMake(kScreenWidth - 136, CGRectGetMinY(_codeTF.frame), 116, 50);
    [_loginView addSubview:subscribeBtn];
    subscribeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [subscribeBtn setTitleColor:kBlackColor forState:UIControlStateNormal];
    [subscribeBtn addTarget:self action:@selector(subscribeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [subscribeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
//    subscribeBtn.backgroundColor = kRedColor;
    
    // 注册
    UIButton * registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registerBtn.frame = CGRectMake(20, CGRectGetMaxY(_recommendTF.frame) + 30, kScreenWidth - 40, 44);
    [_loginView addSubview:registerBtn];
    registerBtn.backgroundColor = kBlackColor;
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [registerBtn addTarget:self action:@selector(registerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - 注册
- (void)registerBtnClick:(UIButton *)sender {
    NSLog(@"registerBtnClick");
    if (_nameTF.text.length >= 1) {
        if (_codeTF.text.length >= 1) {
            if (_pwdTF1.text.length >= 1 && _pwdTF2.text.length >= 1) {
                if ([_pwdTF1.text isEqualToString:_pwdTF2.text]) {
                    if (_recommendTF.text.length >= 1) {
                        // 注册请求
                        NSDictionary * param = nil;
                        [[AFHTTPSessionManager manager] GET:[NSString stringWithFormat:@"%@/register/register", kUrl] parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                            NSLog(@"register - %@", responseObject);
                            if ([[responseObject objectForKey:kStatus] integerValue] == 200) {
                                UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:@"注册成功" preferredStyle:UIAlertControllerStyleAlert];
                                [alert addAction:[UIAlertAction actionWithTitle:@"去登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                    // 返回登录界面
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        
                                        [self.navigationController popViewControllerAnimated:YES];
                                    });
                                }]];
                                [self presentViewController:alert animated:YES completion:NULL];
                            } else {
                                [CLTool showAlert:[responseObject objectForKey:kMsg] target:self];
                            }
                        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                            
                        }];
                    } else {
                        [CLTool showAlert:@"请输入推荐码" target:self];
                    }
                } else {
                    [CLTool showAlert:@"两次输入的密码不一致" target:self];
                }
            } else {
                [CLTool showAlert:@"密码至少为6位" target:self];
            }
        } else {
            [CLTool showAlert:@"验证码不能为空" target:self];
        }
    } else {
        [CLTool showAlert:@"手机号为11位" target:self];
    }
}

#pragma mark - 获取验证码
- (void)subscribeBtnClick:(UIButton *)sender {
    NSLog(@"subscribeBtnClick");
    if (_nameTF.text.length == 11) {
        
        // 获取验证码
        NSString * urlStr = [NSString stringWithFormat:@"%@/register/sendCode", kUrl];
        [[AFHTTPSessionManager manager] GET:urlStr parameters:@{@"type":@"1", @"phone":_nameTF.text} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([[responseObject objectForKey:kStatus] integerValue] == 200) {
                
                _inputCode = [responseObject objectForKey:kData];
                NSLog(@"inputCode - %@", [responseObject objectForKey:kData]);
            } else {
                [CLTool showAlert:[responseObject objectForKey:kMsg] target:self];
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
        [CLTool showAlert:@"手机号为11位" target:self];
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
