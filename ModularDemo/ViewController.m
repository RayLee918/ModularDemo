//
//  ViewController.m
//  ModularDemo
//
//  Created by ZeroHour on 2018/3/1.
//  Copyright © 2018年 hbweipai. All rights reserved.
//

#import "ViewController.h"
#import "LCLRLFViewController.h"   // 注册_登录_忘记密码页面
#import "HRSampleColorPickerViewController2.h"  // 自定义风格页面
#import "LCLControlViewController1.h"   // 控件展示
#import "LCLControlViewController2.h"   // 控件展示
#import "LCLTabBarStyleViewController.h"// 标签页面

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, HRColorPickerViewControllerDelegate>
{
    UITableView * _tableView;
    NSArray * _dataSource;     // 展示类
    NSArray * _titles;          // 大标题
    NSArray * _subTitles;       // 页面展示标题
}
@property (nonatomic, strong) UIColor *color;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 设置默认颜色
    [GlobalSingleton shareInstance].globalColor = kBlackColor;
    
    // 创建视图
    [self initView];
    
    // 加载数据
    [self loadNewData];
}

#pragma mark - 加载数据
- (void)loadNewData {
    
    // 分类标题
    _titles = @[@"页面展示", @"控件展示"];
    _subTitles = @[@[@"注册_登录_忘记密码页面", @"标签页面"],
                   @[@"顶部导航切换", @"侧部导航切换"]
                   ];
    
    _dataSource = @[
  @[[LCLRLFViewController class]
    , [LCLTabBarStyleViewController class]]
  
                    ,@[[LCLControlViewController1 class]
                       , [LCLControlViewController2 class]]
                     ];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [LCLTool globalSetting:self isNavigationBarHidden:NO backgroundColor:kGlobalColor title:@"私人定制"];
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
    HRSampleColorPickerViewController2 *controller;
    controller = [[HRSampleColorPickerViewController2 alloc] initWithColor:self.color fullColor:YES];
    controller.delegate = self;
    [self.navigationController pushViewController:controller
                                         animated:YES];
}

#pragma mark - UITableViewDataSource UITableViewDelegate
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UIView * v = [UIView new];
//    v.frame = CGRectMake(0, 0, kScreenWidth, 0.01);
//    v.backgroundColor = kBackgroundColor;
//    return v;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 33;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView * v = [UIView new];
    v.frame = CGRectMake(0, 0, kScreenWidth, 0.01);
    return v;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _titles.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray * arr = _subTitles[section];
    return arr.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return _titles[section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * identifier = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    NSArray * arr = _subTitles[indexPath.section];
    cell.textLabel.text = arr[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray * arr = _dataSource[indexPath.section];
    Class class = arr[indexPath.row];
    [self.navigationController pushViewController:[class new] animated:YES];
}

- (void)setSelectedColor:(UIColor *)color {
    NSLog(@"%s", __func__);
    self.color = color;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
