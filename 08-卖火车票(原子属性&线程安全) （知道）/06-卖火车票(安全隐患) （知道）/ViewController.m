//
//  ViewController.m
//  06-卖火车票(安全隐患) （知道）
//
//  Created by apple on 15-1-13.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
/*
 线程安全的概念: 就是在多个线程同时执行的时候，能够保证资源信息的准确性.
 
 "UI线程" -- 主线程
 ** UIKit 中绝对部分的类，都不是”线程安全“的
 怎么解决这个线程不安全的问题？
 
 苹果约定，所有程序的更新UI都在主线程进行， 也就不会出现多个线程同时改变一个资源。
 
 // 在主线程更新UI，有什么好处？
 1. 只在主线程更新UI，就不会出现多个线程同时改变 同一个UI控件
 2. 主线程的优先级最高。也就意味UI的更新优先级高。 会让用户感觉很流畅
 */

/**
 总票数
 */
@property(nonatomic, assign) int tickets;

@property(atomic, strong)NSObject *obj;
// nonatomic 非原子属性
// atomic 原子属性--默认属性
// 原子属性就是针对多线程设计的。 原子属性实现 单(线程)写 多(线程)读
// 因为写的安全级别要求更高。 读的要求低一些，可以多读几次来保证数据的正确性
@end

@implementation ViewController
// 如果同时重写了setter和getter方法，"_成员变量" 就不会提供
// 可以使用 @synthesize 合成指令，告诉编译器属性的成员变量的名称
@synthesize obj = _obj;

- (NSObject *)obj
{
    return _obj;
}

// atomic情况下， 只要重写了set方法，getter也得重写
- (void)setObj:(NSObject *)obj
{
    // 原子属性内部使用的 自旋锁
    // 自旋锁和互斥锁
    // 共同点: 都可以锁定一段代码。 同一时间， 只有线程能够执行这段锁定的代码
    // 区别：互斥锁，在锁定的时候，其他线程会睡眠，等待条件满足，再唤醒
    // 自旋锁，在锁定的时候， 其他的线程会做死循环，一直等待这条件满足，一旦条件满足，立马去执行，少了一个唤醒过程
    
    @synchronized(self){ // 模拟锁。 真实情况下，使用的不是互斥锁。
        _obj = obj;
    }
}

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
