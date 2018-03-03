//
//  CategoryCell.m
//  jianguting
//
//  Created by ZeroHour on 2018/2/9.
//  Copyright © 2018年 hbweipai. All rights reserved.
//

#import "CategoryCell.h"

@implementation CategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel * label = [UILabel new];
        label.frame = CGRectMake(0, 0, 88, 44);
        label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:label];
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = kColor(0x1F1F1F);
        label.highlightedTextColor = [GlobalSingleton shareInstance].globalColor;
        self.nameLabel = label;
        label.backgroundColor = kWhiteColor;
        
        self.redView = [UIView new];
        self.redView.frame = CGRectMake(0, 0, 2, 44);
        [self.contentView addSubview:self.redView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
    self.redView.backgroundColor = [GlobalSingleton shareInstance].globalColor;
    self.redView.hidden = !selected;
    self.backgroundColor = kWhiteColor;
    self.nameLabel.highlighted = selected;
}

@end
