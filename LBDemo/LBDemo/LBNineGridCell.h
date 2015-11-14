//
//  LBNineGridCell.h
//  LBDemo
//
//  Created by mo jun on 11/13/15.
//  Copyright © 2015 kimoworks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBNineGridCell : UICollectionViewCell

+ (void)registerForCollectionView:(UICollectionView *)collectionView;
+ (NSString *)registeredIdentifier;

- (void)highlightedShow;

@end
