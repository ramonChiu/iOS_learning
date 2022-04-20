

## 一、定义变量

### 1.明确声明

```dart
变量类型 变量名称 = 赋值;
```

示例代码：

```dart
String name = 'ramon';
int age = 18;
double height = 1.88;
print('${name},${age},${height}');
```

注意事项：定义的变量可以修改值，但是不能赋值其他类型

```dart
String test = 'qlp';
test = 'ramon';
test = 111;//错误的，将一个int值赋值给String类型变量
```

### 2.类型推导 Type Inference

#### var声明变量：

```dart
var name = 'ramon';
name = 'QLP';
print(name.runtimeType);//String
```

#### var的错误用法：

```dart
var age = 18;
age = 'qlp';//错误做法，age类型推导为int
```

#### dynamic声明变量：

如果确实想给变量赋不同类型的值，可以使用dynamic修饰，但是dynamic类型的不确定，会带来潜在的风险。

```
  dynamic content = 'qlp';
  content = 'dd';
  content = 111;
```

![截屏2022-01-04 下午8.03.11](https://tva1.sinaimg.cn/large/008i3skNly1gy2uylxa08j31be0asq3n.jpg)

#### final&const

final和const都可以用来定义常量。也就是定义之后都不可更改。

final 和 const可以配合显示声明使用,或者直接使用。

![截屏2022-01-05 下午4.05.56](https://tva1.sinaimg.cn/large/008i3skNly1gy2uygs8srj30sq0cedgk.jpg)

##### final和const的区别

const修饰的变量在编译期就能确定下来。

final就是的变量需要运行时动态获取。当然final修饰编译时常量也没有问题。

```dart
  final time = DateTime.now();
  const time = Datetime.now();//编译报错，const只能修饰编译时常量
  final a = 100;
  const b = 100;
```

const放在赋值语句的右边可以共享对象，提高性能。

```dart

class Person {
  const Person();
}

main(List<String> args) {
  final a = const Person();
  final b = const Person();
  print(identical(a, b)); // true a和b是同一个对象。

  final m = Person();
  final n = Person();
  print(identical(m, n)); // false
}
```

## 二、dart的数据类型

### 数字类型

##### int 整形就用int

##### double 浮点型就用double

##### num 可以是整形也可以是浮点型

```dart
num a = 10;
num b = 10.0;
int c = 20;
double d = 20.0;
print(a.runtimeType);//int
print(b.runtimeType);//double
print(c.runtimeType);//int
print(d.runtimeType);//double
```

### bool值

dart中的bool值就是true和false

但是dart不能像OC那样判定非0为真，或者非空位真![截屏2022-01-05 下午4.45.36](/Users/didi/Library/Application Support/typora-user-images/截屏2022-01-05 下午4.45.36.png)

### 字符串类型

dart字符串是UTF-16编码单元的序列。您可以使用单引号或者双引号创建序列。

```dart
// 1.定义字符串的方式
var s1 = 'Hello World';
var s2 = "Hello Dart";
var s3 = 'Hello\'Fullter';
var s4 = "Hello'Fullter";
```

可以使用三个单引号或者双引号标识多行字符串

```dart
var text = """
  心平能愈三千疾
  唯有相思不可医
  """;
  var text1 = '''
    去年昨日此门中
    人面桃花相映红
    人面不知何处去
    桃花依旧笑春风
  ''';
```

![截屏2022-01-05 下午4.58.15](/Users/didi/Library/Application Support/typora-user-images/截屏2022-01-05 下午4.58.15.png)

字符串和其他变量或者表达式拼接使用${},如果表达式是一个标识符，可以省略{}

示例代码

```
  var name = 'ramon';
  var age = 18;
  var height = 1.78;
  print('my name is $name,今年${age}岁，身高${height}m');
```

![截屏2022-01-05 下午5.04.13](/Users/didi/Library/Application Support/typora-user-images/截屏2022-01-05 下午5.04.13.png)

#### 数字和String转换

```
  var number = int.parse("1111");
  var text = number.toString();
```

### 集合类型

list、set、map

```dart
//list定义

// List定义
// 1.使用类型推导定义
var letters = ['a', 'b', 'c', 'd'];
print('$letters ${letters.runtimeType}');

// 2.明确指定类型
List<int> numbers = [1, 2, 3, 4];
print('$numbers ${numbers.runtimeType}');
```

```dart

// Set的定义
// 1.使用类型推导定义
var lettersSet = {'a', 'b', 'c', 'd'};
print('$lettersSet ${lettersSet.runtimeType}');

// 2.明确指定类型
Set<int> numbersSet = {1, 2, 3, 4};
print('$numbersSet ${numbersSet.runtimeType}');
```

```

// Map的定义
// 1.使用类型推导定义
var infoMap1 = {'name': 'why', 'age': 18};
print('$infoMap1 ${infoMap1.runtimeType}');

// 2.明确指定类型
Map<String, Object> infoMap2 = {'height': 1.88, 'address': '北京市'};
print('$infoMap2 ${infoMap2.runtimeType}');
```

#### 集合的常见操作

获取length

```dart
// 获取集合的长度
print(letters.length);
print(lettersSet.length);
print(infoMap1.length)
```

增删改查

```dart
//api介绍不全，就具体可以使用时再查询。
// 添加/删除/包含元素。
numbers.add(5);
numbersSet.add(5);
print('$numbers $numbersSet');

numbers.remove(1);
numbersSet.remove(1);
print('$numbers $numbersSet');

print(numbers.contains(2));
print(numbersSet.contains(2));

// List根据index删除元素
numbers.removeAt(3);
print('$numbers');
```

map操作，就于键值映射

```dart

// Map的操作
// 1.根据key获取value
print(infoMap1['name']); // why

// 2.获取所有的entries
print('${infoMap1.entries} ${infoMap1.entries.runtimeType}'); // (MapEntry(name: why), MapEntry(age: 18)) MappedIterable<String, MapEntry<String, Object>>

// 3.获取所有的keys
print('${infoMap1.keys} ${infoMap1.keys.runtimeType}'); // (name, age) _CompactIterable<String>

// 4.获取所有的values
print('${infoMap1.values} ${infoMap1.values.runtimeType}'); // (why, 18) _CompactIterable<Object>

// 5.判断是否包含某个key或者value
print('${infoMap1.containsKey('age')} ${infoMap1.containsValue(18)}'); // true true

// 6.根据key删除元素
infoMap1.remove('age');
print('${infoMap1}'); // {name: why}
```

## 三、函数

dart 是面向对象的语言，所以函数也是对象，它的类型是Function。

这也就意味着函数可以作为变量定义或者作为其他函数的参数或者返回值。

函数定义方式

```
返回值 函数名称(参数列表){
	函数体
	返回值
}
int sum(int a,int b){
	return a+b;
}
```

Effective Dart建议对公共的API, 使用类型注解, 但是如果我们省略掉了类型, 依然是可以正常工作的

```
sum(a,b){
	return a+b;
}
```

如果函数中只有一个表达式，可以使用箭头函数

```
sum(a,b)=>a+b
```

#### 可选参数

##### 命名可选参数和位置可选参数

他们区别是命名可选参数是通过命名来选择性传参，比较灵活。

位置可选参数只能通过位置依次传参，前面的可选参数没有传参，后面的也不可以进行传参。

```
//定义方式
命名可选参数: {param1, param2, ...}
位置可选参数: [param1, param2, ...]
```

```dart
//示例

// 命名可选参数
printInfo1(String name, {int age, double height}) {
  print('name=$name age=$age height=$height');
}

// 调用printInfo1函数
printInfo1('why'); // name=why age=null height=null
printInfo1('why', age: 18); // name=why age=18 height=null
printInfo1('why', age: 18, height: 1.88); // name=why age=18 height=1.88
printInfo1('why', height: 1.88); // name=why age=null height=1.88


// 定义位置可选参数
printInfo2(String name, [int age, double height]) {
  print('name=$name age=$age height=$height');
}

// 调用printInfo2函数
printInfo2('why'); // name=why age=null height=null
printInfo2('why', 18); // name=why age=18 height=null
printInfo2('why', 18, 1.88); // name=why age=18 height=1.88
```

#### 默认值

可选参数可以有默认值，新版的dart中，可选参数没有默认值，需要标记为optional。

必须参数不能有默认值。

```dart
  printInfo1(String name, {int age = 18, double height = 1.78}){
    print('name=$name age=$age height=$height');
  }
```

#### 函数一等公民

在很多语言中，函数并不能作为一等公民来使用，比如java、oc。这种限制让编程不够灵活，所以现代编程语言基本都支持函数作为一等公民来使用。dart也支持。

#### Factory关键字

用来修饰工厂方法，主要作用：

1. A factory constructor can check if it has a prepared reusable instance in an internal cache and return this instance or otherwise create a new one.
   ***避免创建过多的重复实例，如果已创建该实例，则从缓存中拿出来。\***
2. You can for example have an abstract class A (which can't be instantiated) with a factory constructor that returns an instance of a concrete subclass of A depending for example on the arguments passed to the factory constructor.
   ***调用子类的构造函数(工厂模式 factory pattern)\***
3. singleton pattern
   ***实现单例模式\***

```dart
class Logger {
  final String name;
  // 缓存已创建的对象
  static final Map<String, Logger> _cache = <String, Logger>{}; 

  factory Logger(String name) {
  // 不理解putIfAbsent可以查看文末的简述
    return _cache.putIfAbsent(  
        name, () => Logger._internal(name));
  }

// 私有的构造函数
  Logger._internal(this.name){
    print("生成新实例：$name");
  }
}

// 测试
main() {
  var p1 = new Logger("1");
  var p2 = new Logger('22');
  var p3 = new Logger('1');// 相同对象直接访问缓存

  //identical会对两个对象的地址进行比较，相同返回true，
  //等同于 == ，好处是如果重写了==，那用identical 会更方便。
  print(identical(p1,p3)); 
}
```

```dart
abstract class Animal {
  String name;
  void getNoise();
  factory Animal(String type,String name) {
    switch(type) {
      case "cat":
        return new Cat(name);
      case "dog":
        return new Dog(name);
      default:
        throw "The '$type' is not an animal";
    }
  }
}
```

```dart
class Singleton {
  static final Singleton _singleton = Singleton._internal();

  factory Singleton() {
    return _singleton;
  }
  
  Singleton._internal();
}
```