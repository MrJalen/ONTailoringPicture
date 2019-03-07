# ONTailoringPictur

自定义相机
支持图片旋转、捏合、放大缩小、裁剪功能

# 效果图
![image](https://github.com/MrJalen/ONTailoringPicture/raw/master/ONTailoringPicture/ONTailoringPicture/123.gif)

# 使用
-- (void)showImagePicker:(UIImagePickerControllerSourceType)sourcetype {
	ONImagePickerController *imagePicker = [ONImagePickerController sharedInstance];
	[imagePicker showImagePickerWithPresentController:self sourceType:sourcetype allowEdit:YES cutFrame:CGRectMake(0, (kScreenHeight - kScreenWidth/1.6)/2, kScreenWidth, kScreenWidth/1.6)];
	[imagePicker setChooseImageBlock:^(UIImage * _Nonnull image) {
		NSLog(@"--image--%@",image);
		self.imageView.image = image;
	}];
}
