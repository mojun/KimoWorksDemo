//
//  LBNineGridView.h
//  LBDemo
//
//  Created by mo jun on 11/13/15.
//  Copyright © 2015 kimoworks. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LBNineGridView;
@class LBNineGridCell;
@class LBNineHeaderView;
@class LBNineFooterView;

@protocol LBNineGridViewDelegate;
@protocol LBNineGridViewDataSource;

@interface LBNineGridView : UIView<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong, readonly) UICollectionView *collectionView;
/// 点击是否有高亮
@property (nonatomic, assign) BOOL shouldHiglighted;
@property (nonatomic, weak) id<LBNineGridViewDataSource> dataSource;
@property (nonatomic, weak) id<LBNineGridViewDelegate> delegate;
@property (nonatomic, assign) CGFloat headerHeight;

/// 水平距离
@property (nonatomic, assign) CGFloat hSpacing;
/// 竖直距离
@property (nonatomic, assign) CGFloat vSpacing;

- (instancetype)initWithDelegate:(id<LBNineGridViewDelegate>)delegate
                      dataSource:(id<LBNineGridViewDataSource>)dataSource;

- (void)addToSuperView:(UIView *)superView;
- (void)reloadData;
- (void)registerCellClass:(Class)cellClass;
- (void)registerHeaderClass:(Class)headerClass;
- (void)registerFooterClass:(Class)footerClass;
- (LBNineGridCell *)dequeueReusableCellWithReuseIdentifier:(NSString *)identifier
                                              forIndexPath:(NSIndexPath *)indexPath;
- (LBNineHeaderView *)dequeueReusableHeaderWithReuseIdentifier:(NSString *)identifier
                                                  forIndexPath:(NSIndexPath *)indexPath;
- (LBNineFooterView *)dequeueReusableFooterWithReuseIdentifier:(NSString *)identifier
                                                  forIndexPath:(NSIndexPath *)indexPath;

@end

@protocol LBNineGridViewDelegate <NSObject>

@optional
- (void)gridView:(LBNineGridView *)gridView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)gridViewDidScroll:(LBNineGridView *)gridView;

@end

@protocol LBNineGridViewDataSource <NSObject>

@required
/// 配置多少个方块
- (NSInteger)gridView:(LBNineGridView *)gridView numberOfItemsInSection:(NSInteger)section;
/// 配置每行多少个方块
- (NSInteger)numberOfItemsPerRow:(LBNineGridView *)gridView;
/// 配置方块cell
- (LBNineGridCell *)gridView:(LBNineGridView *)gridView cellForItemAtIndexPath:(NSIndexPath *)indexPath;

@optional
/// 多少分组
- (NSInteger)numberOfSectionsInGridView:(LBNineGridView *)gridView;
/// 配置collection header
- (LBNineHeaderView *)gridView:(LBNineGridView *)gridView forHeaderAtIndexPath:(NSIndexPath *)indexPath;
/// 配置collection footer
- (LBNineFooterView *)gridView:(LBNineGridView *)gridView forFooterAtIndexPath:(NSIndexPath *)indexPath;

@end
