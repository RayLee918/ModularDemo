//
//  ChangePasswordViewController.m
//  WPProductOne
//
//  Created by ZeroHour on 2017/8/23.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import "LCLForgetPasswordViewController2.h"

@interface LCLForgetPasswordViewController2 () <UITextFieldDelegate>
{
    UITextField * _phoneTF;
    UITextField * _verifyTF;
    UITextField * _passwordTF;
    UIButton * _verifyBtn;
    NSTimer * _timer;
    NSString * _pageCode;
}
@end

@implementation LCLForgetPasswordViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 返回按钮
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    self.navigationItem.backBarButtonItem = backItem;
    
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.view.backgroundColor = kWhiteColor;
    self.title = @"修改手机号或者密码";
}

- (void)initView {
    
    // 标题
    UILabel * titleLabel = [UILabel new];
    titleLabel.frame = CGRectMake(0, 0, kScreenWidth, 24 + 20 * 2);
    [self.view addSubview:titleLabel];
    titleLabel.textColor = kColor(0x1F1F1F);
    titleLabel.font = [UIFont systemFontOfSize:17];
    titleLabel.text = @"为了确保您的帐号安全, 请验证身份";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    // 手机号
    UITextField * phoneTF = [[UITextField alloc] init];
    phoneTF.frame = CGRectMake(20, CGRectGetMaxY(titleLabel.frame), kScreenWidth, 48);
    [self.view addSubview:phoneTF];
    phoneTF.userInteractionEnabled = YES;
    phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    phoneTF.placeholder = @"请输入手机号";
    _phoneTF = phoneTF;
        
    UIView * lineView = [UIView new];
    lineView.frame = CGRectMake(20, CGRectGetMaxY(phoneTF.frame), kScreenWidth - 40, 1);
    [self.view addSubview:lineView];
    lineView.backgroundColor = kColor(0xF7F7F7);
    
    // 验证码
    UITextField * verifyTF = [[UITextField alloc] init];
    verifyTF.frame = CGRectMake(20, CGRectGetMaxY(phoneTF.frame) + 1, kScreenWidth, 48);
    [self.view addSubview:verifyTF];
    verifyTF.placeholder = @"请输入验证码";
    verifyTF.keyboardType = UIKeyboardTypeNumberPad;
    verifyTF.delegate = self;
    _verifyTF = verifyTF;
    
    UIView * lineView2 = [UIView new];
    lineView2.frame = CGRectMake(20, CGRectGetMaxY(verifyTF.frame), kScreenWidth - 40, 1);
    [self.view addSubview:lineView2];
    lineView2.backgroundColor = kColor(0xF7F7F7);
    
    // 获取验证码按钮
    UIButton * verifyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    verifyBtn.frame = CGRectMake(kScreenWidth/2 + (kScreenWidth/2-135.5)/2, CGRectGetMaxY(lineView.frame) + (48-37.5)/2, 135.5, 37.5);
    [self.view addSubview:verifyBtn];
    verifyBtn.backgroundColor = [GlobalSingleton shareInstance].globalColor;
    [verifyBtn addTarget:self action:@selector(verifyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [verifyBtn setTitle:@"获取验证吗" forState:UIControlStateNormal];
    verifyBtn.layer.cornerRadius = 5;
    _verifyBtn = verifyBtn;
    
    // 密码
    UITextField * passwordTf = [[UITextField alloc] init];
    passwordTf.frame = CGRectMake(20, CGRectGetMaxY(verifyTF.frame) + 1, kScreenWidth, 48);
    [self.view addSubview:passwordTf];
    passwordTf.placeholder = @"请输入6到16位字符";
    passwordTf.delegate = self;
    passwordTf.returnKeyType = UIReturnKeyDone;
    passwordTf.secureTextEntry = YES;
    _passwordTF = passwordTf;
    
    UIButton * pwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    pwdBtn.frame = CGRectMake(kScreenWidth - 44, CGRectGetMinY(passwordTf.frame), 44, 44);
    [self.view addSubview:pwdBtn];
    [pwdBtn addTarget:self action:@selector(pwdBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [pwdBtn setImage:kImageNamed(@"pwd.png") forState:UIControlStateNormal];
    
    UIView * lineView3 = [UIView new];
    lineView3.frame = CGRectMake(20, CGRectGetMaxY(passwordTf.frame) - 1, kScreenWidth - 40, 1);
    [self.view addSubview:lineView3];
    lineView3.backgroundColor = kColor(0xF7F7F7);
    
    // 完成
    UIButton * submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.frame = CGRectMake((kScreenWidth - 135.5) / 2, CGRectGetMaxY(lineView3.frame) +  20, 135.5, 37.5);
    [self.view addSubview:submitBtn];
    [submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [submitBtn setTitle:@"完成提交" forState:UIControlStateNormal];
    submitBtn.layer.cornerRadius = 5;
    submitBtn.layer.masksToBounds = YES;
    submitBtn.backgroundColor = [GlobalSingleton shareInstance].globalColor;
}

#pragma mark - 提交按钮
- (void)submitBtnClick {
    NSLog(@"%s", __func__);
}

#pragma mark - 密码显示隐藏
- (void)pwdBtnClick {
    _passwordTF.secureTextEntry = !_passwordTF.secureTextEntry;
}

#pragma mark - textFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - 验证码
- (void)verifyBtnClick:(UIButton *)sender {
    NSLog(@"%s", __func__);
    if (_phoneTF.text.length == 11) {
        
        // 获取验证码
        // 获取验证码按钮展示
        
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
