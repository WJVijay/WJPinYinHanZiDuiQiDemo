//
//  ViewController.m
//  WJPinYinHanZiDuiQiDemo
//
//  Created by Yuan Wang on 2018/4/25.
//  Copyright © 2018年 Yuan Wang. All rights reserved.
//

#import "ViewController.h"
#import "WJPinYinWord.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WJPinYinWord *view = [[WJPinYinWord alloc]initWithStrings:@"我的大中国啊"];
    view.center = self.view.center;
    [self.view addSubview:view];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
