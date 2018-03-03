//
//  ViewController.m
//  ModularDemo
//
//  Created by ZeroHour on 2018/3/1.
//  Copyright © 2018年 hbweipai. All rights reserved.
//

#import "ViewController.h"
#import "LCLLoginViewController.h"
#import "LCLLoginViewController1.h"
#import "LCLLoginViewController2.h"

@interface LCLLoginViewController () <UITableViewDelegate, UITableViewDataSource>
{
    UITableView * _tableView;
    NSArray * _dataSource;
    NSArray * _titles;
}
@end

@implementation LCLLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 创建视图
    [self initView];
    
    // 加载数据
    [self loadNewData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [LCLTool globalSetting:self isNavigationBarHidden:NO backgroundColor:[GlobalSingleton shareInstance].globalColor title:@"登录页面展示"];
}

#pragma mark - 创建视图
- (void)initView {
    UITableView * tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    _tableView = tableView;
}

#pragma mark - 加载数据
- (void)loadNewData {
    _titles = @[@"登录页面1", @"登录页面2"];
    _dataSource = @[[LCLLoginViewController1 class], [LCLLoginViewController2 class]];
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
    [self.navigationController pushViewController:[class new] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end


