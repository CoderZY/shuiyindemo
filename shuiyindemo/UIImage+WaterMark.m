//
//  UIImage+WaterMark.m
//  shuiyindemo
//
//  Created by zhqh on 2024/12/27.
//

#import "UIImage+WaterMark.h"
#import <Photos/Photos.h>

@implementation UIImage (WaterMark)

//
- (UIImage *)addWaterMark:(NSString *)markStr size:(CGSize)size {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    view.backgroundColor = UIColor.whiteColor;
    view.clipsToBounds = YES;
    
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:view.bounds];
    imgV.contentMode = UIViewContentModeScaleAspectFit;
    imgV.image = self;
    [view addSubview:imgV];
    
    
    // 获取需要旋转的view
    UIView *waterTextView = [[UIView alloc] initWithFrame:CGRectMake(-100, -100, size.width + 200, size.height + 200)];
    waterTextView.backgroundColor = [UIColor colorWithPatternImage:[self textToImg:markStr]];
     
    // 创建一个新的变换矩阵
    CATransform3D transform = CATransform3DIdentity;
     
    // 设置旋转角度（逆时针旋转45度）
    // 注意：这里的角度是弧度，不是度数。180度 = M_PI半径的弧度
    transform = CATransform3DRotate(transform, -M_PI_4, 0.0, 0.0, 1.0);
     
    // 应用变换矩阵到view上
    waterTextView.layer.transform = transform;
     
    // 如果你想要动画进行这个旋转，可以使用下面的代码
//    [UIView animateWithDuration:1.0 animations:^{
//        myView.layer.transform = transform;
//    }];
    
    [view addSubview:waterTextView];
    
    UIImage *wateredImg = [self snapshot:view];
    return wateredImg;
    
}

- (void)saveToPhoto:(UIImage *)saveImg {
    
     
    // 请求授权访问相册
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus accessStatus) {
        if (accessStatus == PHAuthorizationStatusAuthorized) {
            // 授权成功，保存图片到相册
            [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                PHAssetChangeRequest *changeRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:saveImg];
            } completionHandler:^(BOOL success, NSError *error) {
                if (success) {
                    // 图片成功保存到相册
                    NSLog(@"图片已保存到相册");
                } else {
                    // 保存失败，处理错误
                    NSLog(@"保存失败: %@", error);
                }
            }];
        } else {
            // 用户拒绝授权，处理相册访问被拒绝的情况
            NSLog(@"相册访问被拒绝");
        }
    }];
}



- (UIImage *)textToImg:(NSString *)text {
    UIFont *font = [UIFont systemFontOfSize:15];
    
    CGSize testSize = [text sizeWithFont:font];
    
    // 设置文字颜色和背景颜色
    [UIColor.whiteColor set];
    
    // 开始图片上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(testSize.width + 20, testSize.height + 20), NO, 0.0);
    
    // 绘制文字
    [text drawAtPoint:CGPointMake(0, 0) withAttributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName:UIColor.lightGrayColor}];
    
    // 从图片上下文获取图片
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 结束图片上下文
    UIGraphicsEndImageContext();
    
    return image;
}



- (UIImage *)snapshot:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0.0);
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}




@end
