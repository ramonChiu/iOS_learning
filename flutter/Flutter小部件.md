#### runApp(widget)函数

```
Inflate the given widget and attach it to the screen
```

可以类比iOS程序的设置rootVC & makeVisibale。

## widget

- 我们学习Flutter，从一开始就可以有一个基本的认识：**Flutter中万物皆Widget（万物皆可盘）**；
- 在我们iOS或者Android开发中，我们的界面有很多种类的划分：应用（Application）、视图控制器（View Controller）、活动（Activity）、View（视图）、Button（按钮）等等；
- 但是在Flutter中，**这些东西都是不同的Widget而已**；
- 也就是我们整个应用程序中`所看到的内容`几乎都是Widget，甚至是`内边距的设置`，我们也需要使用一个叫`Padding的Widget`来做；

#### runApp函数让我们传入的就是一个Widget：

- 但是我们现在没有Widget，怎么办呢？
- 我们可以导入Flutter默认已经给我们提供的Material库，来使用其中的很多内置Widget；

#### Material

- material是Google公司推行的一套`设计风格`，或者叫`设计语言`、`设计规范`等；
- 里面有非常多的设计规范，比如`颜色`、`文字的排版`、`响应动画与过度`、`填充`等等；
- 在Flutter中高度集成了`Material风格的Widget`；
- 在我们的应用中，我们可以直接使用这些Widget来创建我们的应用（后面会用到很多）；

#### StatelessWidget

StatelessWidget通常是一些没有状态（State，也可以理解成data）需要维护的Widget：

- ###### 它们的数据通常是直接写死（放在Widget中的数据，必须被定义为final，为什么呢？我在下一个章节讲解StatefulWidget会讲到）；

- 从parent widget中传入的而且一旦传入就不可以修改；

- 从InheritedWidget获取来使用的数据（这个放到后面会讲解）；

我们来看一下创建一个StatelessWidget的格式：

- 1、让自己创建的Widget继承自StatelessWidget；

- 2、StatelessWidget包含一个必须重写的方法：build方法；

  ```dart
  
  class MyStatelessWidget extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return <返回我们的Widget要渲染的Widget，比如一个Text Widget>;
    }
  }
  ```

  

  **build方法的解析：**

  - Flutter在拿到我们自己创建的StatelessWidget时，就会执行它的build方法；
  - 我们需要在build方法中告诉Flutter，我们的Widget希望渲染什么元素，比如一个Text Widget；
  - StatelessWidget没办法主动去执行build方法，当我们使用的数据发生改变时，build方法会被重新执行；

  **build方法什么情况下被执行呢？：**

  - 1、当我们的StatelessWidget第一次被插入到Widget树中时（也就是第一次被创建时）；
  - 2、当我们的父Widget（parent widget）发生改变时，子Widget会被重新构建；
  - 3、如果我们的Widget依赖InheritedWidget的一些数据，InheritedWidget数据发生改变时；

#### 常用小部件

###### 框架

MarerialApp/Scaffold

###### 文本

/Text/TextSpan

###### 按钮和手势

/FloatingActionButton/FlatButton/OutlineButton/GestureDetector

###### 图片

Image

###### 圆角

CircleAvatar、ClipOval、ClipRRect、Container+BoxDecoration

###### 表单widget

TextField、TextEditingController():可以给=TextFeild设置Controller

###### Form表单

TextFormField

###### 单子布局widget

Align、Center、Padding、Container、BoxDecoration、/SizeBox

###### 多子布局widget

Flex/Row/Column/Stack/Expanded

#### 滚动widget

###### ListView    

##### 列表视图

###### GridView   

##### 用于多列展示、网格式图

###### Slivers 

我们考虑一个这样的布局：一个滑动的视图中包括一个标题视图（HeaderView），一个列表视图（ListView），一个网格视图（GridView）。

我们怎么可以让它们做到统一的滑动效果呢？使用前面的滚动是很难做到的。

Flutter中有一个可以完成这样滚动效果的Widget：CustomScrollView，可以统一管理多个滚动视图。

在CustomScrollView中，每一个独立的，可滚动的Widget被称之为Sliver。

补充：Sliver可以翻译成裂片、薄片，你可以将每一个独立的滚动视图当做一个小裂片。

###### Json资源

```
import'package:flutter/services.dart' show rootBundle;

rootBundle.loadString("assets/yz.json").then((value) => print(value));

// 1.读取json文件
String jsonString = await rootBundle.loadString("assets/yz.json");

// 2.转成List或Map类型
final jsonResult = json.decode(jsonString);
```



自定义Model

```dart
class Anchor {
  String nickname;
  String roomName;
  String imageUrl;

  Anchor({
    this.nickname,
    this.roomName,
    this.imageUrl
  });

  Anchor.withMap(Map<String, dynamic> parsedMap) {
    this.nickname = parsedMap["nickname"];
    this.roomName = parsedMap["roomName"];
    this.imageUrl = parsedMap["roomSrc"];
  }
}
```

#### PreferredSize

用来自定义AppBar，tabBar。不以任何形式影响子部件布局，子部件为AppBar，或者AppBar.bottom