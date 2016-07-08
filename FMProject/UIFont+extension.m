//
//  UIFont+extension.m
//  tztMobileApp_HTSC
//
//  Created by mac on 16/5/24.
//
//

#import "UIFont+extension.h"

#define tztUIBaseViewTextFontWithName(name, fontsize) [UIFont fontWithName:name size:(fontsize > 0 ? fontsize : 10)]

@implementation UIFont (extension)

//匹配PingFang字体，在9以下的机器，自动转换成Helvetica字体
+ (UIFont *)extentsionFontWithName:(NSString *)fontName size:(CGFloat)fontSize{
    UIFont * font = [UIFont fontWithName:fontName size:fontSize];
    if (!font) {
        if (fontName) {
            if ([fontName hasSuffix:@"Regular"]) {
                font = tztUIBaseViewTextFontWithName(@"Helvetica-Bold",fontSize);
            }else if ([fontName hasSuffix:@"Light"]) {
                font = tztUIBaseViewTextFontWithName(@"Helvetica",fontSize);;
            }else{
                font = tztUIBaseViewTextFontWithName(@"Helvetica",fontSize);;
            }
        }
    }
    return font;
}
@end
