//
//  WJPinYinWord.m
//  Demo666
//
//  Created by Yuan Wang on 2018/4/25.
//  Copyright © 2018年 Yuan Wang. All rights reserved.
//

#import "WJPinYinWord.h"
#import "M80AttributedLabel.h"

@interface WJPinYinWord()

@property ( strong, nonatomic) NSMutableArray                      *wordsArray;

@property ( strong, nonatomic) NSMutableArray                      *pinyinArray;

@property ( strong, nonatomic) NSMutableArray                      *labelArray;

@property ( strong, nonatomic) M80AttributedLabel                  *preLabel;

@property ( strong, nonatomic) M80AttributedLabel                  *wpreLabel;

@property ( strong, nonatomic) UIView                              *bgView;

@end

@implementation WJPinYinWord

-(instancetype)initWithStrings:(NSString *)strings{
    
    if (self = [super init]) {
        
        NSString *words = strings;//@"我们的大中华啊";
        for (int i = 0; i <words.length; i++) {
            
            NSString *word = [words substringWithRange:NSMakeRange(i, 1)];
            [self.wordsArray addObject:word];
            NSString *pinyin = [self chChangePin:word];
            [self.pinyinArray addObject:pinyin];
        }
        
        self.bgView = [[UIView alloc]init];
        [self addSubview:self.bgView];
        
        for (int i = 0; i < self.pinyinArray.count ; i++) {
            
            //拼音
            NSString *pinyin = self.pinyinArray[i];
            M80AttributedLabel *label = [self getDrawViewWithString:pinyin];
            CGFloat LabelX = 0.0;
            if (self.preLabel) {
                LabelX = CGRectGetMaxX(self.preLabel.frame);
            }
            CGSize size = [pinyin boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
            label.frame     = CGRectMake(LabelX+10, 0, size.width+4, 30);
            self.preLabel = label;
            
            //汉字
            NSString *word = self.wordsArray[i];
            M80AttributedLabel *wlabel = [self getDrawViewWithString:word];
            CGFloat wLabelX = 0.0;
            if (self.wpreLabel) {
                wLabelX = CGRectGetMaxX(self.preLabel.frame);
            }
            CGSize wSize = [word boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
            wlabel.bounds = CGRectMake(0, 0, wSize.width, 30);
            wlabel.center = CGPointMake(label.center.x, CGRectGetMaxY(label.frame)+15);
            self.wpreLabel = wlabel;
            
            //添加
            [self.bgView addSubview:label];
            [self.bgView addSubview:wlabel];
            self.bgView.frame = CGRectMake(0,0,CGRectGetMaxX(self.preLabel.frame)+10 , 30+40);
            self.bounds = self.bgView.bounds;
        }
        
    }
    return self;
}

- (M80AttributedLabel *)getDrawViewWithString:(NSString *)words{
    
    M80AttributedLabel *label = [[M80AttributedLabel alloc]initWithFrame:CGRectZero];
    NSString *plainText = words;
    NSArray *components = [plainText componentsSeparatedByString:@""];
    for (NSString *text in components)
    {
        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]initWithString:text];
        [attributedText m80_setFont:[UIFont systemFontOfSize:17]];
        [attributedText m80_setTextColor:[UIColor redColor]];
        
        
        [label appendAttributedText:attributedText];
        [label appendText:@" "];
    }
    
    return label;
}


- (NSMutableArray *)wordsArray{
    if (_wordsArray == nil) {
        _wordsArray = [NSMutableArray array];
    }
    return _wordsArray;
}

- (NSMutableArray *)pinyinArray{
    if (_pinyinArray == nil) {
        _pinyinArray = [NSMutableArray array];
    }
    return _pinyinArray;
}
- (NSMutableArray *)labelArray{
    
    if (_labelArray == nil) {
        
        _labelArray  = [NSMutableArray array];
    }
    return _labelArray;
}

-(NSString *)chChangePin:(NSString *)originStr{
    //  把汉字转换成拼音第一种方法
    NSString *str = [[NSString alloc]initWithFormat:@"%@", originStr];
    // NSString 转换成 CFStringRef 型
    CFStringRef string1 = (CFStringRef)CFBridgingRetain(str);
    //    NSLog(@"%@", str);
    //  汉字转换成拼音
    CFMutableStringRef string = CFStringCreateMutableCopy(NULL, 0, string1);
    //  拼音（带声调的）
    CFStringTransform(string, NULL, kCFStringTransformMandarinLatin, NO);
    NSLog(@"%@", string);
    //  去掉声调符号
    //    CFStringTransform(string, NULL, kCFStringTransformStripDiacritics, NO);
    //    NSLog(@"%@", string);
    //    //  CFStringRef 转换成 NSString
    //    NSString *strings = (NSString *)CFBridgingRelease(string);
    //    //  去掉空格
    //    NSString *cityString = [strings stringByReplacingOccurrencesOfString:@" " withString:@""];
    //    NSLog(@"%@", cityString);
    
    
    return (__bridge NSString *)(string);
}



@end
