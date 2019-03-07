//
//  ONPictureCropperView.h
//  onion
//
//  Created by onion on 2019/3/7.
//  Copyright © 2019 Leo. All rights reserved.
//

#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ONPictureCropperView : UIView

/**
 *  图片裁剪初始化
 *
 *  @param cropImage 需要裁剪的图片
 *  @param cropSize  裁剪框的size 目前裁剪框的宽度为屏幕宽度
 *
 *  @return return value description
 */
- (id)initWithCropImage:(UIImage*)cropImage cropSize:(CGSize)cropSize;

- (UIImage*)getCroppedImage;//获取裁剪后的图片

- (void) actionRotate;//旋转

- (id)init __deprecated_msg("Use `- (id)initWithCropImage:(UIImage*)cropImage cropSize:(CGSize)cropSize`");
- (id)initWithFrame:(CGRect)frame __deprecated_msg("Use `- (id)initWithCropImage:(UIImage*)cropImage cropSize:(CGSize)cropSize`");

@property (nonatomic,strong) UIView *topView;
@property (nonatomic,strong) UIView *bottomView;

@end

NS_ASSUME_NONNULL_END
