//
//  ViewController.m
//  LBDemo
//
//  Created by mo jun on 11/13/15.
//  Copyright © 2015 kimoworks. All rights reserved.
//

#import "ViewController.h"
#import "LBNineGridView.h"
#import "LBNineGridCell.h"
#import "LBNineHeaderView.h"
#import "ProfileGridCell.h"
#import "ProfileHeaderView.h"
#import "ProfileSegmentItem.h"

@interface ViewController ()<LBNineGridViewDataSource, LBNineGridViewDelegate, LBSegmentViewDataSource, LBSegmentViewDelegate>{
    LBNineGridView *_gridView;
    
    /// 通过这个成员变量修改三个label的数据 例如[_headerView.segmentView itemAtIndex:1];获取中间的segmentItem
    ProfileHeaderView *_headerView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _gridView = [[LBNineGridView alloc]initWithDelegate:self dataSource:self];
    _gridView.hSpacing = 3;
    _gridView.vSpacing = 3;
    _gridView.headerHeight = 60;
    _gridView.shouldHiglighted = YES;
    [_gridView registerCellClass:[ProfileGridCell class]];
    [_gridView registerHeaderClass:[ProfileHeaderView class]];
    [_gridView addToSuperView:self.view];
    
    _gridView.collectionView.backgroundColor = [UIColor grayColor];
    [_gridView reloadData];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - LBNineGridViewDataSource
- (NSInteger)numberOfSectionsInGridView:(LBNineGridView *)gridView{
    return 1;
}

- (NSInteger)gridView:(LBNineGridView *)gridView numberOfItemsInSection:(NSInteger)section{
    return 36;
}

- (NSInteger)numberOfItemsPerRow:(LBNineGridView *)gridView{
    return 3;
}

- (LBNineGridCell *)gridView:(LBNineGridView *)gridView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ProfileGridCell *cell = (ProfileGridCell *)[gridView dequeueReusableCellWithReuseIdentifier:[ProfileGridCell registeredIdentifier] forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.titleLabel.text = [NSString stringWithFormat:@"item: %@", @(indexPath.row + 1)];
    cell.iconView.image = [UIImage imageNamed:@"nine-icon"];
    return cell;
}

- (LBNineHeaderView *)gridView:(LBNineGridView *)gridView forHeaderAtIndexPath:(NSIndexPath *)indexPath{
    ProfileHeaderView *header = (ProfileHeaderView *)[gridView dequeueReusableHeaderWithReuseIdentifier:[ProfileHeaderView registeredIdentifier] forIndexPath:indexPath];
    header.segmentView.delegate = self;
    header.segmentView.dataSource = self;
    _headerView = header;
    return header;
}

#pragma mark - LBNineGridViewDelegate
- (void)gridView:(LBNineGridView *)gridView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"didSelectItemAtIndexPath: %@", indexPath);
}

- (void)gridViewDidScroll:(LBNineGridView *)gridView{
    NSLog(@"scrollPosition: %@", NSStringFromCGPoint(gridView.collectionView.contentOffset));
}

#pragma mark - LBSegmentViewDataSource
- (UIControl *)segmentView:(LBSegmentView *)segmentView viewForItemAtIndex:(NSInteger)index{
    ProfileSegmentItem *item = [[ProfileSegmentItem alloc]init];
    item.titleLabel.text = [NSString stringWithFormat:@"今日收入%@", @(index)];
    item.numberLabel.text = @"￥500";
    return item;
}

#pragma mark - LBSegmentViewDelegate
- (void)segmentView:(LBSegmentView *)segmentView didSelectAtIndex:(NSInteger)index{
    NSLog(@"segment selectIndex: %@", @(index));
}

@end
