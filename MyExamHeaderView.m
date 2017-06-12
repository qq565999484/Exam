//
//  MyExamHeaderView.m
//  Exam
//
//  Created by djzx on 2017/5/11.
//  Copyright © 2017年 djzx. All rights reserved.
//

#import "MyExamHeaderView.h"
#import "UIView+SDAutoLayout.h"
#import "Header.h"

@interface MyExamHeaderView ()


@end

@implementation MyExamHeaderView

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        self.frame = CGRectMake(0, 0, ScreenWidth, 100);
        self.backgroundColor = [UIColor whiteColor];
        
        [self initView];
    }
    return self;
}

- (void)initView {
    self.subjectTypeLabel = [[UILabel alloc]init];
//    self.subjectTypeLabel.text = @"单选题";
//    self.subjectTypeLabel.textColor = [UIColor colorWithRed:0.40 green:0.83 blue:0.81 alpha:1.00];
//    self.subjectTypeLabel.layer.borderColor =[UIColor colorWithRed:0.40 green:0.83 blue:0.81 alpha:1.00].CGColor;
    self.subjectTypeLabel.layer.borderWidth = 1;
    self.subjectTypeLabel.font  = [UIFont systemFontOfSize:9];
    self.subjectTypeLabel.textAlignment = NSTextAlignmentCenter;
    self.subjectTypeLabel.layer.cornerRadius = 2;
    
    [self addSubview:self.subjectTypeLabel];
    self.subjectTypeLabel.sd_layout.leftSpaceToView(self,15).topSpaceToView(self,33).heightIs(13).widthIs(32);
    _subjectLabel               = [[UILabel alloc]init];
    _subjectLabel.textColor     =[UIColor colorWithRed:0.20 green:0.20 blue:0.20 alpha:1.00];
    _subjectLabel.font          = [UIFont systemFontOfSize:17.0];
    _subjectLabel.textAlignment = NSTextAlignmentLeft;
    
    _subjectLabel.numberOfLines = 0;

    [self addSubview:self.subjectLabel];
    _subjectLabel.sd_layout.rightSpaceToView(self,15).leftSpaceToView(self.subjectTypeLabel,5).topSpaceToView(self,30).bottomSpaceToView(self,30);
}
/*显示文本： label.text=@"用户名";
显示文本颜色：label.textColor=[UIColor blueColor];
设置随机色      self.backgroundColor=[UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%255/255.0 blue:arc4random()%254/255.0 alpha:1];
边框线颜色：label.layer.borderColor =[UIColor redColor].CGColor;
边框线粗细：label.layer.borderWidth =1;
文本对其方式：label.textAlignment=1;
字体 label.font= [UIFont systemFontOfSize:25]
边框弧度：label.layer.cornerRadius =10;当等于半径是为圆形。*/


@end
