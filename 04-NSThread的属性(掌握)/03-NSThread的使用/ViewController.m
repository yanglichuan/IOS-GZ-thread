//
//  ViewController.m
//  03-NSThread的使用
//
//  Created by apple on 15-1-13.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    [self test4];
    
}

// 耗时操作
- (void)run:(NSString *)str
{
    for (int i = 0; i < 10; i++) {
        NSLog(@"%@--%d", [NSThread currentThread], i);
    }
}

#pragma mark - 线程的属性
- (void)test4
{
    NSThread *threadA = [[NSThread alloc] initWithTarget:self selector:@selector(run:) object:@"hello"];
    
    threadA.name = @"thraed A";
    
    // 线程优先级
    // 是一个浮点数，0.0～1.0。 默认值 0.5
    // 开发的时候，一般不去修改优先级的值。
    // 优先级，必须调用很多次的时候，才能体现出来。
    threadA.threadPriority = 0.1;
    
    // 开始工作
    [threadA start];
    
    
    NSThread *threadB = [[NSThread alloc] initWithTarget:self selector:@selector(run:) object:@"hello"];
    
    threadB.name = @"thraed B";
    
    // 线程优先级
    // 是一个浮点数，0.0～1.0。 默认值 0.5
    threadB.threadPriority = 1.0;
    
    // 开始工作
    [threadB start];
}

#pragma mark  - 线程的创建方式
// 创建线程方式3
- (void)test3
{
    // “隐式”创建线程方式
    [self performSelectorInBackground:@selector(run:) withObject:@"cz"];
}

// 创建线程方式2
- (void)test2
{
    NSLog(@"---%@", [NSThread currentThread]);
    [NSThread detachNewThreadSelector:@selector(run:) toTarget:self withObject:@"hello"];
    
    NSLog(@"test2 --- %@", [NSThread currentThread]);

}

// 创建线程方式1
- (void)test1
{
    // 实例化一个线程对像
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
    
    // 让线程开始工作，启动线程, 在新开的线程执行run方法
    [thread start];
    
}

@end
