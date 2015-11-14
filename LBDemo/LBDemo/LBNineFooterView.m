//
//  LBNineFooterView.m
//  LBDemo
//
//  Created by mo jun on 11/14/15.
//  Copyright © 2015 kimoworks. All rights reserved.
//

#import "LBNineFooterView.h"

@implementation LBNineFooterView

+ (void)registerForCollectionView:(UICollectionView *)collectionView{
    [collectionView registerClass:[self class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:[self registeredIdentifier]];
}

+ (NSString *)registeredIdentifier{
    return NSStringFromClass([self class]);
}

@end
