#### 1.把整个Flutter工程打包成一个Flutter Module。

主要在pubSpec.yaml最后一段：

```
# This section identifies your Flutter project as a module meant for# embedding in a native host app.  These identifiers should _not_ ordinarily# be changed after generation - they are used to ensure that the tooling can# maintain consistency when adding or modifying assets and plugins.# They also do not have any bearing on your native host application's# identifiers, which may be completely independent or the same as these.module:androidX: trueandroidPackage: com.example.flutter_test_moduleiosBundleIdentifier: com.example.flutterTestModule

————————————————
版权声明：本文为CSDN博主「虎哥说衣不二」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/weixin_33283907/article/details/112449193
```



