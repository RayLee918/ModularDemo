//
//  POHLoginViewController.m
//  proofh
//
//  Created by 张玉琳 on 2018/3/5.
//  Copyright © 2018年 zyl. All rights reserved.
//

#import "LCLLoginViewController3.h"
#import "AppDelegate.h"
#import "LCLForgetPasswordViewController3.h"

@interface LCLLoginViewController3 ()<UIApplicationDelegate>
{
    NSInteger selectTag;

    NSArray*titleArr;
    
    UIView*sectionView;
    
    UIView *loginView;
    
    UIView *registerView;

    int timeDown;
    NSTimer *timer;
    UIButton *sendVcodeBtn;

}
@property (nonatomic,strong) UIImageView *bgViewImage;

/**
 *  按钮选中,中间值
 */
@property (nonatomic,strong) UIButton *selectedBtn;

@property (nonatomic, strong) UITextField *iphoneNumTF;
@property (nonatomic, strong) UITextField *passwordTF;
@property (nonatomic, strong) UITextField *vCodeTF;


@property (nonatomic, strong) UITextField *iphoneNumTF_login;
@property (nonatomic, strong) UITextField *passwordTF_login;
@end

@implementation LCLLoginViewController3

- (void)viewDidLoad {
    [super viewDidLoad];

    selectTag=0;
    titleArr=@[@"登陆",@"注册"];
    
    
    [self loginView];
    [self myRegisterView];
    [self myloginView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [LCLTool globalSetting:self isNavigationBarHidden:NO backgroundColor:kClearColor title:@"注册"];
}

- (void)loginView{
    _bgViewImage  = [[UIImageView alloc] initWithFrame:kScreenRect];
    [self.view addSubview:_bgViewImage];
    _bgViewImage.image = kImageNamed(@"bgviewimage");
    _bgViewImage.userInteractionEnabled = YES;
    
    // logo
    UIImageView *logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/2-30, (150 - 60) / 2, 60, 60)];
    [_bgViewImage addSubview:logoImageView];
    logoImageView.contentMode =  UIViewContentModeCenter;
    logoImageView.image = kImageNamed(@"logo");
    
    sectionView=[[UIView alloc] initWithFrame:CGRectMake(20, 150, kScreenWidth-40, 40)];
    sectionView.backgroundColor = kWhiteColor;
    [_bgViewImage addSubview:sectionView];

    for (int i=0; i<2; i++) {
        UIButton*btn=[[UIButton alloc]initWithFrame:CGRectMake(i*kScreenWidth/2, 0, kScreenWidth/2, 40)];
        [btn setTitle:titleArr[i] forState:0];
        btn.tag=1000+i;
        [btn addTarget:self action:@selector(selectBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:kTextColor forState:0];
        [btn setTitleColor:kRedColor forState:UIControlStateSelected];
        [sectionView addSubview:btn];
        if (i==0) {
            btn.selected=YES;
            self.selectedBtn=btn;
        }else{
            btn.selected=NO;
        }
    }
}

