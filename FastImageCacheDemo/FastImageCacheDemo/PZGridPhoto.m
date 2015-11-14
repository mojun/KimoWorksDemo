//
//  PZGridPhoto.m
//  PlayZer
//
//  Created by mojun on 15/11/7.
//  Copyright © 2015年 kimoworks. All rights reserved.
//

#import "PZGridPhoto.h"
#import "FICUtilities.h"

NSString *const PZPhotoImageFormatFamily = @"PZPhotoImageFormatFamily";
NSString *const PZFICAlbumGridImageFormatName = @"com.kimoworks.playzer.PZFICAlbumGridImageFormatName";

@interface PZGridPhoto ()


@end

@implementation PZGridPhoto{
    NSString *_UUID;
}

- (instancetype)initWithSourceImageURL:(NSURL *)sourceImageURL{
    if (self = [super init]) {
        self.sourceImageURL = sourceImageURL;
    }
    return self;
}

#pragma mark - Protocol FICIMageCacheEntity
- (NSString *)UUID{
    if (_UUID == nil) {
        NSString *imageName = [self.sourceImageURL lastPathComponent];
        CFUUIDBytes UUIDBytes = FICUUIDBytesFromMD5HashOfString(imageName);
        _UUID = FICStringWithUUIDBytes(UUIDBytes);
    }
    return _UUID;
}

- (NSString *)sourceImageUUID{
    return [self UUID];
}

- (NSURL *)sourceImageURLWithFormatName:(NSString *)formatName{
    return _sourceImageURL;
}

- (FICEntityImageDrawingBlock)drawingBlockForImage:(UIImage *)image withFormatName:(NSString *)formatName{
    FICEntityImageDrawingBlock drawingBlock = ^(CGContextRef contextRef, CGSize contextSize) {
        CGRect contextBounds = CGRectZero;
        contextBounds.size = contextSize;
        CGContextClearRect(contextRef, contextBounds);
        
        if ([formatName isEqualToString:PZFICAlbumGridImageFormatName] == NO) {
            CGContextSetFillColorWithColor(contextRef, [[UIColor whiteColor] CGColor]);
            CGContextFillRect(contextRef, contextBounds);
        }
        
        UIImage *squareImage = _FICDSquareImageFromImage(image);
        
        // Clip to a rounded rect
        UIGraphicsPushContext(contextRef);
        [squareImage drawInRect:contextBounds];
        UIGraphicsPopContext();
    };
    return drawingBlock;
}

static UIImage * _FICDSquareImageFromImage(UIImage *image) {
    UIImage *squareImage = nil;
    CGSize imageSize = [image size];
    
    if (imageSize.width == imageSize.height) {
        squareImage = image;
    } else {
        // Compute square crop rect
        CGFloat smallerDimension = MIN(imageSize.width, imageSize.height);
        CGRect cropRect = CGRectMake(0, 0, smallerDimension, smallerDimension);
        
        // Center the crop rect either vertically or horizontally, depending on which dimension is smaller
        if (imageSize.width <= imageSize.height) {
            cropRect.origin = CGPointMake(0, rintf((imageSize.height - smallerDimension) / 2.0));
        } else {
            cropRect.origin = CGPointMake(rintf((imageSize.width - smallerDimension) / 2.0), 0);
        }
        
        CGImageRef croppedImageRef = CGImageCreateWithImageInRect([image CGImage], cropRect);
        squareImage = [UIImage imageWithCGImage:croppedImageRef];
        CGImageRelease(croppedImageRef);
    }
    
    return squareImage;
}

@end
