//
//  MyExamTableViewCell.m
//  Exam
//
//  Created by djzx on 2017/5/11.
//  Copyright © 2017年 djzx. All rights reserved.

#import "MyExamTableViewCell.h"
#import "UIView+SDAutoLayout.h"
#import "Header.h"

#import "UIButton+BackgroundColor.h"

@interface MyExamTableViewCell ()


@end

@implementation MyExamTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        
        [self initView];
    }
    return self;
}

- (void)initView {

    [self.contentView addSubview:self.selectedBtn];
    
    self.selectlable = [[UILabel alloc]init];
    self.selectlable.text = @"萨瓦迪卡";
    self.selectlable.textColor = [UIColor colorWithRed:0.40 green:0.40 blue:0.40 alpha:1.00];
    self.selectlable.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.selectlable];
    self.selectlable.sd_layout.leftSpaceToView(self.selectedBtn,6).topSpaceToView(self.contentView,0).rightEqualToView(self.contentView).bottomEqualToView(self.contentView);
    
    
    
}

//懒加载
- (UIButton *)selectedBtn {
    if (!_selectedBtn) {
        _selectedBtn                    = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectedBtn.frame              = CGRectMake(20, 15, 20, 20);
        _selectedBtn.titleLabel.font    = [UIFont systemFontOfSize:14.0];
//        _selectedBtn.layer.cornerRadius = 10;
        _selectedBtn.layer.borderWidth  = 1;
        _selectedBtn.layer.borderColor  = [UIColor colorWithRed:0.40 green:0.40 blue:0.40 alpha:0.70].CGColor;
        _selectedBtn.clipsToBounds      = YES;
        
        _selectedBtn.userInteractionEnabled = NO;
        [_selectedBtn      setTitleColor:[UIColor colorWithRed:0.40 green:0.40 blue:0.40 alpha:1.00] forState:UIControlStateNormal];
        [_selectedBtn      setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_selectedBtn setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_selectedBtn setBackgroundColor:[UIColor colorWithRed:0.11 green:0.64 blue:0.89 alpha:1.00] forState:UIControlStateSelected];
    }
    return _selectedBtn;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
