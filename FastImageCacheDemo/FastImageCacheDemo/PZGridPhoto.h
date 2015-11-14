//
//  PZGridPhoto.h
//  PlayZer
//
//  Created by mojun on 15/11/7.
//  Copyright © 2015年 kimoworks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FICEntity.h"

/// PZImage Family
extern NSString *const PZPhotoImageFormatFamily;

///这是album grid图片
extern NSString *const PZFICAlbumGridImageFormatName;

@interface PZGridPhoto : NSObject<FICEntity>

@property (nonatomic, copy) NSURL *sourceImageURL;
- (instancetype)initWithSourceImageURL:(NSURL *)sourceImageURL;

@end
