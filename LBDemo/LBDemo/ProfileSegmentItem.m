//
//  ProfileSegmentItem.m
//  LBDemo
//
//  Created by mo jun on 11/14/15.
//  Copyright © 2015 kimoworks. All rights reserved.
//

#import "ProfileSegmentItem.h"

@implementation ProfileSegmentItem

- (instancetype)init{
    if (self = [super init]) {
        self.titleLabel = [UILabel new];
        self.titleLabel.numberOfLines = 1;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        [self addSubview:self.titleLabel];
        
        self.numberLabel = [UILabel new];
        self.numberLabel.textColor = [UIColor orangeColor];
        self.numberLabel.numberOfLines = 1;
        self.numberLabel.textAlignment = NSTextAlignmentCenter;
        self.numberLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:self.numberLabel];
        
        self.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.9f];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGRect bounds = self.bounds;
    CGFloat width = CGRectGetWidth(bounds);
    CGFloat height = CGRectGetHeight(bounds);
    
    CGSize titleSize = [self.titleLabel sizeThatFits:CGSizeMake(width, CGFLOAT_MAX)];
    bounds.size = titleSize;
    bounds.origin = CGPointMake((width - titleSize.width) * 0.5f, (height * 0.5f - titleSize.height) * 0.5f);
    self.titleLabel.frame = bounds;
    
    bounds.origin.y += height * 0.5f;
    self.numberLabel.frame = bounds;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    self.alpha = 0.5f;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.alpha = 1.0f;
    });
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
