//
//  POHForgetPassViewController.m
//  proofh
//
//  Created by 张玉琳 on 2018/3/5.
//  Copyright © 2018年 zyl. All rights reserved.
//

#import "LCLForgetPasswordViewController3.h"

@interface LCLForgetPasswordViewController3 ()
{
    int timeDown;
    NSTimer *timer;
    UIButton *sendVcodeBtn;
}
@property (nonatomic, strong) UITextField *iphoneNumTF;
@property (nonatomic, strong) UITextField *vCodeTF;
@property (nonatomic, strong) UITextField *passwordTF;
@property (nonatomic, strong) UIImageView *bgViewImage;

@end

@implementation LCLForgetPasswordViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    _bgViewImage  = [[UIImageView alloc] initWithFrame:kScreenRect];
    [self.view addSubview:_bgViewImage];
    _bgViewImage.userInteractionEnabled = YES;
    _bgViewImage.image = kImageNamed(@"bgviewimage");
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 60, 44)];
    [_bgViewImage addSubview:backBtn];
    [backBtn setImage:[kImageNamed(@"fanhui") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backToLogin) forControlEvents:UIControlEventTouchUpInside];
    [self initForetPassView];
}
- (void)backToLogin{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)initForetPassView{
    // logo
    UIImageView *logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/2-30, 100, 60, 60)];
    [_bgViewImage addSubview:logoImageView];
    logoImageView.contentMode =  UIViewContentModeCenter;
    logoImageView.image = kImageNamed(@"logo") ;
    
    CGFloat forgetLabelH = 60;
    CGFloat subViewH = 40;
    CGFloat padding = 20;
    
    UIView *forgetPassView = [[UIView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(logoImageView.frame)+40, kScreenWidth - 40, forgetLabelH+padding+(subViewH+padding)*2+80+60)];
    [_bgViewImage addSubview:forgetPassView];
    forgetPassView.backgroundColor = kWhiteColor;
    forgetPassView.layer.masksToBounds = YES;
    forgetPassView.layer.cornerRadius = 5;
    forgetPassView.layer.borderWidth = 1;
    forgetPassView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    CGFloat w = forgetPassView.bounds.size.width-40;


    UILabel *forgetLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, w, forgetLabelH)];
    [forgetPassView addSubview:forgetLabel];
    forgetLabel.text = @"忘记密码";
    forgetLabel.textColor = [UIColor blueColor];
    forgetLabel.font = [UIFont systemFontOfSize:15];

    // 输入手机号码view
    UIView *iphoneNumView = [[UIView alloc] initWithFrame:CGRectMake(20, forgetLabelH+padding, w, subViewH)];
    [forgetPassView addSubview:iphoneNumView];
    iphoneNumView.layer.masksToBounds = YES;
    iphoneNumView.layer.borderWidth = 1;
    iphoneNumView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    iphoneNumView.layer.cornerRadius = 3;
    
    UIImageView *iphoneIconView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 30, 30)];
    [iphoneNumView addSubview:iphoneIconView];
    iphoneIconView.image = kImageNamed(@"iphone");

    _iphoneNumTF = [[UITextField alloc] initWithFrame:CGRectMake(45, 0, w-40-40, subViewH)];
    [iphoneNumView addSubview:_iphoneNumTF];
    _iphoneNumTF.placeholder = @"请输入手机号";
    _iphoneNumTF.keyboardType = UIKeyboardTypeNumberPad;

    sendVcodeBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_iphoneNumTF.frame), 5, 30, 30)];
    [iphoneNumView addSubview:sendVcodeBtn];
    [sendVcodeBtn setImage:kImageNamed(@"sendVCode") forState:UIControlStateNormal];
    [sendVcodeBtn addTarget:self action:@selector(sendVCodeTap) forControlEvents:UIControlEventTouchUpInside];
    
    //验证码
    UIView *vCodeView = [[UIView alloc] initWithFrame:CGRectMake(20, forgetLabelH+padding + subViewH+padding, w, subViewH)];
    [forgetPassView addSubview:vCodeView];
    vCodeView.layer.masksToBounds = YES;
    vCodeView.layer.borderWidth = 1;
    vCodeView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    vCodeView.layer.cornerRadius = 3;

    UIImageView *vCodeIconView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 30, 30)];
    [vCodeView addSubview:vCodeIconView];
    vCodeIconView.image = kImageNamed(@"code");

    _vCodeTF = [[UITextField alloc] initWithFrame:CGRectMake(45, 0, w-40-40, subViewH)];
    [vCodeView addSubview:_vCodeTF];
    _vCodeTF.placeholder = @"请输入验证码";
    _vCodeTF.keyboardType = UIKeyboardTypeNumberPad;

    
    //输入新密码
    UIView *passView = [[UIView alloc] initWithFrame:CGRectMake(20, forgetLabelH+padding+(subViewH+padding)*2, w, subViewH)];
    [forgetPassView addSubview:passView];
    passView.layer.masksToBounds = YES;
    passView.layer.borderWidth = 1;
    passView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    passView.layer.cornerRadius = 3;
    
    UIImageView *passIconView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 30, 30)];
    [passView addSubview:passIconView];
    passIconView.image = kImageNamed(@"pass");
    
    _passwordTF = [[UITextField alloc] initWithFrame:CGRectMake(45, 0, w-40-40, subViewH)];
    [passView addSubview:_passwordTF];
    _passwordTF.placeholder = @"请输入密码";
    
    
    UIButton *wanchengBtn  =[[UIButton alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(passView.frame) +20, w, 40)];
    [forgetPassView addSubview:wanchengBtn];
    wanchengBtn.backgroundColor = [GlobalSingleton shareInstance].globalColor;
    [wanchengBtn setTitle:@"完成" forState:UIControlStateNormal];
    [wanchengBtn addTarget:self action:@selector(wanchengTap) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 请求接口，完成忘记密码页面的新密码修改
- (void)wanchengTap{
//    if (_iphoneNumTF.text.length>0 && _vCodeTF.text.length >0 &&_passwordTF.text.length > 0) {
//        [POHHttpReq requestWithRequestURL:[POHAPI shareInstance].forgetPassURL parameter:@{@"username":_iphoneNumTF.text,@"password":_passwordTF.text,@"appid":[POHAPI shareInstance].appid,@"code":_vCodeTF.text} requestSuccessBlock:^(NSDictionary *responseObject) {
//
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
//            if ([[responseObjectDic objectForKey:@"flag"] isEqualToString:@"Success"]) {
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
