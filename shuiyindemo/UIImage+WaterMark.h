//
//  UIImage+WaterMark.h
//  shuiyindemo
//
//  Created by zhqh on 2024/12/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (WaterMark)

/// 图片添加斜向铺满水印
/// - Parameters:
///   - markStr: 水印文字
///   - size: 最终需要生成的图片尺寸
- (UIImage *)addWaterMark:(NSString *)markStr size:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
