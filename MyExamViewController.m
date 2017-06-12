//
//  MyExamViewController.m
//  Exam
//
//  Created by djzx on 2017/5/11.
//  Copyright © 2017年 djzx. All rights reserved.
//

#import "MyExamViewController.h"


#import "SingleSelectView.h"
#import "MultiSelectView.h"
#import "UIButton+BackgroundColor.h"

#import "Header.h"

@interface MyExamViewController ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@property (strong, nonatomic) UICollectionViewFlowLayout *collectionViewLayout;

@property (strong, nonatomic) UICollectionView           *collectionView;

//数据源
@property (strong, nonatomic) NSMutableArray             *dataSource;
//答案
@property (strong, nonatomic) NSMutableArray             *resultArray;

@property (strong, nonatomic) NSMutableArray             *indexPathArray;
//当前选中的item
@property (assign, nonatomic) NSInteger                   currentSelectIndex;

@end

@implementation MyExamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"市场营销考试";
    [self initView];
    
    [self initData];
}

- (void)initView {
    
    
    
    [self.view addSubview:self.collectionView];
    
//            NSLog(@"%ld哈哈哈哈哈哈%lu",(long)indexPath.item,(unsigned long)self.dataSource.count);
    
    

}

- (void)initData {

    [self dataSource];
    [self resultArray];
    [self indexPathArray];
    
    _dataSource = @[@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@""].mutableCopy;
    
    for (int i = 0; i < _dataSource.count; i++) {
        
        [_resultArray addObject:@[]];
        [_indexPathArray addObject:@[]];
    }
    

}

// 设置单元格的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _dataSource.count;
}

// 设置段数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    
    if (cell) {
        
        for (UIView *view in cell.contentView.subviews) {
            
            if (view) {
                
                [view removeFromSuperview];
            }
        }
    }
    
    if (indexPath.item % 2 == 0) {
    
        SingleSelectView *singleView = [[SingleSelectView alloc]init];
        singleView.frame = cell.contentView.bounds;
        [cell.contentView addSubview:singleView];
        
        if ([_resultArray[indexPath.item] isKindOfClass:[NSString class]] && [_indexPathArray[indexPath.item] isKindOfClass:[NSIndexPath class]]) {
            
            singleView.seleIndexStr  = _resultArray[indexPath.item];
            singleView.seleIndexPath = _indexPathArray[indexPath.item];
        }
        __weak typeof(self) weakSelf = self;

        singleView.SingleSelectBlock = ^(NSIndexPath *seleIndexPath, NSInteger btnTag) {
            
            __strong typeof(weakSelf)strongSelf = weakSelf;
            
            if ([_resultArray[indexPath.item] isKindOfClass:[NSString class]] &&[[strongSelf.resultArray objectAtIndex:indexPath.item]isEqualToString:[NSString stringWithFormat:@"%ld",btnTag]]) {
                [strongSelf.resultArray replaceObjectAtIndex:indexPath.item withObject:@[]];
            }else{
                [strongSelf.resultArray replaceObjectAtIndex:indexPath.item withObject:[NSString stringWithFormat:@"%ld",btnTag]];
            }
            [strongSelf.indexPathArray replaceObjectAtIndex:indexPath.item withObject:seleIndexPath];
            
            NSLog(@"strongSelf.resultArray==%@",strongSelf.resultArray);
            
            //单选选中后滑动到下一页
            NSLog(@"%ld,%lu",(long)indexPath.item,(unsigned long)self.dataSource.count);
            if (indexPath.item+1<self.dataSource.count&&[_resultArray[indexPath.item] isKindOfClass:[NSString class]]) {
                
                [strongSelf.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:indexPath.item + 1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
            }
        };
        
    }else {
    
        
        MultiSelectView *multiView = [[MultiSelectView alloc]init];
        multiView.frame = cell.contentView.bounds;
        [cell.contentView addSubview:multiView];
        
        if ([_resultArray[indexPath.item] isKindOfClass:[NSMutableArray class]]) {
            
            //多选选项
            multiView.seleIndexarr  = _resultArray[indexPath.item];
        }
        
        __weak typeof(self) weakSelf = self;
        
        multiView.MultiSelectBlock = ^(NSMutableArray * btnTagSum) {
        
            __strong typeof(weakSelf)strongSelf = weakSelf;
            
//            [strongSelf.resultArray replaceObjectAtIndex:indexPath.item withObject:[NSString stringWithFormat:@"%ld",btnTagSum]];
            [strongSelf.resultArray replaceObjectAtIndex:indexPath.item withObject:btnTagSum];
        };
    }
    NSLog(@"%ld哈哈哈哈哈哈%lu",(long)indexPath.item,(unsigned long)self.dataSource.count);

    if (indexPath.item +1 == self.dataSource.count) {
        UIButton * commitbutton = [[UIButton alloc]initWithFrame:CGRectMake(0, cell.contentView.bounds.size.height-40, ScreenWidth, 40)];
        [commitbutton setTitle:@"提交" forState:(UIControlStateNormal)];
        //        [commitbutton setTintColor: [UIColor redColor]];
        [commitbutton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [commitbutton setTitleColor:[UIColor purpleColor] forState:UIControlStateHighlighted];
        [commitbutton setBackgroundColor:[UIColor greenColor] forState:UIControlStateHighlighted];
        [commitbutton setBackgroundColor:[UIColor blueColor] forState:UIControlStateNormal];
        
        //        commitbutton.backgroundColor = [UIColor orangeColor];
        [cell.contentView addSubview:commitbutton];
        
        [commitbutton addTarget:self action:@selector(commitdaan) forControlEvents:UIControlEventTouchUpInside];
    }

    return cell;
}


//提交
-(void)commitdaan{
        NSLog(@"大案要案==%@",_resultArray);

    
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    [self scrollViewEndScrolling:scrollView.contentOffset];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

    [self scrollViewEndScrolling:scrollView.contentOffset];
//    NSLog(@"结果==%@/n%@",_resultArray,_indexPathArray);

}

// 设置单元格大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 单元格默认大小：50*50
    // 第一个参数：设置单元格的宽
    // 第二个参数：设置单元格的高
    return CGSizeMake(ScreenWidth, ScreenHeight - 64 );
}

