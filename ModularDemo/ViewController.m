//
//  ViewController.m
//  ModularDemo
//
//  Created by ZeroHour on 2018/3/1.
//  Copyright © 2018年 hbweipai. All rights reserved.
//

#import "ViewController.h"
#import "LCLRegisterViewController.h"   // 注册页面
#import "LCLLoginViewController.h"      // 登录页面
#import "LCLSettingViewController.h"    // 用户自定义界面
#import "HRSampleColorPickerViewController2.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
{
    UITableView * _tableView;
    NSArray * _dataSource;
    NSArray * _titles;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 创建视图
    [self initView];
    
    // 加载数据
    [self loadNewData];
}

- (void)changeNav:(NSNotification *)noti {
    NSLog(@"%s - %@", __func__, noti);
    //    UINavigationBar * bar = [UINavigationBar appearance];
    //    bar.barTintColor = kRedColor;
    //    bar.tintColor = kWhiteColor;
    //    bar.translucent = NO;
    //    [bar setTitleTextAttributes:@{NSForegroundColorAttributeName:kWhiteColor}];
    //    [bar setBackgroundImage:[UIImage new]
    //             forBarPosition:UIBarPositionAny
    //                 barMetrics:UIBarMetricsDefault];
    //    [bar setShadowImage:[UIImage new]];
//    self.navigationController.navigationBar.barTintColor = [UIColor greenColor];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [CLTool globalSetting:self isNavigationBarHidden:NO backgroundColor:kGlobalColor title:@"私人定制"];
}

#pragma mark - 创建视图
- (void)initView {
    UITableView * tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    _tableView = tableView;
    
    // 设置
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"自定义" style:UIBarButtonItemStylePlain target:self action:@selector(settingBtnClick)];
}

#pragma mark - 用户自定义
- (void)settingBtnClick {
//    LCLSettingViewController * vc = [LCLSettingViewController new];
    HRSampleColorPickerViewController2 *controller;
    controller = [[HRSampleColorPickerViewController2 alloc] initWithColor:kBlackColor fullColor:YES];
    [self.navigationController pushViewController:controller
                                         animated:YES];
}

#pragma mark - 加载数据
- (void)loadNewData {
    
    // 分类标题
    _titles = @[@"注册页面", @"登录页面"];
    
    _dataSource = @[[LCLRegisterViewController class], [LCLLoginViewController class]];
}


#pragma mark - UITableViewDataSource UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * v = [UIView new];
    v.frame = CGRectMake(0, 0, kScreenWidth, 0.01);
    v.backgroundColor = kBackgroundColor;
    return v;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView * v = [UIView new];
    v.frame = CGRectMake(0, 0, kScreenWidth, 0.01);
    v.backgroundColor = kBackgroundColor;
    return v;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * identifier = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = _titles[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Class class = _dataSource[indexPath.row];
    NSLog(@"%s - %@", __func__, class);
    [self.navigationController pushViewController:[class new] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
