//
//  ViewController.m
//  ONTailoringPicture
//
//  Created by onion on 2019/3/7.
//  Copyright © 2019 onion. All rights reserved.
//

#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

#define kIsiPhoneX \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})
#define kTitleViewHeight (kIsiPhoneX ? 88 : 64)
#define kStatusHeight (kIsiPhoneX ? 44 : 20)

#import "ViewController.h"
#import "ONImagePickerController.h"

@interface ViewController ()

@property (nonatomic,strong) UIImageView *imageView;

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kTitleViewHeight)];
	navView.backgroundColor = [UIColor colorWithRed:191/255.0 green:190/255.0 blue:191/255.0 alpha:1.0f];
	[self.view addSubview:navView];
	
	UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, kStatusHeight, kScreenWidth, 44)];
	titleLable.font = [UIFont systemFontOfSize:18];
	titleLable.textAlignment = NSTextAlignmentCenter;
	titleLable.textColor = [UIColor blackColor];
	titleLable.text = @"选择图片";
	[navView addSubview:titleLable];
	
	//裁剪完成图片显示
	_imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, (kScreenHeight - kScreenWidth/1.6)/2, kScreenWidth, kScreenWidth/1.6)];
	_imageView.layer.borderWidth = 1;
	_imageView.layer.borderColor = [UIColor redColor].CGColor;
	_imageView.userInteractionEnabled  = YES;
	[self.view addSubview:_imageView];
	[_imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)]];
}

- (void)tapAction {
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"请选择照片" preferredStyle:UIAlertControllerStyleActionSheet];
	UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
	UIAlertAction *camera = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){

		//判断是否有相机
		if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
			[self showImagePicker:UIImagePickerControllerSourceTypeCamera];
		} else {
			NSLog(@"该设备无摄像头");
			UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"该设备无摄像头~" preferredStyle:UIAlertControllerStyleAlert];
			UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil];
			[alertController addAction:cancel];
			[self presentViewController:alertController animated:YES completion:nil];
		}
	}];
	UIAlertAction *photoLibrary = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
		[self showImagePicker:UIImagePickerControllerSourceTypePhotoLibrary];
	}];
	[alertController addAction:cancel];
	[alertController addAction:camera];
	[alertController addAction:photoLibrary];
	[self presentViewController:alertController animated:YES completion:nil];
}

- (void)showImagePicker:(UIImagePickerControllerSourceType)sourcetype {
	ONImagePickerController *imagePicker = [ONImagePickerController sharedInstance];
	[imagePicker showImagePickerWithPresentController:self sourceType:sourcetype allowEdit:YES cutFrame:CGRectMake(0, (kScreenHeight - kScreenWidth/1.6)/2, kScreenWidth, kScreenWidth/1.6)];
	[imagePicker setChooseImageBlock:^(UIImage * _Nonnull image) {
		NSLog(@"--image--%@",image);
		self.imageView.image = image;
	}];
}

@end
