//
//  ONTailoringPictureController.m
//  onion
//
//  Created by onion on 2019/3/7.
//  Copyright © 2019 Leo. All rights reserved.
//

#import "ONTailoringPictureController.h"
#import "ONPictureCropperView.h"
#import "UIImage-Extension.h"

@interface ONTailoringPictureController ()

@property (nonatomic,strong) ONPictureCropperView *cropperView;

@end

@implementation ONTailoringPictureController

- (instancetype)initWithCropImage:(UIImage*)cropImage cropSize:(CGSize)cropSize {
	if (self = [super init]) {
		//裁剪View
		_cropperView = [[ONPictureCropperView alloc] initWithCropImage:cropImage cropSize:cropSize];
		[self.view addSubview:_cropperView];
		
		UILabel *topLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _cropperView.topView.frame.size.height - 40, kScreenWidth, 20)];
		topLabel.text = @"裁剪框";
		topLabel.font = [UIFont systemFontOfSize:16];
		topLabel.textColor = [UIColor whiteColor];
		topLabel.textAlignment = NSTextAlignmentCenter;
		[self.view addSubview:topLabel];
		
		UILabel *bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _cropperView.bottomView.frame.origin.y + 20, kScreenWidth, 20)];
		bottomLabel.text = @"请将身份证边缘贴合裁剪框边缘进行裁剪";
		bottomLabel.font = [UIFont systemFontOfSize:13];
		bottomLabel.textColor = [UIColor whiteColor];
		bottomLabel.textAlignment = NSTextAlignmentCenter;
		[self.view addSubview:bottomLabel];
		
		//旋转按钮
		UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];//button的类型
		button.frame = CGRectMake(0, kScreenHeight - 60, 60, 40);//button的frame
		button.center = CGPointMake(self.view.center.x,self.view.center.y);
		button.frame = CGRectMake(button.frame.origin.x, kScreenHeight - 60, 60, 40);//button的frame
		button.backgroundColor = [UIColor clearColor];
		[button setImage:[UIImage imageNamed:@"icon_image_tailoring"] forState:UIControlStateNormal];
		button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
		button.contentVerticalAlignment = UIControlContentHorizontalAlignmentLeft;
		[button addTarget:self action:@selector(rotateCropViewClockwise:) forControlEvents:UIControlEventTouchUpInside];
		[self.view addSubview:button];
		
		UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];//button的类型
		cancel.frame = CGRectMake(0, kScreenHeight - 60, 60, 40);//button的frame
		cancel.backgroundColor = [UIColor clearColor];
		[cancel setTitle:@"取消" forState:UIControlStateNormal];
		cancel.titleLabel.font = [UIFont systemFontOfSize:16];
		cancel.titleLabel.textAlignment = NSTextAlignmentCenter;
		[cancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		[cancel addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
		[self.view addSubview:cancel];
		
		UIButton *confirm = [UIButton buttonWithType:UIButtonTypeCustom];//button的类型
		confirm.frame = CGRectMake(kScreenWidth - 60, kScreenHeight - 60, 60, 40);//button的frame
		confirm.backgroundColor = [UIColor clearColor];
		[confirm setTitle:@"确定" forState:UIControlStateNormal];
		confirm.titleLabel.font = [UIFont systemFontOfSize:16];
		confirm.titleLabel.textAlignment = NSTextAlignmentCenter;
		[confirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		[confirm addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];
		[self.view addSubview:confirm];
	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	self.view.backgroundColor = [UIColor blackColor];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self.navigationController setNavigationBarHidden:YES animated:YES];
}

#pragma mark - Action
//取消
- (void)cancel:(UIButton *)sender {
	if (_delegate && [_delegate respondsToSelector:@selector(pictureTailoringViewControllerDidCancel:)]) {
		[_delegate pictureTailoringViewControllerDidCancel:self];
	}
}

//确定
- (void)confirm:(UIButton *)sender {
	if (_delegate && [_delegate respondsToSelector:@selector(pictureTailoringViewController:finishedEidtImage:)]) {
		[_delegate pictureTailoringViewController:self finishedEidtImage:[_cropperView getCroppedImage]];
	}
}

//旋转
- (void)rotateCropViewClockwise:(id)senders {
	[_cropperView actionRotate];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
	[super didReceiveMemoryWarning];
	// Release any cached data, images, etc that aren't in use.
}


@end
