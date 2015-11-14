//
//  LBNineGridCell.m
//  LBDemo
//
//  Created by mo jun on 11/13/15.
//  Copyright © 2015 kimoworks. All rights reserved.
//

#import "LBNineGridCell.h"

@implementation LBNineGridCell

+ (void)registerForCollectionView:(UICollectionView *)collectionView{
    [collectionView registerClass:[self class] forCellWithReuseIdentifier:[self registeredIdentifier]];
    //    [collectionView registerNib:[UINib nibWithNibName:[self registeredIdentifier] bundle:nil] forCellWithReuseIdentifier:[self registeredIdentifier]];
}

+ (NSString *)registeredIdentifier{
    return NSStringFromClass([self class]);
}

- (void)highlightedShow{
    self.alpha = 0.5f;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.alpha = 1.0f;
    });
}

@end
