//
//  LBSegmentView.m
//  LBDemo
//
//  Created by mo jun on 11/14/15.
//  Copyright © 2015 kimoworks. All rights reserved.
//

#import "LBSegmentView.h"

@implementation LBSegmentView{
    NSMutableArray *_itemViews;
    NSInteger _numberOfItems;
}

- (instancetype)initWithNumberOfItems:(NSInteger)numberOfItems{
    if (self = [super init]) {
        _numberOfItems = numberOfItems;
    }
    return self;
}

- (NSMutableArray *)itemViews{
    if (_itemViews == nil) {
        _itemViews = [NSMutableArray arrayWithCapacity:3];
    }
    return _itemViews;
}

- (UIView *)itemAtIndex:(NSInteger)index{
    return [self.itemViews objectAtIndex:index];
}

- (void)clean{
    for (UIControl *view in self.itemViews) {
        [view removeFromSuperview];
    }
    [self.itemViews removeAllObjects];
}

- (void)load{
    for (NSInteger i=0; i<_numberOfItems; i++) {
        UIControl *item = [self.dataSource segmentView:self viewForItemAtIndex:i];
        [self.itemViews addObject:item];
        [self addSubview:item];
        [item addTarget:self action:@selector(touchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)reloadData{
    
    [self clean];
    
    [self load];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (_numberOfItems <= 0) {
        return;
    }
    
    CGRect bounds = self.bounds;
    CGFloat width = CGRectGetWidth(bounds);
    CGFloat height = CGRectGetHeight(bounds);
    UIEdgeInsets inset = self.edgeInset;
    
    CGFloat xPos = inset.left;
    CGFloat yPos = inset.top;
    CGFloat itemWidth = (width - inset.left - inset.right) / _numberOfItems;
    CGFloat itemHeight = height - inset.top - inset.bottom;
    for (NSInteger i=0; i<_numberOfItems; i++) {
        UIControl *item = self.itemViews[i];
        CGRect itemFrame = CGRectMake(xPos, yPos, itemWidth, itemHeight);
        xPos += itemWidth;
        item.frame = itemFrame;
    }
}

#pragma mark - Action
- (void)touchUpInside:(UIControl *)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(segmentView:didSelectAtIndex:)]) {
        NSInteger index = [self.itemViews indexOfObject:sender];
        [self.delegate segmentView:self didSelectAtIndex:index];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
