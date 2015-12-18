//
//  ViewController.m
//  01-耗时操作
//
//  Created by apple on 15-1-13.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // [NSThread currentThread] 获得当前线程，在开发中经常打印。 所有多线程技术都能使用这个方法
    // number == 1 主线程
    // number != 1 其他线程，子线程, 次线程
    NSLog(@"%s -- %@",__func__, [NSThread currentThread]);
    
//    [self longTimeOperation];
    // 将耗时的操作放到子线程执行
    // 会开辟一个子线程，并且在子线程执行longTimeOperation方法，后面传递参数
    [self performSelectorInBackground:@selector(longTimeOperation) withObject:nil];
    
    [self performsel]
    
    NSLog(@"%@",[NSThread currentThread]);
}

#pragma mark - 耗时操作
- (void)longTimeOperation
{
    for (int i = 0; i < 20000; i++) {
        NSLog(@"%d %@", i, [NSThread currentThread]);
    }
}

@end
