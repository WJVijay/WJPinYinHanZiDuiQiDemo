//
//  WJPinYinWord.h
//  Demo666
//
//  Created by Yuan Wang on 2018/4/25.
//  Copyright © 2018年 Yuan Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJPinYinWord : UIView

/**
 实例化方法,需要设置center,内部设置好bounds了,宽度根据文字宽度自适应,只支持一行显示;

 @param strings 传入文字
 @return 布局好的view
 */
-(instancetype)initWithStrings:(NSString *)strings;

@end
