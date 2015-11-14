//
//  FICTableViewCell.m
//  FastImageCacheDemo
//
//  Created by mo jun on 11/14/15.
//  Copyright © 2015 kimoworks. All rights reserved.
//

#import "FICTableViewCell.h"
#import "FICImageCache.h"
#import "PZGridPhoto.h"

@implementation FICTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setPhoto:(PZGridPhoto *)photo{
    if (photo != _photo) {
        _photo = photo;
        __weak __typeof(&*self)weakSelf = self;
        UIImageView *imageView = self.iconView;
        [[FICImageCache sharedImageCache] retrieveImageForEntity:photo withFormatName:PZFICAlbumGridImageFormatName completionBlock:^(id<FICEntity> entity, NSString *formatName, UIImage *image) {
            // This completion block may be called much later. We should check to make sure this cell hasn't been reused for different photos before displaying the image that has loaded.
            if (entity == weakSelf.photo) {
                [imageView setImage:image];
                [imageView setNeedsLayout];
            }
        }];
    }
}

@end
