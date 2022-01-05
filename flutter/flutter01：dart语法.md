## 定义变量

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

![截屏2022-01-04 下午8.03.11](/Users/didi/Library/Application Support/typora-user-images/截屏2022-01-04 下午8.03.11.png)