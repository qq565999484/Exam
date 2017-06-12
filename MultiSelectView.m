//
//  MultiSelectView.m
//  Exam
//
//  Created by djzx on 2017/5/11.
//  Copyright © 2017年 djzx. All rights reserved.

//

#import "MultiSelectView.h"
#import "UIView+SDAutoLayout.h"
#import "MyExamTableViewCell.h"

#import "MyExamHeaderView.h"


#import "Header.h"

@interface MultiSelectView ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) MyExamHeaderView *myExamHeaderView;

@property (strong, nonatomic) UITableView      *tableView;


//多选答案放进数组
@property (strong, nonatomic) NSMutableArray   *sumArray;

@end

@implementation MultiSelectView

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        [self initData];
        [self initView];
        
    }
    return self;
}

- (void)initView {
    
    [self addSubview:self.tableView];
    _tableView.tableHeaderView = self.myExamHeaderView;
    CGRect newFrame = self.myExamHeaderView.frame;
    // 获取不确定文字的高度
    self.myExamHeaderView.subjectTypeLabel.text = @"多选题";
    self.myExamHeaderView.subjectTypeLabel.textColor = [UIColor colorWithRed:0.95 green:0.58 blue:0.17 alpha:1.00];
    self.myExamHeaderView.subjectTypeLabel.layer.borderColor =[UIColor colorWithRed:0.95 green:0.58 blue:0.17 alpha:1.00].CGColor;
   _myExamHeaderView.subjectLabel.text = @"回想起这个能力也是机缘巧合下得到的；小时候家里有条大白狗，我们的关系那叫一个亲，它天天都会背着年幼的我四处跑。可惜好事不长久，不久它就被人投毒了，临死的那一刻，它意外的咬了我一口；虽然没什么事，但母亲却再也不给我养狗了，因为这，我伤心了很长一段时间。";
    CGFloat testHeight = [self sizeWithFont:[UIFont systemFontOfSize:17.0] maxW:ScreenWidth-67 withContent:_myExamHeaderView.subjectLabel.text] ;
    newFrame.size.height =   testHeight+60;
    self.myExamHeaderView.frame = newFrame;
    
    [self.tableView beginUpdates];
    
    [self.tableView setTableHeaderView: self.myExamHeaderView];
    [self.tableView endUpdates];

}

- (void)initData {
    
    [self sumArray];

    
}

- (void)setSeleIndexStr:(NSMutableArray *)seleIndexStr {
    
    _seleIndexarr = seleIndexStr;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *string   = @"UITableViewCell";
    
    MyExamTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:string];
    
    if (!cell) {
        
        cell = [[MyExamTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string];
    }
    
//    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    
    switch (indexPath.row) {
            
        case 0:
            [cell.selectedBtn setTitle:@"A" forState:UIControlStateNormal];
            cell.selectedBtn.tag = 1;
            break;
        case 1:
            [cell.selectedBtn setTitle:@"B" forState:UIControlStateNormal];
            cell.selectedBtn.tag = 2;
            break;
        case 2:
            [cell.selectedBtn setTitle:@"C" forState:UIControlStateNormal];
            cell.selectedBtn.tag = 3;
            break;
        case 3:
            [cell.selectedBtn setTitle:@"D" forState:UIControlStateNormal];
            cell.selectedBtn.tag = 4;
            break;
        case 4:
            [cell.selectedBtn setTitle:@"E" forState:UIControlStateNormal];
            cell.selectedBtn.tag = 5;
            break;
            
        default:
            break;
    }
    
    if (_seleIndexarr.count > 0) {
        
        for (NSString *i in _seleIndexarr) {
            if ([i isEqualToString:[NSString stringWithFormat:@"%ld",(long)cell.selectedBtn.tag]]) {
                cell.selectedBtn.selected = YES;
            }
        }
    }
    //选项的弧度
    cell.selectedBtn.layer.cornerRadius = 5;

    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MyExamTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    cell.selectedBtn.selected = !cell.selectedBtn.selected;
    
    if (![_sumArray containsObject:[NSString stringWithFormat:@"%ld",cell.selectedBtn.tag]]) {
        
        [_sumArray addObject:[NSString stringWithFormat:@"%ld",cell.selectedBtn.tag]];
    
    }else {
    
        [_sumArray removeObject:[NSString stringWithFormat:@"%ld",cell.selectedBtn.tag]];
    }

    
    __weak typeof(self) weakSelf = self;

    if (self.MultiSelectBlock) {
        
        self.MultiSelectBlock(weakSelf.sumArray);
    }
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64)style:UITableViewStyleGrouped];
        _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        _tableView.delegate        = self;
        _tableView.dataSource      = self;
        _tableView.backgroundColor = [UIColor whiteColor];

    }
    return _tableView;
}

- (MyExamHeaderView *)myExamHeaderView {
    if (!_myExamHeaderView) {
        _myExamHeaderView = [[MyExamHeaderView alloc]init];
    }
    return _myExamHeaderView;
}




- (NSMutableArray *)sumArray {
    if (!_sumArray) {
        _sumArray = [[NSMutableArray alloc]init];
    }
    return _sumArray;
}
// 计算指定文字的高度
-(CGFloat)sizeWithFont:(UIFont *)font maxW:(CGFloat) maxW withContent:(NSString *)testStr{
    
    NSDictionary *textAttrs = @{NSFontAttributeName : font};
    CGSize size = CGSizeMake(maxW, MAXFLOAT);
    return [testStr boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:textAttrs context:nil].size.height;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
