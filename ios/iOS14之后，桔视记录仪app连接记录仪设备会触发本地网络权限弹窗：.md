iOS14之后，桔视记录仪app连接记录仪设备会触发本地网络权限弹窗：

![img](https://didoc-upload-file-prod.s3.didiyunapi.com/1661750989036/IMG_0600.PNG)

官方文档：https://developer.apple.com/videos/play/wwdc2020/10110/?time=73

由于连接记录仪设备是记录仪app为用户提供服务的基础能力。我们需要按照官方文档要求，在info.plist中声明权限，尊重用户隐私和知情权。

![img](https://didoc-upload-file-prod.s3.didiyunapi.com/1661752310019/image.png)

修改后提示如下

![img](https://didoc-upload-file-prod.s3.didiyunapi.com/1661752459092/IMG_0601.PNG)

该权限弹窗弹出一次后，用户选择“不允许”后，将不会再次弹出。我们需要获取本地网络的授权状态，在与设备通讯不可用时，给用户准确的提示。

查看相关资料发现，并没有直接的api可以获取本地网络的授权状态。而可采用的间接方式，了解了3种：

1.DNSServiceBrowse

2.SimplePing

3.GCDAsyncSocket

为了不引入新的问题，这里采用了项目中原有的GCDAsyncSocket来判定授权状态。

```
-(void)connectToIP{
    NSError *error;
    NSString *ip = [EDRouteIp getGatewayIpForCurrentWiFi];
    //NSString *ip = @"192.168.43.1";
    [_socket connectToHost:ip onPort:8080 withTimeout:10 error:&error];
    NSLog(@"%@",error);
}
- (void)socketDidDisconnect:(GCDAsyncSocket*)sock withError:(NSError*)err{
    _socket.delegate = (id)self;
    socketResultBlock block = [_socketMapDic objectForKey:_currentSendTag];
    if(block){
        EDSocketPackageModel *pack = [[EDSocketPackageModel alloc]init];
        pack.completeTag = PackageCompletenessTag_SocketDisconnect;
        block(pack);
    }
    [_socketMapDic removeAllObjects];
    if (err.code == 65) {
        [[NSNotificationCenter defaultCenter] postNotificationName:EDNotificationLocalNetWorkDisable object:nil];
        return;
    }
    [self connectToIP];
}
```

未授权时，connectToIP并不会返回错误，而是在sccketDidDisconnect时，返回了error.code == 65,可用于判断授权状态。

另外需要开启本地网络权限的还有，[Bonjour服务](https://blog.csdn.net/weixin_48430195/article/details/112578236)