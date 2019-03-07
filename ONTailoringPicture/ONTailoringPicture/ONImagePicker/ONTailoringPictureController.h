//
//  ONTailoringPictureController.h
//  onion
//
//  Created by onion on 2019/3/7.
//  Copyright © 2019 Leo. All rights reserved.
//

#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 图片裁剪
 */
@class ONTailoringPictureController;

@protocol  ONTailoringPictureControllerDelegate <NSObject>


/**
 裁剪完成
 
 @param controller controller
 @param editImage  裁剪完的图片
 */
- (void)pictureTailoringViewController:(ONTailoringPictureController *)controller finishedEidtImage:(UIImage*)editImage;


/**
 取消裁剪
 
 @param controller controller
 */
- (void)pictureTailoringViewControllerDidCancel:(ONTailoringPictureController *)controller;

@end

@interface ONTailoringPictureController : UIViewController

/**
 *  图片裁剪界面初始化
 *
 *  @param cropImage 需要裁剪的图片
 *  @param cropSize  裁剪框的size
 *
 *  @return return value description
 */
- (instancetype)initWithCropImage:(UIImage*)cropImage cropSize:(CGSize)cropSize;
@property (nonatomic, weak) id<ONTailoringPictureControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
