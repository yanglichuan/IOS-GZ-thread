//
//  ViewController.m
//  05-NSThread线程的状态(知道)
//
//  Created by apple on 15-1-13.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    [self test];
}

- (void)test
{
    // 1. 新建一个线程
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
    
    // 2. 放到可调度线程池，等待被调度。 这时候是就绪状态
    [thread start];
    
   
    
    
}

- (void)run
{
    NSLog(@"%s", __func__);
    
    // 刚进来就睡会， 睡2秒
//    [NSThread sleepForTimeInterval:5.0];
    
    // 睡到指定的时间点
//    [NSThread sleepUntilDate:[NSDate dateWithTimeIntervalSinceNow:5.0]];
    
    for (int i = 0; i < 20; i++) {
        
        // 满足某一个条件以后，阻塞线程的执行。 也就是让线程休息一会
        if (i == 10) {
            [NSThread sleepForTimeInterval:3.0];
        }
        
        // 一旦达到某一个条件，就强制终止线程的执行
        if (i == 15) {
            // 一旦强制终止，就在不能重新启动
            // 一旦强制终止，后面的代码都不会执行
            [NSThread exit];
        }
        
        NSLog(@"%@--- %d", [NSThread currentThread], i);
    }
    
    NSLog(@"线程结束");
}

@end
