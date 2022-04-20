##### 1.切换版本

fvm use version 切换本地flutter版本

##### 2.as更新版本，命令行输入一下命令

flutter pub get 更新项目中flutter插件

flutter packages upgrade 

##### 3.修改AD依赖的flutter本地路径

在AS的preference里面设置flutter的路径，解决冲突。

![截屏2022-01-06 下午5.01.31](https://tva1.sinaimg.cn/large/008i3skNly1gy42ede3kaj31520u0aeb.jpg)

##### 5.iOS项目跑起来遇到问题 

缺少Generated.xconfig文件，缺少FlutterPluginRegistrant

作为Flutter app，这俩个文件正常应该在iOS文件夹下。

从.iOS文件夹，复制过去解决。

.ios文件夹是作为flutter module的壳工程，是一个隐藏文件夹，建议是不进行修改和版本控制的。因为我们的flutter项目即是native主工程的module，平常也作为一个单独工程独立开发，所以使用 flutter create -i objc .  创建了ios文件夹，作为我们平常调试的独立工程文件。

正常情况下：

flutter app 有ios文件，没有.ios文件。

flutter module 有.ios文件，没有ios文件。

在.ios文件存在的时候，用flutter create -i objc . 创建的ios文件，比正常情况会有文件缺失。

缺失文件如下：

Generated.xcconfig 

Flutter/flutter_export_environment.sh

Flutter/Runnner/GeneratedPluginRegistrant.h

Runnner/GeneratedPluginRegistrant.m



![image-20220106170746637](https://tva1.sinaimg.cn/large/008i3skNly1gy42e4vvq6j30tc0iomyt.jpg)

![image-20220106170852142](https://tva1.sinaimg.cn/large/008i3skNly1gy42e90wbdj30m80bo751.jpg)

#### 6.跑真机报 无法验证 iproxy

指令：sudo xattr -d com.apple.quarantine /Users/didi/.fvm/versions/2.5.0/bin/cache/artifacts/usbmuxd/iproxy

#### 7.row包row包expand

报错，无法确定row的size

修改为row包expand包row包expand解决问题

#### 8.setState时机问题

在initStat中，网络请求返回较快或者使用缓存，刷新页面时，页面还没有渲染出来，调用setState崩溃。

解决方案

1.在addPostFrameCallback渲染第一帧数据完毕的回调里进行网络请求。

2.判断inMouted状态之后，再进行setState。

##### 9.http的加载问题

info.plist添加如下代码

```xml
	<key>NSAppTransportSecurity</key>
	<dict>
		<key>NSAllowsArbitraryLoads</key>
		<true/>
	</dict>
```

##### 10.ios工程编译报错：The sandbox is not in sync with the Podfile.lock. Run 'pod install' or update your CocoaPods installation.

修改project的info的Configrations如下，默认是none，所以报错。

[参考连接](https://blog.csdn.net/grl18840839630/article/details/86223769)

###### ![(image-20220208111906912)](https://tva1.sinaimg.cn/large/008i3skNly1gz5xqio5nuj31380j0acm.jpg)



##### 11.iOS混编项目调试&hot-reload

使用下面命令

```
flutter attach
```

##### 12.dialog 无法移除问题

```
https://stackoverflow.com/questions/50683524/how-to-dismiss-flutter-dialog

Navigator.of(context, rootNavigator: true).pop();
The dialog route created by this method is pushed to the root navigator. If the application has multiple Navigator objects, it may be necessary to call Navigator.of(context, rootNavigator: true).pop(result) to close the dialog rather just Navigator.pop(context, result).
```

