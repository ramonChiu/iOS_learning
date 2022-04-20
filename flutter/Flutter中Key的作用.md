##### 了解key的作用，先了解几个概念

1.flutter里面有三个树形结构widget树、element树、renderObject树。

2..widget树的元素和element树的元素有一一映射的关系。

3.一般程序员直接操作的是widget元素。

4.flutter底层是增量更新的机制。

##### 在增量更新的机制下，widget重建时，会与旧的widget进行匹配。默认情况下，框架根据它们的runtimeType以及它们的显示顺序来匹配。如果匹配成功就可以复用它对应的element元素。

源码如下：

1.比较如否可以更新，按顺序比较runtimeType和 key。

```dart
  static bool canUpdate(Widget oldWidget, Widget newWidget) {
    return oldWidget.runtimeType == newWidget.runtimeType
        && oldWidget.key == newWidget.key;
  }
```

```dart
    // Update the top of the list.
    while ((oldChildrenTop <= oldChildrenBottom) && (newChildrenTop <= newChildrenBottom)) {
      final Element? oldChild = replaceWithNullIfForgotten(oldChildren[oldChildrenTop]);
      final Widget newWidget = newWidgets[newChildrenTop];
      assert(oldChild == null || oldChild._lifecycleState == _ElementLifecycle.active);
      if (oldChild == null || !Widget.canUpdate(oldChild.widget, newWidget))
        break;
```

```dart
  void update(covariant Widget newWidget) {
    // This code is hot when hot reloading, so we try to
    // only call _AssertionError._evaluateAssertion once.
    assert(
      _lifecycleState == _ElementLifecycle.active
        && widget != null
        && newWidget != null
        && newWidget != widget
        && depth != null
        && Widget.canUpdate(widget, newWidget),
    );
    // This Element was told to update and we can now release all the global key
    // reservations of forgotten children. We cannot do this earlier because the
    // forgotten children still represent global key duplications if the element
    // never updates (the forgotten children are not removed from the tree
    // until the call to update happens)
    assert(() {
      _debugForgottenChildrenWithGlobalKey.forEach(_debugRemoveGlobalKeyReservation);
      _debugForgottenChildrenWithGlobalKey.clear();
      return true;
    }());
    _widget = newWidget;
  }
```



##### 例子：

当我们删除红色的w1，触发widget树重建，此时没有key来区。

w2.index = w1.index;

w2.runtimeType == w1.runType.type；

w2.elment = e1；

此时w1和w2的都是statefulWidget。他们的颜色属性都是存在state对象。w2复用了e1也就是复用了e1的state。显示为红色。而e3，因为没有widget使用，从屏幕中移除。这就导致了我们想删除红色w1，最后却得到了红色w2和橘色的w3。

而对于statelessWidget类型，是没有影响的，因为颜色属性存储在widget层，复用底层element不会影响最终的显示结果。看起来我们是正常的删除了红色w1。

因此对于上面场景，对于statefulWidget我们需要添加Key对w1，w2，w3进行区分。使得w2人仍然与e2绑定。

##### 我们记住一点Key就是用来区分和标识widget的。

![截屏2022-02-09 下午2.33.34](https://tva1.sinaimg.cn/large/008i3skNly1gz78zcgwvfj310o0tgwgy.jpg)

##### key

```da
/// A [Key] is an identifier for [Widget]s, [Element]s and [SemanticsNode]s.
///
/// A new widget will only be used to update an existing element if its key is
/// the same as the key of the current widget associated with the element.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=kn0EOS-ZiIc}
///
/// Keys must be unique amongst the [Element]s with the same parent.
///
/// Subclasses of [Key] should either subclass [LocalKey] or [GlobalKey].
///
/// See also:
///
///  * [Widget.key], which discusses how widgets use keys.



```

##### localkey

```
ValueKey  以值作为参数：数字，字符串等
ObjectKey 以对象作为参数
UniqueKey 唯一标识
```



##### globalkey

在整个app声明周期内唯一。

通过globalkey可以访问它关联的elements，state。

当一个globalkey关联的widget在树移动，可以把它的自树及对应element和state都移动到对应位置。须确保在同一动画帧中。

在element树中移动一个关联globalkey的element开销很大。这个操作会对它关联的state调用State.deactive，包括所有的子元素。然后会强制所有的widget依赖一个InheritedWidget去重建。

不能同时在树中包含有相同globalkey的俩个widget。

你不需要使用上面特性，考虑使用valueKey,ObjectKey,UniqueKey。

```
A key that is unique across the entire app.

Global keys uniquely identify elements. Global keys provide access to other objects that are associated with those elements, such as BuildContext. For StatefulWidgets, global keys also provide access to State.

Widgets that have global keys reparent their subtrees when they are moved from one location in the tree to another location in the tree. In order to reparent its subtree, a widget must arrive at its new location in the tree in the same animation frame in which it was removed from its old location in the tree.

Reparenting an Element using a global key is relatively expensive, as this operation will trigger a call to State.deactivate on the associated State and all of its descendants; then force all widgets that depends on an InheritedWidget to rebuild.

If you don't need any of the features listed above, consider using a Key, ValueKey, ObjectKey, or UniqueKey instead.

You cannot simultaneously include two widgets in the tree with the same global key. Attempting to do so will assert at runtime.
```

##### 总结

key作为widget标识，可以再widget树重建时，发挥作用。具有相同runtimeType和key的newWidget可以复用已经存在element元素。

globalkey的提供了再任意地方访问它关联元素的方式。可以让他关联的元素保留他的state在树中移动，当然资源开销比较大。

localkey可以用来区分同一父节点下的子元素。分为三种：ValueKey，ObjectKey,Uniquekey。

