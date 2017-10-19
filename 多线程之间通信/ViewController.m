//
//  ViewController.m
//  多线程之间通信
//
//  Created by YiGuo on 2017/10/19.
//  Copyright © 2017年 tbb. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self downloadWithTime];
    
//    [NSThread detachNewThreadSelector:@selector(downLoad) toTarget:self withObject:@"tbb"];
    
    [self performSelectorInBackground:@selector(downLoad) withObject:@"tbb"];
}

-(void)downLoad{
    // 图片的网络路径
    NSURL *url = [NSURL URLWithString:@"https://car3.autoimg.cn/cardfs/product/g4/M06/88/CC/1024x0_1_q87_autohomecar__wKgH2lYChi6ATzdCAAe3AiAaA8s976.jpg"];
    //下载图片
    NSData *data = [NSData dataWithContentsOfURL:url];
    //生成图片
    UIImage *image = [UIImage imageWithData:data];
    //回调到主线程,更新图片
    //如果waitUntilDone:YES 则程序要更新完图片才往下执行
//    [self.imageView performSelector:@selector(setImage:) onThread:[NSThread mainThread] withObject:image waitUntilDone:NO];
    
//        [self.imageView performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:NO];
    
        [self performSelectorOnMainThread:@selector(showImage:) withObject:image waitUntilDone:YES];
    
}
- (void)showImage:(UIImage *)image
{
    self.imageView.image = image;
}
//检测下载图片所要的时间
-(void)downloadWithTime{
    // 图片的网络路径
    NSURL *url = [NSURL URLWithString:@"https://car3.autoimg.cn/cardfs/product/g4/M06/88/CC/1024x0_1_q87_autohomecar__wKgH2lYChi6ATzdCAAe3AiAaA8s976.jpg"];
    //1.
//    NSDate *begin = [NSDate date];
    //2.
    CFTimeInterval begin = CFAbsoluteTimeGetCurrent();
    // 根据图片的网络路径去下载图片数据
    NSData *data = [NSData dataWithContentsOfURL:url];
    //1.
//    NSDate *end = [NSDate date];
    //2.
        CFTimeInterval end = CFAbsoluteTimeGetCurrent();
//    NSLog(@"%f", [end timeIntervalSinceDate:begin]);
    NSLog(@"%f", end - begin);
    /**
     没得时间大概0.12秒如果在主线程执行有可以造成主线程阻塞
     */
    // 显示图片
    self.imageView.image = [UIImage imageWithData:data];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
