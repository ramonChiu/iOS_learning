##### 1.原生iOS项目debug运行起来，加载Flutter引擎唤起flutter页面

##### 2.使用AS打开flutter项目，flutter attach功能连接原生项目中的dart的虚拟机

这时候会有一直connecting的问题，这是iOS14之后的权限问题。应该在info.plist文件中声明

​	**<key>**NSBonjourServices**</key>**

​	**<array>**

​		**<string>**_dartobservatory._tcp**</string>**

​	</array>

​	**<key>**NSLocalNetworkUsageDescription**</key>**

​	**<string>**$(PRODUCT_NAME) App needs Local Network permission to find local devices.**</string>**

该权限会影响上审核上架，应该只用于debug环境，所以配置最好的方案是配置俩个info-Debug.plist 和 info-Release.plist俩个文件，分别在debug和release模式下使用不同的plist文件。

##### 3.attach成功使用，在命令行使用r触发热更新会报Unimplemented handling of missing static target的错误。

经过一番试验之后，没有使用命令行命令flutter attach

而是直接使用AS的工具窗口功能键attach，解决了这个问题

![image-20220207150233950](https://tva1.sinaimg.cn/large/008i3skNly1gz4ykmytnjj30vw090dgn.jpg)

##### 4.最终，嵌入到原生的flutter module也可以跟flutter工程关联，愉快的开发调试了。