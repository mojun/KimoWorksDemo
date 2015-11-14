//
//  ProfileHeaderView.m
//  LBDemo
//
//  Created by mo jun on 11/14/15.
//  Copyright © 2015 kimoworks. All rights reserved.
//

#import "ProfileHeaderView.h"

@implementation ProfileHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.segmentView = [[LBSegmentView alloc]initWithNumberOfItems:3];
        self.segmentView.edgeInset = UIEdgeInsetsMake(0, 0, 12, 0);
        [self addSubview:self.segmentView];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.segmentView.frame = self.bounds;
    [self.segmentView reloadData];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
