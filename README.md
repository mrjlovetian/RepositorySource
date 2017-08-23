# RepositorySource [关于pod资源访问问题]

[![CI Status](http://img.shields.io/travis/mrjlovetian@gmail.com/RepositorySource.svg?style=flat)](https://travis-ci.org/mrjlovetian@gmail.com/RepositorySource)
[![Version](https://img.shields.io/cocoapods/v/RepositorySource.svg?style=flat)](http://cocoapods.org/pods/RepositorySource)
[![License](https://img.shields.io/cocoapods/l/RepositorySource.svg?style=flat)](http://cocoapods.org/pods/RepositorySource)
[![Platform](https://img.shields.io/cocoapods/p/RepositorySource.svg?style=flat)](http://cocoapods.org/pods/RepositorySource)

## 简单的pod资源访问
在 CocoaPods 0.36 以前，pod 资源最后都会被直接拷贝到 client target 的 [NSBundle mainBundle] 里。你可以用访问 mainBundle 里资源的方式访问它们。比如用 + (UIImage *)imageNamed:(NSString *)name 来访问 pod 的图片。

但是在 CocoaPods 0.36 之后，这件事情发生了一些变化。由于 iOS 8 Dynamic Frameworks 特性的引入，CocoaPods 能帮你打包 framework 了（撒花）。0.36 版的 release note很详细地说明了加入 framework 特性所带来的变化。一个显著区别就是当你的 pod 库以 framework 形式被使用时，你的资源不是被拷贝到 mainBundle 下，而是被放到 pod 的最终产物—— framework 里。此时，你必须保证自己在访问这个 framework 的 bundle，而不是 client target 的。
<pre><code>
[NSBundle bundleForClass:<#ClassFromPodspec#>]
</pre></code>
上面这段代码可以返回某个 class 对应的 bundle 对象。具体的，

如果你的 pod 以 framework 形式被链接，那么返回这个 framework 的 bundle。
如果以静态库（.a）的形式被链接，那么返回 client target 的 bundle，即 mainBundle。
但无论以哪种形式链接，在这个方法返回的 bundle 下都有你的 pod 资源。接下来要做就是去访问他们。我写了个简单的 category1来获取 MyLibrary 的 bundle 对象。


## 资源引用差别
* s.resources方法
<pre><code>
s.resources = ['RepositorySource/Source/*']
</pre></code>
s.resources引用是将Source下的资源拷贝到ResponsitorySource.framework目录下
![如图](/resources.png)
工程中使用时 
<pre><code>
@implementation NSBundle (FindBundle)
+ (NSBundle *)getFrameWork
{
    return [NSBundle bundleWithURL:[self getFramerUrl]];
}

+ (NSURL *)getFramerUrl
{
    NSBundle *bundel = [NSBundle bundleForClass:[YHJView class]];
    return [bundel URLForResource:@"Source" withExtension:@"bundle"];
}
</pre></code>[bundel URLForResource:@"Source" withExtension:@"bundle"]这句代码是重点，getFrameWork 返回当前bundle。

<pre><code>
 UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    imageView.image = [[UIImage alloc] initWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"x" ofType:@"png"]];
//    imageView.image = [[UIImage alloc] initWithContentsOfFile:[[NSBundle getFrameWork] pathForResource:@"aa" ofType:@"png"]];
    imageView.backgroundColor = [UIColor whiteColor];
    [self addSubview:imageView];
</pre></code>
上述代码即可获得相关图片资源

* s.resource_bundles访问
<pre><code>
s.resource_bundles = {
   'RepositorySource' => ['RepositorySource/Source/*']
}
</pre></code>
s.resource_bundles引用是将Source下的资源拷贝到ResponsitorySource.framework目录下的RepositorySource.bundle目录下
![如图](/resource_bundles.png)
工程中使用
<pre><code>
@implementation NSBundle (FindBundle)
+ (NSBundle *)getFrameWork
{
    return [NSBundle bundleWithURL:[self getFramerUrl]];
}

+ (NSURL *)getFramerUrl
{
    NSBundle *bundel = [NSBundle bundleForClass:[YHJView class]];
    return [bundel URLForResource:@"RepositorySource" withExtension:@"bundle"];
}
</pre></code>[bundel URLForResource:@"RepositorySource" withExtension:@"bundle"]这句代码是重点，getFrameWork 返回当前bundle。但是还是没有拿到你需要的RepositorySource.bundle，因为还在下面一层。使用以下代码
<pre><code>
 NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle getFrameWork] pathForResource:@"Soruce" ofType:@"bundle"]];
    imageView.image = [[UIImage alloc] initWithContentsOfFile:[bundle pathForResource:@"aa" ofType:@"png"]];
//    imageView.image = [[UIImage alloc] initWithContentsOfFile:[[NSBundle getFrameWork] pathForResource:@"x" ofType:@"png"]];
</pre></code>
## Installation

RepositorySource is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "RepositorySource"
```

## Author

mrjlovetian@gmail.com, mrjyuhongjiang@gmail.com

## License

RepositorySource is available under the MIT license. See the LICENSE file for more info.


