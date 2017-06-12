//
//  SingleSelectView.m
//  Exam
//
//  Created by djzx on 2017/5/11.
//  Copyright © 2017年 djzx. All rights reserved.

//

#import "SingleSelectView.h"

#import "MyExamTableViewCell.h"

#import "MyExamHeaderView.h"

#import "Header.h"

@interface SingleSelectView ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) MyExamHeaderView *myExamHeaderView;

@property (strong, nonatomic) UITableView      *tableView;


@property (strong, nonatomic) NSIndexPath      *currentSelectIndex;

@end

@implementation SingleSelectView

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        
        [self initView];
    }
    return self;
}

- (void)initView {
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.tableView];
    
    self.myExamHeaderView.subjectTypeLabel.text = @"单选题";
    self.myExamHeaderView.subjectTypeLabel.textColor = [UIColor colorWithRed:0.40 green:0.83 blue:0.81 alpha:1.00];
    self.myExamHeaderView.subjectTypeLabel.layer.borderColor =[UIColor colorWithRed:0.40 green:0.83 blue:0.81 alpha:1.00].CGColor;
        self.myExamHeaderView.subjectLabel.text = @"任桥记得有一天下午，忽然刮起了狂风，空中布满沙尘。太阳一时间无影无踪。任桥惊奇的发现，大街上只剩下了女人和青蛙。女人们在狂风之下东倒西歪，而青蛙们则异常兴奋。片刻间，大雨如注，倾盆而下。世界成了一片欢快的海洋。";
    _tableView.tableHeaderView = self.myExamHeaderView;
    CGRect newFrame = self.myExamHeaderView.frame;
    // 获取不确定文字的高度

    CGFloat testHeight = [self sizeWithFont:[UIFont systemFontOfSize:17.0] maxW:ScreenWidth-67 withContent:self.myExamHeaderView.subjectLabel.text] ;
    newFrame.size.height =   testHeight+60;
    self.myExamHeaderView.frame = newFrame;

    [self.tableView beginUpdates];

    [self.tableView setTableHeaderView: self.myExamHeaderView];
    [self.tableView endUpdates];

}
- (void)setSeleIndexStr:(NSString *)seleIndexStr {

    _seleIndexStr = seleIndexStr;
}

- (void)setSeleIndexPath:(NSIndexPath *)seleIndexPath {

    _seleIndexPath = seleIndexPath;
    _currentSelectIndex = _seleIndexPath;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
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
    cell.selectedBtn.layer.cornerRadius = 10;

    if (cell.selectedBtn.tag == [_seleIndexStr integerValue]) cell.selectedBtn.selected = YES;
    
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
    
    if (_currentSelectIndex != nil && _currentSelectIndex != indexPath) {
        
        MyExamTableViewCell  *cell = [tableView cellForRowAtIndexPath:_currentSelectIndex];
        cell.selectedBtn.selected  = NO;
    }
    
    MyExamTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    cell.selectedBtn.selected = !cell.selectedBtn.selected;

    _currentSelectIndex = indexPath;
    
    
    if (self.SingleSelectBlock) {
        
        self.SingleSelectBlock(indexPath, cell.selectedBtn.tag);
    }
}
// 计算指定文字的高度
-(CGFloat)sizeWithFont:(UIFont *)font maxW:(CGFloat) maxW withContent:(NSString *)testStr{
    
    NSDictionary *textAttrs = @{NSFontAttributeName : font};
    CGSize size = CGSizeMake(maxW, MAXFLOAT);
    return [testStr boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:textAttrs context:nil].size.height;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64)style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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


@end
