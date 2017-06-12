//
//  SingleSelectView.h
//  Exam
//
//  Created by djzx on 2017/5/11.
//  Copyright © 2017年 djzx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SingleSelectActionBlock)(NSIndexPath *seleIndexPath, NSInteger btnTag);

@interface SingleSelectView : UIView

@property (copy, nonatomic) SingleSelectActionBlock SingleSelectBlock;

@property (strong, nonatomic) NSString    *seleIndexStr;

@property (strong, nonatomic) NSIndexPath *seleIndexPath;



@end
