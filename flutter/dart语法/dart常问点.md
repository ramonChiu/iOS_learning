1. dart中 ".."表示什么？
   
   表示“级联操作符”。

   “..”和“.”不同的是调用".."返回的是this，更便捷的iOS的点语法，链式调用。

   “.”返回的是该方法返回值。如果要链式，需要修改方法的返回值为this。

2. dart的作用域？
   
   没有public和private关键字，默认是public。

   私有变量或者方法_下划线开头。

3. dart 是不是单线程模型？是如何运行的？
   ```plantuml
   @startuml
   "start app" --> "Execute main()"
   --> "Microtask queue empty?" as A 
   -->[NO] "Run Next microtask"
   -->[Done] A
   --> [YES] "Event queue empty?" as B
   B-->[YES] "APP can exit"
   B-->[NO] "Handle next event" as C
   C-->[Done] A  
   @enduml
   ```
+ 简单来说，dart单线程中是以事件循环机制来运行的，包含了俩个队列，一个是"微任务队列" Microtask queue,另一个叫做“事件队列” Event queue。
Microtask queue 比 Event queue有更高的优先级。
微任务执行完后才会执行Event，event任务执行完毕会再去判断执行微任务。如此循环往复。
Future.then(),.then函数就是向微任务队列加入了一个微任务，保证.then被立即执行。

+ 得益于异步IO+事件循环，尽管Dart是单线程，一般的IO密集型App应用通常也能获得出色的性能表现。IO事件丢给系统执行，等待系统回调。

+ 但对于一些计算量巨大的场景，比如图片处理、反序列化、文件压缩这些计算密集型操作，只单靠一个线程就不够用了。

