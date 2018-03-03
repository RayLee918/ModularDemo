//
//  LCLControlViewController1.m
//  ModularDemo
//
//  Created by ZeroHour on 2018/3/2.
//  Copyright © 2018年 hbweipai. All rights reserved.
//

#import "LCLControlViewController1.h"

@interface LCLControlViewController1 ()

@end

@implementation LCLControlViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initView];
}

#pragma mark - 创建视图
- (void)initView {
    NSMutableArray * mArr = [NSMutableArray arrayWithCapacity:0];
    NSArray * titleArr = @[@"品牌手机", @"数码电器", @"休闲零食", @"美妆护肤", @"水果生鲜", @"厨房美食"];
    NSArray * colorArr = @[kRedColor, kOrangeColor, kYellowColor, kGreenColor, kCyanColor, kBlueColor];
    for (int i = 0 ; i < 6; i++) {//赋值标题
        UIViewController *vc = [UIViewController new];
        vc.title = titleArr[i];
        vc.view.backgroundColor = colorArr[i];
        [mArr addObject:vc];
    }
    
    MJCSegmentInterface *interFace =  [MJCSegmentInterface jc_initWithFrame:CGRectMake(0, 0, self.view.jc_width, self.view.jc_height - 64) interFaceStyleToolsBlock:^(MJCSegmentStylesTools *jc_tools) {
        jc_tools.jc_titleBarStyles(MJCTitlesScrollStyle).
        jc_indicatorColor([GlobalSingleton shareInstance].globalColor).
        jc_childScollAnimalEnabled(YES).
        jc_childScollEnabled(YES).
        jc_childsContainerBackColor([UIColor whiteColor]).
        jc_titlesViewBackColor([UIColor whiteColor]).
        jc_itemTextNormalColor(kTextColor).
        jc_itemTextSelectedColor([GlobalSingleton shareInstance].globalColor).
        jc_itemTextFontSize(16).
        jc_ItemDefaultShowCount(5);
    }];
    [self.view addSubview:interFace];
    [interFace intoTitlesArray:titleArr hostController:self];
    [interFace intoChildControllerArray:mArr];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [LCLTool globalSetting:self isNavigationBarHidden:NO backgroundColor:kWhiteColor title:@"顶部导航"];
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
