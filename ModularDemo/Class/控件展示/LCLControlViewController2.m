//
//  CustomViewController.m
//  WPProductOne
//
//  Created by ZeroHour on 2017/8/21.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import "LCLControlViewController2.h"
#import "CategoryCell.h"


@interface LCLControlViewController2 () <UITableViewDelegate, UITableViewDataSource>
{
    NSArray * _titles;
    NSArray * _colorArr;
}
@end

@implementation LCLControlViewController2

#pragma mark - 数据准备

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 初始视图
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [LCLTool globalSetting:self isNavigationBarHidden:NO backgroundColor:kRedColor title:@"侧部导航"];
}

#pragma mark - 初始视图
- (void)initView {
    
    // ------------------- 1. 左侧选项 -------------------
    _titles = @[@"股票", @"外汇", @"基金", @"债券", @"贵金属", @"股指期货", @"商品期货"];
    _colorArr = @[kRedColor, kOrangeColor, kYellowColor, kGreenColor, kCyanColor, kBlueColor, kPurpleColor];
    UITableView * tableView1 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 98, kScreenHeight - 64) style:UITableViewStylePlain];
    [self.view addSubview:tableView1];
    tableView1.dataSource = self;
    tableView1.delegate = self;
    tableView1.separatorStyle = UITableViewCellSelectionStyleNone;
    [tableView1 selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
}

#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titles.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * identifier = @"nav";
    CategoryCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CategoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.nameLabel.text = _titles[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIColor * color = _colorArr[indexPath.row];
    self.view.backgroundColor = color;
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