-(void)selectBtn:(UIButton*)sender{
    selectTag=sender.tag;
    if (sender!= self.selectedBtn) {
        self.selectedBtn.selected = NO;
        sender.selected = YES;
        self.selectedBtn = sender;
    }else{
        self.selectedBtn.selected = YES;
    }
    if (selectTag == 1000) {
        NSLog(@"%s - 1000", __func__);
        [self.view sendSubviewToBack:registerView];
        [self.view bringSubviewToFront:loginView];
        
    }else{
        NSLog(@"%s - 2000", __func__);
        [self.view sendSubviewToBack:loginView];
        [self.view bringSubviewToFront:registerView];
    }
}
- (void)myloginView{
    loginView = [[UIView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(sectionView.frame), kScreenWidth - 40, 220)];
    [self.view addSubview:loginView];
    loginView.backgroundColor = kWhiteColor;
    
    UIView *iphoneNumView = [[UIView alloc] initWithFrame:CGRectMake(20, 20, loginView.bounds.size.width-40, 40)];
    [loginView addSubview:iphoneNumView];
    iphoneNumView.layer.masksToBounds = YES;
    iphoneNumView.layer.borderWidth = 1;
    iphoneNumView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    iphoneNumView.layer.cornerRadius = 3;
    
    UIImageView *iphoneIconView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 30, 30)];
    [iphoneNumView addSubview:iphoneIconView];
    iphoneIconView.image = kImageNamed(@"iphone");
    
    _iphoneNumTF_login = [[UITextField alloc] initWithFrame:CGRectMake(45, 0, iphoneNumView.bounds.size.width-40, 40)];
    [iphoneNumView addSubview:_iphoneNumTF_login];
    _iphoneNumTF_login.placeholder = @"请输入手机号";
    _iphoneNumTF_login.keyboardType = UIKeyboardTypeNumberPad;

    //输入密码
    UIView *passView = [[UIView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(iphoneNumView.frame)+20, loginView.bounds.size.width-40, 40)];
    [loginView addSubview:passView];
    passView.layer.masksToBounds = YES;
    passView.layer.borderWidth = 1;
    passView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    passView.layer.cornerRadius = 3;
    
    UIImageView *passIconView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 30, 30)];
    [passView addSubview:passIconView];
    passIconView.image = kImageNamed(@"pass");
    
    _passwordTF_login = [[UITextField alloc] initWithFrame:CGRectMake(45, 0, passView.bounds.size.width-40, 40)];
    [passView addSubview:_passwordTF_login];
    _passwordTF_login.placeholder = @"请输入密码";
    
    UIButton *forgetBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(passView.frame)+20, loginView.bounds.size.width-40-80, 40)];
    [loginView addSubview:forgetBtn];
    forgetBtn.layer.masksToBounds = YES;
    forgetBtn.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    forgetBtn.layer.borderWidth = 1;
    [forgetBtn setTitle:@"是否忘记密码?" forState:UIControlStateNormal];
    [forgetBtn setTitleColor:[GlobalSingleton shareInstance].globalColor forState:UIControlStateNormal];
    [forgetBtn addTarget:self action:@selector(forgetPass) forControlEvents:UIControlEventTouchUpInside];

    UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(forgetBtn.frame), CGRectGetMaxY(passView.frame)+20, 80, 40)];
    [loginView addSubview:loginBtn];
    loginBtn.backgroundColor = [GlobalSingleton shareInstance].globalColor;
    [loginBtn setTitle:@"立即登录" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginTap) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 请求接口，登陆
- (void)loginTap{
    NSLog(@"%s", __func__);
}

#pragma mark - 消失视图
- (void)forgetPass{
     [self presentViewController:[LCLForgetPasswordViewController3 new] animated:YES completion:nil];
}

