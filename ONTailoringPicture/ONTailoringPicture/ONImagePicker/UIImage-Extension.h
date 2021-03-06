//
//  UIImage-Extension.h
//  onion
//
//  Created by onion on 2019/3/7.
//  Copyright © 2019 Leo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIImage (CS_Extensions)

- (UIImage *)imageRotatedByRadians:(CGFloat)radians;
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;

- (UIImage *)resizedImageToFitInSize:(CGSize)boundingSize scaleIfSmaller:(BOOL)scale;
- (UIImage *)resizedImageToSize:(CGSize)dstSize;
- (UIImage *)cropImage:(CGRect)rect;
- (UIImage *)fixOrientation;

//按比例缩放,size 是你要把图显示到 多大区域 CGSizeMake(300, 140)
- (UIImage *) imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size;

//指定宽度按比例缩放
- (UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;

@end


