//
//  LBNineHeaderView.m
//  LBDemo
//
//  Created by mo jun on 11/14/15.
//  Copyright © 2015 kimoworks. All rights reserved.
//

#import "LBNineHeaderView.h"

@implementation LBNineHeaderView

+ (void)registerForCollectionView:(UICollectionView *)collectionView{
    [collectionView registerClass:[self class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[self registeredIdentifier]];
}

+ (NSString *)registeredIdentifier{
    return NSStringFromClass([self class]);
}

@end
