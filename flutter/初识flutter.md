## flutter是什么

flutter is an app SDK for building high-performence,high-fidelity apps for iOS,Android,web,and deskTop from a single codebase.

##### 总结

flutter是一个UI SDK。

可以进行移动端：iOS、android，web端，桌面应用开发的跨平台解决方案。

移动端已经有很多公司在用，google、阿里、腾讯。

特别是咸鱼团队，为flutter做了很多贡献。

## flutter开发的特点

美观、快速、高效、开放

##### 美观

内置material Design和Cupertino widget，丰富的motion API，平滑自然的滑动效果和平台感知，为您用户带来新体验。

##### 快速

渲染性能好，渲染引擎使用C++编写，包括高效的Skia 2D渲染引擎，dart运行时和文本渲染库。

在生产环境，编译成机器码执行，充分利用了GPU的加速能力，因此在低配手机上也能实现每秒60帧的UI渲染效率。

##### 高效

hot reload，开发调试更快

##### 开放

开源项目

## why flutter

### 跨平台历史

#### 平台独立开发

成本高，俩端都需要独立开发人员

有时UI和业务实现细节难以统一

#### 跨平台方案1：webView 

![截屏2022-01-04 下午3.28.12](https://tva1.sinaimg.cn/large/008i3skNly1gy1rai7d40j30xi0rcdjc.jpg)

需要桥接调用原生服务

体验、性能不太理想、开发中坑比较多

#### 跨平台方案2：react-native

![截屏2022-01-04 下午3.29.52](https://tva1.sinaimg.cn/large/008i3skNly1gy1ran4fdbj30wq0mumzm.jpg)

由facebook推出，支持iOS和Android俩个平台。

rn使用js语言，类似于html的jsx以及css来开发移动应用。

在保留基础渲染能力的基础上使用原生UI组件实现核心渲染，从而保证良好的渲染性能。

本质上是通过JS VM调用原生接口，通讯效率比较低，而且框架本身不负责渲染，而是间接调用原生来渲染。

#### 跨平台解决方案3：Flutter

![截屏2022-01-04 下午3.38.00](https://tva1.sinaimg.cn/large/008i3skNly1gy1rar69tbj31780gaabg.jpg)

直接调用底层Skia渲染引擎，多端一致的API，，以及高效的渲染效率。

## flutter绘制原理

![截屏2022-01-04 下午3.40.13](https://tva1.sinaimg.cn/large/008i3skNly1gy1rauots9j30wk0pq759.jpg)

1.GPU将信号同步到UI线程。

2.UI线程用dart来构建图层树。

3.图层树在GPU线程中进行合成。

4.合成后的视图数据提交给Skia引擎。

5.Skia引擎通过openGL或者Vulkan将最终显示内容提交给buffer。

## 图像显示原理

#### 帧率和刷屏率

#### 双缓冲机制和vsync信号

一个back buffer和一个frame buffer

主要解决画面割裂问题，由vsync信号去触发一帧画面的渲染

存在一个vsync信号周期内，渲染未完成，掉帧的问题。

#### 三缓冲机制：部分安卓机

#### ![截屏2022-01-04 下午4.24.56](https://tva1.sinaimg.cn/large/008i3skNly1gy1rb13vpcj30sm0u241k.jpg)

俩个back buffer和一个frame buffer。

一个vsync信号，可以缓冲下俩帧数据，一定程度上解决卡顿问题。

本质上就是多了一个buffer作为备用。

## 渲染引擎skia

![截屏2022-01-04 下午4.33.17](https://tva1.sinaimg.cn/large/008i3skNly1gy1rb50n35j30nq0lq40t.jpg)

skia是flutter向GPU提供数据的途径。

skia是C++编写的开源图形库。能在低端设备手机上呈现高质量的2d图形。最初由skia公司开发，最后被google收购。

应用于Android、google chrome、chrome OS等等当中。

skia是android的官方图像渲染引擎。因此flutter Android SDK无需内嵌Skia引擎就可以获得天然的Skia支持。

而对于iOS来说，需要嵌入到flutter iOS SDK中，替代了iOS闭源的Core Graphics、Core Animation、Core Text，这也正是iOS SDK打包体积比android端大的原因。

底层渲染能力统一了，上层API和功能体验也就统一了。开发者再也不用担心平台相关的渲染特性。Skia保证了在android端和iOS端渲染效果的一致性。