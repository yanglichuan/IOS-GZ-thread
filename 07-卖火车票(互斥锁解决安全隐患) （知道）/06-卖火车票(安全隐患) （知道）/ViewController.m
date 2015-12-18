//
//  ViewController.m
//  06-卖火车票(安全隐患) （知道）
//
//  Created by apple on 15-1-13.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

/**
 总票数
 */
@property(nonatomic, assign) int tickets;

@end

@implementation ViewController

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    // 剩余20张票
    self.tickets = 20;
    
    // 主线程工作
//    [self saleTicktes];
    
    // 增加子线程，卖票
    NSThread *threadA = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicktes) object:nil];
    
    threadA.name = @"售票员A";
    
    [threadA start];
    
    NSThread *threadB = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicktes) object:nil];
    
    threadB.name = @"售票员B";
    
    [threadB start];
}

#pragma mark - 卖票
/**
 1. 开发比较复杂的多线程程序时，可以先在主线程把功能实现
 2. 实现功能以后，再把耗时的功能再放到子线程
 3. 再增加一个线程，建议开发的时候，线程一个一个增加
 */
/**
 加锁，互斥锁
 加锁，锁定的代码尽量少。
 加锁范围内的代码， 同一时间只允许一个线程执行
 互斥锁的参数:任何继承 NSObject *对象都可以。
 要保证这个锁，所有的线程都能访问到, 而且是所有线程访问的是同一个锁对象
 */
- (void)saleTicktes
{
    while (YES) {
        
        // 模拟一下延时，卖一张休息1秒
        [NSThread sleepForTimeInterval:1.0];

        NSObject *obj = [[NSObject alloc] init];
        
        // 不会写单词，怎么办？
//        [[NSUserDefaults standardUserDefaults] synchronize];

        // 为什么没有提示
        // 因为苹果不推荐我们使用加锁。因为加锁，性能太差。
        @synchronized(self){ // 开发的时候，一般就使用self就OK
            //1. 判断是否还有票，
            if (self.tickets > 0) {
                // 2. 如果有票，就卖一张
                self.tickets--;
                
                NSLog(@"剩余的票数--%d--%@", self.tickets, [NSThread currentThread]);

            }else{
                // 3. 如果没有就返回
                NSLog(@"没票了");
                break;
            }
        }
    }
    
}


@end
