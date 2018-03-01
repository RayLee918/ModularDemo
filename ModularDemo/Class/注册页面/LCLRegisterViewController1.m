//
//  RegisterViewController1.m
//  WPProductOne
//
//  Created by ZeroHour on 2017/8/25.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import "LCLRegisterViewController1.h"

@interface LCLRegisterViewController1 () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate>
{
    UITextField * _nicknameTF;      // 昵称
    UITextField * _phoneTF;         // 手机号
    UITextField * _subcribeTF;      // 验证码
    UITextField * _pwdTF;           // 密码
    UIButton * _uploadImageBtn;     // 上传头像
    
    // 头像
    UIImage * _headImage;           // 头像
    NSString * _headImageStr;       // 上传头像成功后返回的地址
    
    NSTimer * _timer;               // 验证码计时器
}

@end

@implementation LCLRegisterViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 创建视图
    [self initView];
    
    // 属性配置
    [self initAttr];
}

#pragma mark - 属性配置
- (void)initAttr {
#pragma mark - test
    _nicknameTF.text = @"RayLee";
    _pwdTF.text = @"123456";
    _subcribeTF.text = @"1";
    _phoneTF.text = @"18617673258";

    // 颜色
    
    // 字体大小
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 隐藏导航栏
    self.navigationController.navigationBar.hidden = NO;
    self.view.backgroundColor = kWhiteColor;
    self.title = @"快速注册";
}

- (void)initView {
    
    UIScrollView * scrollView = [UIScrollView new];
    scrollView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    [self.view addSubview:scrollView];
    scrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight + 200);
    scrollView.showsVerticalScrollIndicator = NO;
    
    // 返回按钮
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    self.navigationItem.backBarButtonItem = backItem;
    
    // 标题
    UILabel * titleLabel = [UILabel new];
    titleLabel.frame = CGRectMake(30, 20, kScreenWidth - 60, 44);
    [scrollView addSubview:titleLabel];
    titleLabel.textColor = kColor(0x1F1F1F);
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.text = @"请设置头像、昵称, 方便朋友认出你";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    // 上传头像按钮
    UIButton * uploadImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    uploadImageBtn.frame = CGRectMake((kScreenWidth - 79) / 2, CGRectGetMaxY(titleLabel.frame) + 25, 79, 79);
    [scrollView addSubview:uploadImageBtn];
