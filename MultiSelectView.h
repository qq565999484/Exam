//
//  MultiSelectView.h
//  Exam
//
//  Created by djzx on 2017/5/11.
//  Copyright © 2017年 djzx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MultiSelectActionBlock)(NSMutableArray * btnTagSum);

@interface MultiSelectView : UIView

@property (copy, nonatomic) MultiSelectActionBlock MultiSelectBlock;

@property (strong, nonatomic) NSMutableArray    *seleIndexarr;

//题目视图
@property(nonatomic,strong)UIView * headeview;
@end
