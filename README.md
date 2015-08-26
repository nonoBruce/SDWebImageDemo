# SDWebImageDemo
SDWebImage简单使用测试
###添加CocoaPods
这次第一次使用CocoaPods
安装CocoaPods且不记录了

>- 创建 Podfile
>- 通过pod search SDWebImage获取该库的版本

在Podfile添加如下文字
```
platform :ios, '7.0'
pod 'SDWebImage', '~> 3.7.3'
```

切换到工程目录下在终端中输入
```
$ pod install 
//如果卡在Analyzing dependencies可以尝试下面的命令
//或者
pod install --verbose --no-repo-update 
//或者
pod update --verbose --no-repo-update 
```
这个工程就增加了CocoaPods了


进入工程目录打开：SDWebImageDemo.xcworkspace

###SDWebImage使用
SDWebImage使用如下
```
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

```


###添加iOS9不支持http的解决方案

>在Info.plist中添加NSAppTransportSecurity类型Dictionary。
在NSAppTransportSecurity下添加NSAllowsArbitraryLoads类型Boolean,值设为YES

如下图：
![Alt text](./屏幕快照 2015-08-26 下午9.41.02.png)
