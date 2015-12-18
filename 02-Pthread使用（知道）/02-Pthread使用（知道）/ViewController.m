//
//  ViewController.m
//  02-Pthread使用（知道）
//
//  Created by apple on 15-1-13.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ViewController.h"
#import <pthread.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    [self test];
}

// 函数
void *run(void *param)
{
    NSString *str = (__bridge NSString *)(param);
    
    // 耗时操作放在这里执行
    for (int i = 0; i < 20000; i++) {
        NSLog(@"%@----%@", [NSThread currentThread], str);
    }
    
    return NULL;
}

// iOS开发，一般C语言的框架.h文件没有注释
// http://baike.baidu.com

// 使用pthread创建线程
- (void)test
{
    // 声明一个线程变量
    pthread_t threadId;
    /*
     参数：
     1. 要开的线程的变量
     2. 线程的属性
     3. 要在这个子线程执行的函数(任务)
     4. 这个函数（任务）需要传递的参数
     */
    
//    pthread_create(,, , <#void *restrict#>)
    
    id str = @"hello";
    
    
    // id需要转成void *，在ARC里，需要使用__bridge 进行桥联
    // 1. 这里只是临时把str对象专程void *在这里临时使用。 不改变这个对象（str）的所有权。
    // 2. 把对象的所有权交出去，在这个函数把str转成void *
    // 如果使用MRC，这里不需要桥联，可以直接设置这个参数
    // ARC自动内存管理，本质是编译器特性。是在程序编译的时候，编译器帮我们在合适的地方添加retain，release，autorelease。
    pthread_create(&threadId, NULL, run, (__bridge void *)(str));
}



@end
