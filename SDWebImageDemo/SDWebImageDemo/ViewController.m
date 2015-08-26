//
//  ViewController.m
//  SDWebImageDemo
//
//  Created by bruce on 15/8/26.
//  Copyright (c) 2015年 bruce. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    

    

}
- (IBAction)clear:(id)sender {
    [[SDImageCache sharedImageCache] clearDisk];
    
    [[SDImageCache sharedImageCache] clearMemory];
}
- (IBAction)loadImage:(id)sender {
    
    
    NSURL* imagePath1 = [NSURL URLWithString:@"http://e.hiphotos.baidu.com/image/w%3D310/sign=f1b3080be7dde711e7d245f797eecef4/838ba61ea8d3fd1f65e51a34324e251f94ca5fcb.jpg"];
    
    NSURL* imagePath2 = [NSURL URLWithString:@"http://cdn.cocimg.com/bbs/attachment/upload/73/1202731418914287.jpg"];
    
    //图片缓存的基本代码，就是这么简单
    [self.imageView sd_setImageWithURL:imagePath1];
    [self.button sd_setBackgroundImageWithURL:imagePath2 forState:UIControlStateNormal];
    
    
    //用block 可以在图片加载完成之后做些事情
    //    [self.imageView sd_setImageWithURL:imagePath2 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    //
    //        NSLog(@"这里可以在图片加载完成之后做些事情");
    //
    //    }];
    
    //覆盖方法，指哪打哪，这个方法是下载imagePath2的时候响应
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    
    [manager downloadImageWithURL:imagePath1 options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        NSLog(@"显示当前进度 = %f",receivedSize/(CGFloat)expectedSize);
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        
        NSLog(@"下载完成");
    }];
    
    //
    //    //给一张默认图片，先使用默认图片，当图片加载完成后再替换
    //    [self.image1 sd_setImageWithURL:imagePath1 placeholderImage:[UIImage imageNamed:@"default"]];
    //
    //    //使用默认图片，而且用block 在完成后做一些事情
    //    [self.image1 sd_setImageWithURL:imagePath1 placeholderImage:[UIImage imageNamed:@"default"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    //
    //        NSLog(@"图片加载完成后做的事情");
    //
    //    }];
    //
    //    //options 选择方式
    //
    //    [self.image1 sd_setImageWithURL:imagePath1 placeholderImage:[UIImage imageNamed:@"default"] options:SDWebImageRetryFailed];
    //    /*
    //     //失败后重试
    //     SDWebImageRetryFailed = 1 << 0,
    //
    //     //UI交互期间开始下载，导致延迟下载比如UIScrollView减速。
    //     SDWebImageLowPriority = 1 << 1,
    //
    //     //只进行内存缓存
    //     SDWebImageCacheMemoryOnly = 1 << 2,
    //
    //     //这个标志可以渐进式下载,显示的图像是逐步在下载
    //     SDWebImageProgressiveDownload = 1 << 3,
    //
    //     //刷新缓存
    //     SDWebImageRefreshCached = 1 << 4,
    //
    //     //后台下载
    //     SDWebImageContinueInBackground = 1 << 5,
    //
    //     //NSMutableURLRequest.HTTPShouldHandleCook®ies = YES;
    //
    //     SDWebImageHandleCookies = 1 << 6,
    //
    //     //允许使用无效的SSL证书
    //     //SDWebImageAllowInvalidSSLCertificates = 1 << 7,
    //
    //     //优先下载
    //     SDWebImageHighPriority = 1 << 8,
    //     
    //     //延迟占位符
    //     SDWebImageDelayPlaceholder = 1 << 9,
    //     
    //     //改变动画形象
    //     SDWebImageTransformAnimatedImage = 1 << 10,
    //     */
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
