##### 1.Building for , but the linked and embedded framework was built for iOS + iOS Simulator

XCode12.3之后，支持多平台的包，强制使用xcframework后缀包，否则error以前只会warning。

解决方法1:

![img](https://img-blog.csdnimg.cn/2020122316285016.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzQzMzc3NzQ5,size_16,color_FFFFFF,t_70)

解决方法2:

使用legacy，老版本的编译器

解决方法3：

重新打包成.xcframework包，苹果官方推荐

##### 2.Multiple commands produce

![截屏2022-02-16 下午2.51.41的副本2](/Users/didi/Desktop/截屏2022-02-16 下午2.51.41的副本2.png)

[参考连接](https://www.jianshu.com/p/1e46bf6c48eb)

实际解决：

他喵的copy Bunlde Resources里确实有俩个重复的.gitkeep选项，删除一个后解决。![截屏2022-02-16 下午4.25.02](/Users/didi/Library/Application Support/typora-user-images/截屏2022-02-16 下午4.25.02.png)

##### 3.Pod依赖库down的替代方案

修改podfile为本地指向，避免从远端更新（当然前提是你本地有一份）。

![截屏2022-02-16 下午4.35.22](/Users/didi/Library/Application Support/typora-user-images/截屏2022-02-16 下午4.35.22.png)

对应的path下，需要有.podspec或者.podspec.json文件，从.cocopods的specs中拷贝过来即可。![截屏2022-02-16 下午4.36.50](/Users/didi/Library/Application Support/typora-user-images/截屏2022-02-16 下午4.36.50.png)