- (void)myRegisterView{
    registerView = [[UIView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(sectionView.frame), kScreenWidth - 40, 300)];
    [self.view addSubview:registerView];
    registerView.backgroundColor = kWhiteColor;
    
    // 手机号码
    UIView *iphoneNumView = [[UIView alloc] initWithFrame:CGRectMake(20, 20, registerView.bounds.size.width-40, 40)];
    [registerView addSubview:iphoneNumView];
    iphoneNumView.layer.masksToBounds = YES;
    iphoneNumView.layer.borderWidth = 1;
    iphoneNumView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    iphoneNumView.layer.cornerRadius = 3;
    
    UIImageView *iphoneIconView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 30, 30)];
    [iphoneNumView addSubview:iphoneIconView];
    iphoneIconView.image = kImageNamed(@"iphone");
    
    _iphoneNumTF = [[UITextField alloc] initWithFrame:CGRectMake(45, 0, iphoneNumView.bounds.size.width-40-60, 40)];
    [iphoneNumView addSubview:_iphoneNumTF];
    _iphoneNumTF.placeholder = @"请输入手机号";
    _iphoneNumTF.keyboardType = UIKeyboardTypeNumberPad;
    
    sendVcodeBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_iphoneNumTF.frame), 5, 30, 30)];
    [iphoneNumView addSubview:sendVcodeBtn];
    [sendVcodeBtn setImage:kImageNamed(@"sendVCode") forState:UIControlStateNormal];
    [sendVcodeBtn addTarget:self action:@selector(sendVCodeTap) forControlEvents:UIControlEventTouchUpInside];
    
    //验证码
    UIView *vCodeView = [[UIView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(iphoneNumView.frame)+20, registerView.bounds.size.width-40, 40)];
    [registerView addSubview:vCodeView];
    vCodeView.layer.masksToBounds = YES;
    vCodeView.layer.borderWidth = 1;
    vCodeView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    vCodeView.layer.cornerRadius = 3;
    
    UIImageView *vCodeIconView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 30, 30)];
    [vCodeView addSubview:vCodeIconView];
    vCodeIconView.image = kImageNamed(@"code");
    
    _vCodeTF = [[UITextField alloc] initWithFrame:CGRectMake(45, 0, vCodeView.bounds.size.width-40, 40)];
    [vCodeView addSubview:_vCodeTF];
    _vCodeTF.placeholder = @"请输入验证码";
    _vCodeTF.keyboardType = UIKeyboardTypeNumberPad;

    //输入新密码
    UIView *passView = [[UIView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(vCodeView.frame)+20, registerView.bounds.size.width-40, 40)];
    [registerView addSubview:passView];
    passView.layer.masksToBounds = YES;
    passView.layer.borderWidth = 1;
    passView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    passView.layer.cornerRadius = 3;
    
    UIImageView *passIconView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 30, 30)];
    [passView addSubview:passIconView];
    passIconView.image = kImageNamed(@"pass");
    
    _passwordTF = [[UITextField alloc] initWithFrame:CGRectMake(45, 0, passView.bounds.size.width-40, 40)];
    [passView addSubview:_passwordTF];
    _passwordTF.placeholder = @"请输入密码";
    
    UIButton *registerBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(passView.frame)+20, registerView.bounds.size.width-40, 40)];
    [registerView addSubview:registerBtn];
    registerBtn.backgroundColor = [GlobalSingleton shareInstance].globalColor;
    [registerBtn setTitle:@"立即注册" forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(registerTap) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view sendSubviewToBack:registerView];
    
}
#pragma mark - 请求接口，注册新用户，注册成功后直接登陆
- (void)registerTap{
//    if (_iphoneNumTF.text.length>0 && _vCodeTF.text.length>0 && _passwordTF.text.length>0) {
//        [POHHttpReq requestWithRequestURL:[POHAPI shareInstance].registerURL parameter:@{@"username":_iphoneNumTF.text,@"password":_passwordTF.text,@"code":_vCodeTF.text,@"appid":[POHAPI shareInstance].appid} requestSuccessBlock:^(NSDictionary *responseObject) {
//            NSDictionary *responseObjectDic = responseObject;
//            if ([[responseObjectDic objectForKey:@"flag"] isEqualToString:@"Success"]) {
//                [self showTost:[responseObjectDic objectForKey:@"msg"]];
//            }else{
//                [self showTost:[responseObjectDic objectForKey:@"msg"]];
//            }
//        } failure:nil];
//    }else{
//        [self showTost:@"请填写正确的信息"];
//    }
}
#pragma mark - 发送验证码
- (void)sendVCodeTap{
//    if (_iphoneNumTF.text.length>0) {
//        [POHHttpReq requestWithRequestURL:[POHAPI shareInstance].getCodeURL parameter:@{@"username":_iphoneNumTF.text,@"appid":[POHAPI shareInstance].appid} requestSuccessBlock:^(NSDictionary *responseObject) {
//            NSDictionary *responseObjectDic = responseObject;
//            NSLog(@"responseObjectDic===%@", responseObjectDic);
//
//            if ([[responseObjectDic objectForKey:@"flag"] isEqualToString:@"Success"]) {
//
//                [self showTost:[responseObjectDic objectForKey:@"msg"]];
//                sendVcodeBtn.userInteractionEnabled = NO;
//                timeDown = timer_count;
//                timer = [NSTimer scheduledTimerWithTimeInterval:(1.0) target:self selector:@selector(handleTimer) userInfo:nil repeats:YES];
//            }else{
//                [self showTost:[responseObjectDic objectForKey:@"msg"]];
//            }
//        } failure:nil];
//    }else{
//        [self showTost:txt(@"input_iphoneNum")];
//    }
}
- (void)handleTimer{
    
//    if(timeDown>0){
//        timeDown = timeDown - 1;
//        [sendVcodeBtn setImage:[kImageNamed(sendVCodeOffIcon) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
//    }else{
//        [sendVcodeBtn setImage:[kImageNamed(sendVCodeIcon) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
//        
//        [timer invalidate];
//        sendVcodeBtn.userInteractionEnabled = YES;
//    }
    
}
@end
