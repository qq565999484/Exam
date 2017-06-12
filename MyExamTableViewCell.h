//
//  MyExamTableViewCell.h
//  Exam
//
//  Created by djzx on 2017/5/11.
//  Copyright © 2017年 djzx. All rights reserved.

//

#import <UIKit/UIKit.h>

@interface MyExamTableViewCell : UITableViewCell

@property (strong, nonatomic) UIButton *selectedBtn;
//选项答案
@property(nonatomic ,strong)UILabel  * selectlable ;
@end
