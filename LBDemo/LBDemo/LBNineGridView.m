//
//  LBNineGridView.m
//  LBDemo
//
//  Created by mo jun on 11/13/15.
//  Copyright © 2015 kimoworks. All rights reserved.
//

#import "LBNineGridView.h"
#import "LBNineGridCell.h"
#import "LBNineHeaderView.h"
#import "LBNineFooterView.h"
#import "Masonry.h"

@implementation LBNineGridView

#pragma mark initialize
- (instancetype)initWithDelegate:(id<LBNineGridViewDelegate>)delegate
                      dataSource:(id<LBNineGridViewDataSource>)dataSource{
    if (self = [super init]) {
        self.delegate = delegate;
        self.dataSource = dataSource;
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = NO;
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.clipsToBounds = NO;
        _collectionView.allowsSelection = YES;
        _collectionView.alwaysBounceVertical = YES;
        [self addSubview:_collectionView];
        UIEdgeInsets insets = UIEdgeInsetsZero;
        _collectionView.contentInset = insets;
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    NSLog(@"bounds: %@ frame: %@", NSStringFromCGRect(self.bounds), NSStringFromCGRect(self.frame));
    
    NSInteger width = CGRectGetWidth(self.bounds);
    NSInteger numberOfItemsPerRow = [self.dataSource numberOfItemsPerRow:self];
    NSAssert(numberOfItemsPerRow > 0, @"每行不能小于0");
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.sectionInset = UIEdgeInsetsZero;
    layout.minimumInteritemSpacing = self.hSpacing;
    layout.minimumLineSpacing = self.vSpacing;
    
    CGFloat itemWidth = (width - self.hSpacing * (numberOfItemsPerRow - 1)) / numberOfItemsPerRow;
    CGFloat itemHeight = itemWidth;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    layout.headerReferenceSize = CGSizeMake(width, self.headerHeight);
    self.collectionView.collectionViewLayout = layout;
    
}

#pragma mark - UICollectionView DataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    NSInteger number = 0;
    if ([self.dataSource respondsToSelector:@selector(numberOfSectionsInGridView:)]) {
        number = [self.dataSource numberOfSectionsInGridView:self];
    }
    return number;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.dataSource gridView:self numberOfItemsInSection:section];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [self.dataSource gridView:self cellForItemAtIndexPath:indexPath];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *resuableView = nil;
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        if ([self.dataSource respondsToSelector:@selector(gridView:forHeaderAtIndexPath:)]) {
            resuableView = [self.dataSource gridView:self forHeaderAtIndexPath:indexPath];
        }
    } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        resuableView = [self.dataSource gridView:self forFooterAtIndexPath:indexPath];
    }
    
    return resuableView;
}

#pragma mark - UICollection Delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(gridView:didSelectItemAtIndexPath:)]) {
        [self.delegate gridView:self didSelectItemAtIndexPath:indexPath];
    }
    
    if (self.shouldHiglighted) {
        LBNineGridCell *cell = (LBNineGridCell *)[collectionView cellForItemAtIndexPath:indexPath];
        [cell highlightedShow];
    }
    
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([self.delegate respondsToSelector:@selector(gridViewDidScroll:)]) {
        [self.delegate gridViewDidScroll:self];
    }
}

#pragma mark - public
- (void)reloadData{
    [_collectionView.collectionViewLayout invalidateLayout];
    [_collectionView reloadData];
}

- (void)addToSuperView:(UIView *)superView{
    [superView addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make){
        make.edges.equalTo(superView);
    }];
}

- (void)registerCellClass:(Class)cellClass{
    [cellClass registerForCollectionView:_collectionView];
}

- (void)registerHeaderClass:(Class)headerClass{
    [headerClass registerForCollectionView:_collectionView];
}

- (void)registerFooterClass:(Class)footerClass{
    [footerClass registerForCollectionView:_collectionView];
}

- (LBNineGridCell *)dequeueReusableCellWithReuseIdentifier:(NSString *)identifier
                                                    forIndexPath:(NSIndexPath *)indexPath{
    LBNineGridCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    return cell;
}

- (LBNineHeaderView *)dequeueReusableHeaderWithReuseIdentifier:(NSString *)identifier
                                                  forIndexPath:(NSIndexPath *)indexPath{
    return [_collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifier forIndexPath:indexPath];
}
- (LBNineFooterView *)dequeueReusableFooterWithReuseIdentifier:(NSString *)identifier
                                                  forIndexPath:(NSIndexPath *)indexPath{
    return [_collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:identifier forIndexPath:indexPath];
}

@end