//    uploadImageBtn.backgroundColor = kGlobalColor;
    [uploadImageBtn addTarget:self action:@selector(uploadImageBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [uploadImageBtn setBackgroundImage:kImageNamed(@"add_image") forState:UIControlStateNormal];
    _uploadImageBtn = uploadImageBtn;

    // 昵称
    UILabel * nameLabel = [UILabel new];
    nameLabel.frame = CGRectMake(20, CGRectGetMaxY(uploadImageBtn.frame) + 25, 96, 48);
    [scrollView addSubview:nameLabel];
    nameLabel.textColor = kColor(0x1F1F1F);
    nameLabel.font = [UIFont systemFontOfSize:15];
    nameLabel.text = @"昵称";
    nameLabel.textAlignment = NSTextAlignmentLeft;
    
    UITextField * nameTF = [UITextField new];
    nameTF.frame = CGRectMake(CGRectGetMaxX(nameLabel.frame), CGRectGetMinY(nameLabel.frame), kScreenWidth - 96 - 18 - 20, 48);
    [scrollView addSubview:nameTF];
    nameTF.placeholder = @"例如\"王东方\"";
    nameTF.delegate = self;
    _nicknameTF = nameTF;
    
    UIView * line1 = [UIView new];
    line1.frame = CGRectMake(0, CGRectGetMaxY(nameLabel.frame), kScreenWidth, 1);
    [scrollView addSubview:line1];
    line1.backgroundColor = kColor(0xF7F7F7);
    
    // 手机号
    UILabel * numberLabel = [UILabel new];
    numberLabel.frame = CGRectMake(20, CGRectGetMaxY(line1.frame) + 1, 96, 48);
    [scrollView addSubview:numberLabel];
    numberLabel.textColor = kColor(0x1F1F1F);
    numberLabel.font = [UIFont systemFontOfSize:15];
    numberLabel.text = @"+86";
    numberLabel.textAlignment = NSTextAlignmentLeft;
    
    UITextField * numberTF = [UITextField new];
    numberTF.frame = CGRectMake(CGRectGetMaxX(numberLabel.frame), CGRectGetMinY(numberLabel.frame), kScreenWidth - 96 - 18 - 20, 48);
    [scrollView addSubview:numberTF];
    numberTF.placeholder = @"请填写手机号";
    numberTF.keyboardType = UIKeyboardTypeNumberPad;
    numberTF.delegate = self;
    _phoneTF = numberTF;
    
    
    UIView * line2 = [UIView new];
    line2.frame = CGRectMake(0, CGRectGetMaxY(numberLabel.frame), kScreenWidth, 1);
    [scrollView addSubview:line2];
    line2.backgroundColor = kColor(0xF7F7F7);
    
    // 验证码
    UITextField * subcribeTF = [UITextField new];
    subcribeTF.frame = CGRectMake(20, CGRectGetMaxY(line2.frame), kScreenWidth - 40, 48);
    [scrollView addSubview:subcribeTF];
    subcribeTF.placeholder = @"请输入验证码";
    _subcribeTF = subcribeTF;
    
    // 获取验证码
    UIButton * subscribeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    subscribeBtn.frame = CGRectMake(kScreenWidth - 10 - 135, CGRectGetMinY(subcribeTF.frame) + (48 - 37) / 2, 135, 37);
    [scrollView addSubview:subscribeBtn];
    subscribeBtn.backgroundColor = kGlobalColor;
    subscribeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [subscribeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [subscribeBtn addTarget:self action:@selector(subscribeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    subscribeBtn.layer.cornerRadius = 5;
    subscribeBtn.layer.masksToBounds = YES;

    
    UIView * line3 = [UIView new];
    line3.frame = CGRectMake(0, CGRectGetMaxY(subcribeTF.frame), kScreenWidth, 1);
    [scrollView addSubview:line3];
    line3.backgroundColor = kColor(0xF7F7F7);
    
    // 登录密码
    UILabel * pwdLabel = [UILabel new];
    pwdLabel.frame = CGRectMake(20, CGRectGetMaxY(line3.frame) + 1, 96, 48);
    [scrollView addSubview:pwdLabel];
    pwdLabel.textColor = kColor(0x1F1F1F);
    pwdLabel.font = [UIFont systemFontOfSize:15];
    pwdLabel.text = @"登录密码";
    pwdLabel.textAlignment = NSTextAlignmentLeft;
    
    // 密码输入框
    UITextField * pwdTF = [UITextField new];
    pwdTF.frame = CGRectMake(CGRectGetMaxX(pwdLabel.frame), CGRectGetMinY(pwdLabel.frame), kScreenWidth - 96 - 18 - 20, 48);
    [scrollView addSubview:pwdTF];
    pwdTF.placeholder = @"组合字母、数字或符号";
    pwdTF.secureTextEntry = YES;
    _pwdTF = pwdTF;
    
    UIButton * pwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    pwdBtn.frame = CGRectMake(kScreenWidth - 44, CGRectGetMinY(pwdTF.frame), 44, 44);
    [scrollView addSubview:pwdBtn];
//    pwdBtn.backgroundColor = kGlobalColor;
    [pwdBtn addTarget:self action:@selector(pwdBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [pwdBtn setImage:kImageNamed(@"pwd") forState:UIControlStateNormal];
    
    // 分割线
    UIView * line4 = [UIView new];
    line4.frame = CGRectMake(0, CGRectGetMaxY(pwdLabel.frame), kScreenWidth, 1);
    [scrollView addSubview:line4];
    line4.backgroundColor = kColor(0xF7F7F7);
    
    // 注册
    UIButton * registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registerBtn.frame = CGRectMake(30, CGRectGetMaxY(line4.frame) + 36, kScreenWidth - 60, 44);
    [scrollView addSubview:registerBtn];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [registerBtn addTarget:self action:@selector(registerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    registerBtn.backgroundColor = kGlobalColor;
    registerBtn.layer.cornerRadius = 5;
    registerBtn.layer.masksToBounds = YES;
}

#pragma mark - 密码显示隐藏
- (void)pwdBtnClick {
    _pwdTF.secureTextEntry = !_pwdTF.secureTextEntry;
}

#pragma mark - 上传头像
- (void)uploadImageBtnClick {
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];

    // 从图库选取
    [alert addAction:[UIAlertAction actionWithTitle:@"从手机相册选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
//        [imagePicker.navigationBar setBackgroundColor:[UIColor blackColor]];
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.allowsEditing = YES;
        imagePicker.delegate = self;
        [self presentViewController:imagePicker animated:YES completion:NULL];
        NSLog(@"手机相册选取 - %d", [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]);
        
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePicker.allowsEditing = YES;
            imagePicker.delegate = self;
            [self presentViewController:imagePicker animated:YES completion:NULL];
            NSLog(@"拍照 - %d", [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]);
        }
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - imagePicker delegate
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{

    UIImage * image = nil;
    if (![info objectForKey:UIImagePickerControllerEditedImage]) {
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }else {
        image = [info objectForKey:UIImagePickerControllerEditedImage];
    }
    _headImage = image;
    [_uploadImageBtn setBackgroundImage:_headImage forState:UIControlStateNormal];
    
    // 上传头像图片
    NSString * urlStr = [NSString stringWithFormat:@"%@/upload/image", kUrl];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager POST:urlStr parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:UIImageJPEGRepresentation(_headImage, 0.5) name:@"file" fileName:@"png" mimeType:@"image/png"];
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"success - %@", responseObject);
        _headImageStr = [responseObject objectForKey:kData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error - %@", error);
    }];
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - 退出键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - 注册
- (void)registerBtnClick:(UIButton *)sender {
    NSLog(@"registerBtnClick");
    if (_nicknameTF.text.length >= 1) {
        if (_phoneTF.text.length == 11) {
            if (_subcribeTF.text.length >= 1) {
                if (_pwdTF.text.length >= 6) {
                        NSString * headImageStr = @"";
                        if (_headImageStr.length != 0) {
                            headImageStr = _headImageStr;
                        }
                        NSDictionary * params = @{@"nickName":_nicknameTF.text, @"password":_pwdTF.text, @"token":@"", @"mac":@"轰-6", @"phone":_phoneTF.text, @"headPic":headImageStr, @"mac":_subcribeTF.text};
                        NSString * urlStr = [NSString stringWithFormat:@"%@%@", kUrl, @"register/regUser"];
                        AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
                        [manager GET:urlStr parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
                            
                        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                            NSLog(@"status - %@", responseObject);
                            [MBProgressHUD showTipMessageInWindow:[responseObject objectForKey:kMsg]];
                            if ([[responseObject objectForKey:kStatus] integerValue] == 200) {
                                [self.navigationController popViewControllerAnimated:YES];
                            } else {
                                
                            }
                        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                            NSLog(@"error - %@", error);
                        }];
                } else {
//                    [self showAlert:@"密码至少为6位"];
                    [MBProgressHUD showTipMessageInWindow:@"密码至少为6位"];
                }
            } else {
//                [self showAlert:@"验证码不能为空"];
                [MBProgressHUD showTipMessageInWindow:@"验证码不能为空"];
            }
        } else {
//            [self showAlert:@"手机号为11位"];
            [MBProgressHUD showTipMessageInWindow:@"手机号为11位"];
        }
    } else {
//        [self showAlert:@"昵称不能为空"];
        [MBProgressHUD showTipMessageInWindow:@"昵称不能为空"];
    }
}

- (void)showAlert:(NSString *)message {
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alert animated:YES completion:nil];
    [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:nil]];
}

#pragma mark - 获取验证码
- (void)subscribeBtnClick:(UIButton *)sender {
    NSLog(@"subscribeBtnClick");
    if (_phoneTF.text.length == 11) {
        
        // 获取验证码
        NSString * urlStr = [NSString stringWithFormat:@"%@%@", kUrl, @"code/sendCode"];
        NSDictionary * param = @{@"type":@"1", @"phone":_phoneTF.text};
        NSLog(@"%s - %@ - %@", __func__, urlStr, param);
        
        [[AFHTTPSessionManager manager] POST:urlStr parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [MBProgressHUD showTipMessageInWindow:[responseObject objectForKey:kMsg]];
            NSLog(@"%s - %@", __func__, responseObject);
            if ([[responseObject objectForKey:kStatus] integerValue] == 200) {
            } else {
                
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
        // 获取验证码按钮展示
        __block NSInteger value = 60;
        sender.userInteractionEnabled = NO;
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
//            NSLog(@"subscribeBtnClick - %ld", value);
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
        [MBProgressHUD showTipMessageInWindow:@"填写手机号"];
    }
}

#pragma mark - 服务协议
- (void)remarkBtnClick:(UIButton *)sender {
//    RemarkViewController * remarkVC = [RemarkViewController new];
//    [self.navigationController pushViewController:remarkVC animated:YES];
}

#pragma mark - textFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSLog(@"didEndEditing --------");
    if (textField == _nicknameTF) {
        if (textField.text.length >= 1) {
            NSDictionary * params = @{@"nickName":_nicknameTF.text};
            [[AFHTTPSessionManager manager] GET:[NSString stringWithFormat:@"%@/regOrLog/validateName", kUrl] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (!([[responseObject objectForKey:kStatus] integerValue] == 1)) {
                    [self showAlert:[responseObject objectForKey:kMsg]];
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"endEdit --- %@", error);
            }];
        } else {
            [self showAlert:@"昵称不能为空"];
        }
    } else if (textField == _phoneTF) {
//        if (textField.text.length == 11) {
//            NSDictionary * params = @{@"phone":_numberTF.text};
//            [[AFHTTPSessionManager manager] GET:[NSString stringWithFormat:@"%@/regOrLog/validatePhone", kUrl] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                if (!([[responseObject objectForKey:kStatus] integerValue] == 1)) {
//
//                    [self showAlert:[responseObject objectForKey:kMsg]];
//                }
//            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//            }];
//        } else {
//            [self showAlert:@"手机号为11位"];
//        }
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
