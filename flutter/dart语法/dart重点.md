### 1. dart中 ".."表示什么？
   
   表示“级联操作符”。

   “..”和“.”不同的是调用".."返回的是this，更便捷的iOS的点语法，链式调用。

   “.”返回的是该方法返回值。如果要链式，需要修改方法的返回值为this。

### 2. dart的作用域？
   
   没有public和private关键字，默认是public。

   私有变量或者方法_下划线开头。

### 3. dart 是不是单线程模型？是如何运行的？
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
+ isolate
  - 在Dart中，每个线程都运行在一个叫做isolate的独立环境中，它的内存不和其他线程共享，它在不停的干一件:事件循环。
+ 异步IO+事件循环
   - 异步I/O,内存密集型I/O操作丢给操作系统，等待操作系统回调。
+ 事件循环Event loop
   - "微任务队列" Microtask queue、
   - “事件队列” Event queue。
   - Microtask queue 比 Event queue有更高的优先级。
   - API层的Future、Stream、async和await实际上都是对事件循环的抽象。
   - Event queue 用来处理外部事件，I/O,点击、绘制、计时器和不同的isolate间的消息事件
   - MicroTask queue 用来处理dart内部的任务，，适合用过来不会特别耗时或者紧急的任务。
+ 得益于异步IO+事件循环，尽管Dart是单线程，一般的IO密集型App应用通常也能获得出色的性能表现。
+ 但对于一些计算量巨大的场景，比如图片处理、反序列化、文件压缩这些计算密集型操作，只单靠一个线程就不够用了。
+ 简单示例
```
import 'dart:asynnc';
main(){
   new Future(()=>print('world'));//event queue
   Future.microtask(()=>print('hello'));//microtask
}
```

### 4. dart是如何实现多任务并行的？
+ 依赖于dart的并发编程、异步和事件驱动机制。
   - 具体来说，一个isolate对象就是对一个isolate执行环境的引用，可以看做是一个线程。
   - 由于isolate环境独立，不共享内存，多个isolate通过SendPort相互发送给消息，而isolate中也存在对应的ReceivePort用来接收消息。
   - isolate间的消息被放入Event queue等待处理，依赖Event loop机制。
+ 关系图
  ```plantuml
  @startuml
  
  @enduml
  ```
+ 代码示例
  ```
  Future<SendPort> initIsolate() async {
    Completer completer = new Completer<SendPort>();
    ReceivePort receiverInMain = ReceivePort();
    //监听来自子线程的消息
    receiverInMain.listen((data) {
      if (data is SendPort) {
        SendPort senderMainToSub = data;
        completer.complete(senderMainToSub);
      } else {
        print('[isolateToMainStream] $data');
      }
    });

    Isolate myIsolateInstance = await Isolate.spawn(newIsolate, receiverInMain.sendPort);

    //返回来自子isolate的sendPort
    return completer.future; 
  }

  void newIsolate(SendPort isolateToMainStream) {
    ReceivePort receiverInSub = ReceivePort();
    //关键实现：把SendPort对象传回给主isolate
    isolateToMainStream.send(receiverInSub.sendPort);

    //监听来自主isolate的消息
    mainToIsolateStream.listen((data) {
      print('[mainToIsolateStream] $data');
    });

    isolateToMainStream.send('This is from new isolate');
  }

  void main() async{
    SendPort mainToIsolate = await initIsolate();
    mainToIsolate.send('This is from main isolate');
  }

```


  

