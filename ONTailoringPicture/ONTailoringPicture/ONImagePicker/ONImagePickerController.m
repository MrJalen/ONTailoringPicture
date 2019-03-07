//
//  ONImagePickerController.m
//  onion
//
//  Created by onion on 2019/2/21.
//  Copyright © 2019 Leo. All rights reserved.
//

#import "ONImagePickerController.h"
#import "ONTailoringPictureController.h"

@interface ONImagePickerController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, ONTailoringPictureControllerDelegate>

@property (nonatomic, strong) UIViewController *presentController;
@property (nonatomic, strong) UIImagePickerController *picker;
@property (nonatomic, assign) BOOL allowEdit;
@property (nonatomic, assign) CGRect cutFrame;

@end

@implementation ONImagePickerController

+ (ONImagePickerController *)sharedInstance {
	static ONImagePickerController *manager = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		manager = [[ONImagePickerController alloc] init];
	});
	return manager;
}

- (void)showImagePickerWithPresentController:(UIViewController *)presentController
								  sourceType:(UIImagePickerControllerSourceType)sourceType
								   allowEdit:(BOOL)allowEdit
									cutFrame:(CGRect)cutFrame
{
	self.presentController = presentController;
	self.allowEdit = allowEdit;
	self.cutFrame = cutFrame;
	
	self.picker = [[UIImagePickerController alloc] init];
	self.picker.delegate = self;
	self.picker.sourceType = sourceType;
	
	[self.picker setAllowsEditing:NO];
	
	if (self.titleColor){
		[self.picker.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:self.titleColor}];
	}
	
	if (self.pickerCancelColor) {
		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
			UIBarButtonItem *item = self.picker.navigationBar.topItem.rightBarButtonItem;
			item.tintColor = self.pickerCancelColor;
		});
	}
	[self.presentController presentViewController:self.picker animated: YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
	UIImage *image = nil;
	image = info[UIImagePickerControllerOriginalImage];
	image = [ONImagePickerController fixOriginalImage:image];
	
	if (!self.allowEdit) {
		if (self.chooseImageBlock) {
			self.chooseImageBlock(image);
		}
	} else {
		image = info[UIImagePickerControllerOriginalImage];
		ONTailoringPictureController *tailoringVC = [[ONTailoringPictureController alloc] initWithCropImage:image cropSize:CGSizeMake(kScreenWidth, kScreenWidth/1.6)];
		tailoringVC.delegate = self;
		[picker pushViewController:tailoringVC animated:YES];
	}
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
	[picker dismissViewControllerAnimated:YES completion:^{
		if (self.cancelBlock) {
			self.cancelBlock();
		}
	}];
}

/**
 裁剪完成
 
 @param controller controller
 @param editImage  裁剪完的图片
 */
- (void)pictureTailoringViewController:(ONTailoringPictureController *)controller finishedEidtImage:(UIImage *)editImage {
	[self.picker dismissViewControllerAnimated:YES completion:nil];
	if (self.chooseImageBlock) {
		self.chooseImageBlock(editImage);
	}
}

/**
 取消裁剪
 
 @param controller controller
 */
- (void)pictureTailoringViewControllerDidCancel:(ONTailoringPictureController *)controller {
	[self.picker dismissViewControllerAnimated:YES completion:nil];
}

/**
 修正图片，使其显示方向正确
 */
+ (UIImage *)fixOriginalImage:(UIImage *)originalImage {
	if (originalImage.imageOrientation == UIImageOrientationUp) return originalImage;
	CGAffineTransform transform = CGAffineTransformIdentity;
	switch (originalImage.imageOrientation) {
		case UIImageOrientationDown:
		case UIImageOrientationDownMirrored:
			transform = CGAffineTransformTranslate(transform, originalImage.size.width, originalImage.size.height);
			transform = CGAffineTransformRotate(transform, M_PI);
			break;
			
		case UIImageOrientationLeft:
		case UIImageOrientationLeftMirrored:
			transform = CGAffineTransformTranslate(transform, originalImage.size.width, 0);
			transform = CGAffineTransformRotate(transform, M_PI_2);
			break;
			
		case UIImageOrientationRight:
		case UIImageOrientationRightMirrored:
			transform = CGAffineTransformTranslate(transform, 0, originalImage.size.height);
			transform = CGAffineTransformRotate(transform, -M_PI_2);
			break;
		case UIImageOrientationUp:
		case UIImageOrientationUpMirrored:
			break;
	}
	
	switch (originalImage.imageOrientation) {
		case UIImageOrientationUpMirrored:
		case UIImageOrientationDownMirrored:
			transform = CGAffineTransformTranslate(transform, originalImage.size.width, 0);
			transform = CGAffineTransformScale(transform, -1, 1);
			break;
			
		case UIImageOrientationLeftMirrored:
		case UIImageOrientationRightMirrored:
			transform = CGAffineTransformTranslate(transform, originalImage.size.height, 0);
			transform = CGAffineTransformScale(transform, -1, 1);
			break;
		case UIImageOrientationUp:
		case UIImageOrientationDown:
		case UIImageOrientationLeft:
		case UIImageOrientationRight:
			break;
	}
	
	CGContextRef ctx = CGBitmapContextCreate(NULL, originalImage.size.width, originalImage.size.height,
											 CGImageGetBitsPerComponent(originalImage.CGImage), 0,
											 CGImageGetColorSpace(originalImage.CGImage),
											 CGImageGetBitmapInfo(originalImage.CGImage));
	CGContextConcatCTM(ctx, transform);
	switch (originalImage.imageOrientation) {
		case UIImageOrientationLeft:
		case UIImageOrientationLeftMirrored:
		case UIImageOrientationRight:
		case UIImageOrientationRightMirrored:
			CGContextDrawImage(ctx, CGRectMake(0,0,originalImage.size.height,originalImage.size.width), originalImage.CGImage);
			break;
			
		default:
			CGContextDrawImage(ctx, CGRectMake(0,0,originalImage.size.width,originalImage.size.height), originalImage.CGImage);
			break;
	}
	
	CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
	UIImage *img = [UIImage imageWithCGImage:cgimg];
	CGContextRelease(ctx);
	CGImageRelease(cgimg);
	return img;
}

@end
