//
//  ONImagePickerController.h
//  onion
//
//  Created by onion on 2019/2/21.
//  Copyright © 2019 Leo. All rights reserved.
//

#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ONImagePickerController : NSObject

//成功选取图片
@property (nonatomic, copy) void (^chooseImageBlock)(UIImage *image);

//取消选取
@property (nonatomic, copy) void (^cancelBlock)(void);

//标题颜色
@property (nonatomic, strong) UIColor *titleColor;

//选择时取消 按钮的文字颜色
@property (nonatomic, strong) UIColor *pickerCancelColor ;

+ (ONImagePickerController *)sharedInstance;

/**
 根据长宽比选择图片
 
 @param presentController 调出控制器的ViewController
 @param sourceType        类型（相机，图片）
 @param allowEdit         是否允许编辑
 @param cutFrame          自定义裁剪位置
 */

- (void)showImagePickerWithPresentController:(UIViewController *)presentController
								  sourceType:(UIImagePickerControllerSourceType)sourceType
								   allowEdit:(BOOL)allowEdit
									cutFrame:(CGRect)cutFrame;

@end

NS_ASSUME_NONNULL_END
