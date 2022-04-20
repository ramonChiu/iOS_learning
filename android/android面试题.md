2 讲一下ArrayList和linkedlist的区别，ArrayList的扩容方式，扩容时机。

3 hashmap的实现，以及hashmap扩容底层实现。

- HashMap：了解其数据结构、hash冲突如何解决（链表和红黑树）、扩容时机、扩容时避免rehash的优化
- LinkedHashMap：了解基本原理、哪两种有序、如何用它实现LRU
- TreeMap：了解数据结构、了解其key对象为什么必须要实现Compare接口、如何用它实现一致性[哈希](http://msd.misuland.com/pd/3255817997595444850)



1. hashmap如何解决hash冲突，为什么hashmap中的链表需要转成红黑树？
2. hashmap什么时候会触发扩容？
3. jdk1.8之前并发操作hashmap时为什么会有死循环的问题？
4. hashmap扩容时每个entry需要再计算一次hash吗？
5. hashmap的数组长度为什么要保证是2的幂？
6. 如何用LinkedHashMap实现LRU？
7. 如何用TreeMap实现一致性hash？



Set基本上都是由对应的map实现，简单看看就好

常见问题

1. hashmap如何解决hash冲突，为什么hashmap中的链表需要转成红黑树？
2. hashmap什么时候会触发扩容？
3. jdk1.8之前并发操作hashmap时为什么会有死循环的问题？
4. hashmap扩容时每个entry需要再计算一次hash吗？
5. hashmap的数组长度为什么要保证是2的幂？
6. 如何用LinkedHashMap实现LRU？
7. 如何用TreeMap实现一致性hash？



常见问题

1. ConcurrentHashMap是如何在保证并发安全的同时提高性能？
2. ConcurrentHashMap是如何让多线程同时参与扩容？
3. LinkedBlockingQueue、DelayQueue是如何实现的？
4. CopyOnWriteArrayList是如何保证线程安全的？

ThreadLocal

了解ThreadLocal使用场景和内部实现

ThreadPoolExecutor

了解线程池的工作原理以及几个重要参数的设置



IO

了解BIO和NIO的区别、了解多路复用机制



GC

垃圾回收基本原理、几种常见的垃圾回收器的特性、重点了解CMS（或G1）以及一些重要的参数



1、开发中JAVA用了比较多的数据结构有哪些? 











5 自定义类加载器怎么实现，其中哪个方法走双亲委派模型，哪个不走，不走的话怎么加载类（实现findclass方法，一般用defineclass加载外部类），如何才能不走双亲委派。（重写loadclass方法）







1.Java基础还是需要掌握牢固，重点会问HashMap等集合类，

以及多线程、

线程池等。



5，B+树和B树区别？

B树的非叶子节点存储实际记录的指针，而B+树的叶子节点存储实际记录的指针

B+树的叶子节点通过指针连起来了, 适合扫描区间和顺序查找。





设计模式 工厂模式 单例模式



synchronized和加载

jvm的内存模型

threadlocal场景和注意事项



## 对设计模式的看法和认知

##  

## 有哪些设计模式

hashmap和concurrenthashmap区别及两者的优缺点



关于树的算法题-二叉树的锯齿形层次遍历：[二叉树的锯齿形层次遍历](http://link.zhihu.com/?target=http%3A//www.lintcode.com/zh-cn/problem/binary-tree-zigzag-level-order-traversal/)

Java的垃圾回收机制





电面过程中非常注重基础知识的考察，面试前务必对基础知识内容进行复习和梳理。基础知识考察的内容一般会围绕项目内容进行展开，在前期对项目介绍进行准备时需适当换位，思考面试官的提问逻辑，避免给自己设下陷阱。





## 如何进行自学

##  

## 阅读过那些书籍





项目运行过程中成员是否曾就某一点发生争执？作为Leader你是如何解决的？具体事例？





## 最小子串覆盖。原题链接：[最小子串覆盖](http://link.zhihu.com/?target=http%3A//www.lintcode.com/zh-cn/problem/minimum-window-substring/)





你觉得你在项目运行过程中作为组长是否最大限度发挥了组员的优势？具体事例？





# 职业规划，今后想发展的工作方向





# 线程池的一些原理，锁的机制升降级（天猫、蚂蚁）



23、n个整数，找出连续的m个数加和是最大。（天猫）



# 26、1000个线程同时运行，怎么防止不卡（航旅）





# 30、流量控制相关问题（蚂蚁金服）





34、Java的集合都有哪些，都有什么特点（信息平台）



## 8、什么是反射机制？

## 9、说说反射机制的作用。

## 10、反射机制会不会有性能问题？



# 30、描述一下Java异常层次结构。



# 32、finally块一定会执行吗？



31、什么是检查异常，不受检查异常，运行时异常？并分别举例说明。

32、finally块一定会执行吗？

33、正常情况下，当在try块或catch块中遇到return语句时，finally语句块在方法返回之前还是之后被执行？

34、try、catch、finally语句块的执行顺序。

35、Java虚拟机中，数据类型可以分为哪几类？

36、怎么理解栈、堆？堆中存什么？栈中存什么？

37、为什么要把堆和栈区分出来呢？栈中不是也可以存储数据吗？

38、在Java中，什么是是栈的起始点，同是也是程序的起始点？

39、为什么不把基本类型放堆中呢？



40、Java中的参数传递时传值呢？还是传引用？

41、Java中有没有指针的概念？

42、Java中，栈的大小通过什么参数来设置？

43、一个空Object对象的占多大空间？

44、对象引用类型分为哪几类？

45、讲一讲垃圾回收算法。

46、如何解决内存碎片的问题？

47、如何解决同时存在的对象创建和对象回收问题？

48、讲一讲内存分代及生命周期。

49、什么情况下触发垃圾回收？

50、如何选择合适的垃圾收集算法？

51、JVM中最大堆大小有没有限制？

52、堆大小通过什么参数设置？

53、JVM有哪三种垃圾回收器？

54、吞吐量优先选择什么垃圾回收器？响应时间优先呢？

55、如何进行JVM调优？有哪些方法？

56、如何理解内存泄漏问题？有哪些情况会导致内存泄露？如何解决？