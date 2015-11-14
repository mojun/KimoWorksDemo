//
//  LBSegmentView.h
//  LBDemo
//
//  Created by mo jun on 11/14/15.
//  Copyright © 2015 kimoworks. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LBSegmentViewDelegate;
@protocol LBSegmentViewDataSource;

@interface LBSegmentView : UIView

@property (nonatomic, weak) id<LBSegmentViewDataSource> dataSource;
@property (nonatomic, weak) id<LBSegmentViewDelegate> delegate;
@property (nonatomic, assign) UIEdgeInsets edgeInset;

- (UIView *)itemAtIndex:(NSInteger)index;

- (instancetype)initWithNumberOfItems:(NSInteger)numberOfItems;

- (void)reloadData;

@end

@protocol LBSegmentViewDelegate <NSObject>

@optional
- (void)segmentView:(LBSegmentView *)segmentView didSelectAtIndex:(NSInteger)index;

@end

@protocol LBSegmentViewDataSource <NSObject>

@required
- (UIControl *)segmentView:(LBSegmentView *)segmentView viewForItemAtIndex:(NSInteger)index;

@end
