//
//  UIFont+extension.h
//  tztMobileApp_HTSC
//
//  Created by mac on 16/5/24.
//
//

#import <UIKit/UIKit.h>

@interface UIFont (extension)
//匹配PingFang字体，在9以下的机器，自动转换成Helvetica字体
+ (UIFont *)extentsionFontWithName:(NSString *)fontName size:(CGFloat)fontSize;
@end
