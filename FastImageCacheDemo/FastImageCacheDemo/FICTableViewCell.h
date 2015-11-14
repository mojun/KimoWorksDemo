//
//  FICTableViewCell.h
//  FastImageCacheDemo
//
//  Created by mo jun on 11/14/15.
//  Copyright © 2015 kimoworks. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PZGridPhoto;
@interface FICTableViewCell : UITableViewCell

@property (nonatomic, weak) PZGridPhoto *photo;

@property (nonatomic, strong) IBOutlet UIImageView *iconView;

@end
