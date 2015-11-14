//
//  ProfileGridCell.m
//  LBDemo
//
//  Created by mo jun on 11/13/15.
//  Copyright © 2015 kimoworks. All rights reserved.
//

#import "ProfileGridCell.h"

#define kIconWidth 32
#define kIconHeight 32

@implementation ProfileGridCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel = [UILabel new];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.numberOfLines = 1;
        [self addSubview:self.titleLabel];
        
        self.iconView = [UIImageView new];
        [self addSubview:self.iconView];
    }
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGRect bounds = self.bounds;
    CGFloat width = CGRectGetWidth(bounds);
    CGFloat height = CGRectGetHeight(bounds);
    self.iconView.frame = CGRectMake((width - kIconWidth) * 0.5f, height * 0.5f - kIconHeight
                                     , kIconWidth, kIconHeight);
    

    CGSize size = [self.titleLabel sizeThatFits:CGSizeMake(width, CGFLOAT_MAX)];
    bounds.size = size;
    bounds.origin.x = (width - size.width) * 0.5f;
    bounds.origin.y = height * 0.5f + 8;
    self.titleLabel.frame = bounds;
    
}

@end