// cell与cell之间的间隔，边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    //上左下右
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

// 设置垂直最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0;
}

// 设置水平最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0;
}

// 设置标题头大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    // 第一个参数：只有当水平滑动时有效
    // 第二个参数：只有当垂直滑动时有效
    return CGSizeMake(0, 0);
}

- (void)scrollViewEndScrolling:(CGPoint)contentOffset {

    NSInteger index = contentOffset.x / ScreenWidth;
    

    
    _currentSelectIndex = index;
}

//上一题下一题
- (void)collectionViewScrollToItem:(BOOL)bl btnTag:(NSInteger)btnTag {
    
   

    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_currentSelectIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionViewLayout                          = [[UICollectionViewFlowLayout alloc] init]; // 自定义的布局对象
        _collectionView                                = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64 , ScreenWidth, ScreenHeight - 64 ) collectionViewLayout:_collectionViewLayout];
        //移动方向
        _collectionViewLayout.scrollDirection          = UICollectionViewScrollDirectionHorizontal;
        //是否显示
        _collectionView.showsHorizontalScrollIndicator = NO;
        //是否有反弹效果
        _collectionView.bounces                        = YES;
        //是否整页翻页
        _collectionView.pagingEnabled                  = YES;
        //数据源代理
        _collectionView.dataSource                     = self;
        _collectionView.delegate                       = self;
        //滚动返回至顶部
        _collectionView.scrollsToTop                   = NO;
        _collectionView.backgroundColor                = [UIColor whiteColor];
        // 注册cell
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    }
    return _collectionView;
}



- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc]init];
    }
    return _dataSource;
}

- (NSMutableArray *)resultArray {
    if (!_resultArray) {
        _resultArray = [[NSMutableArray alloc]init];
    }
    return _resultArray;
}

- (NSMutableArray *)indexPathArray {
    if (!_indexPathArray) {
        _indexPathArray = [[NSMutableArray alloc]init];
    }
    return _indexPathArray;
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
