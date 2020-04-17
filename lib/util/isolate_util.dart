import 'dart:isolate';

typedef IsolateDealFunction = dynamic Function(dynamic);

//flutter中文网-异步UI： https://flutterchina.club/flutter-for-android/#%E5%BC%82%E6%AD%A5ui
class IsolateUtil {
  ///子线程处理数据，并用异步方式回传返回值(注：func必须为静态方法)
  static Future<dynamic> execute(IsolateDealFunction func, dynamic data) async {
    //1.主线程创建一个ReceivePort(ReceivePort本质是Stream)
    ReceivePort mainReceivePort1 = ReceivePort();
    //2.通过spawn新建一个工作线程isolate，主线程把mainReceivePort1的sendPort作为message传给工作线程
    await Isolate.spawn(_entryPointer, mainReceivePort1.sendPort);
    //5.监听并接收到子线程传回来的workReceivePort.sendPort
    SendPort workSendPort = await mainReceivePort1.first;
    //6.使用workSendPort发送消息给子线程中的workReceivePort(带上回调用的mainReceivePort2.sendPort)
    ReceivePort mainReceivePort2 = ReceivePort();
    workSendPort.send(
        {"sendPort": mainReceivePort2.sendPort, "fun": func, "data": data});
    //10.监听并接收到子线程传回来的处理结果result
    var result = await mainReceivePort2.first;
    return result;
  }

  //Isolate.spawn中的entryPoint必须为静态方法，以下逻辑在子线程中处理
  static _entryPointer(SendPort mainSendPort1) async {
    //3.工作线程中创建一个workReceivePort，并通过接收到的mainSendPort1将其sendPort传给mainReceivePort1
    ReceivePort workReceivePort = ReceivePort();
    mainSendPort1.send(workReceivePort.sendPort);
    //4.监听传回主线程的workSendPort发送过来的消息
    await for (var msg in workReceivePort) {
      //7.接收到workSendPort发送过来的消息
      SendPort callbackSendPort = msg["sendPort"];
      dynamic func = msg["fun"];
      dynamic data = msg["data"];
      //8.处理data，一般为耗时操作
      dynamic result = func(data);
      //9.通过回调用的mainReceivePort2.sendPort，回调返回值给调用者
      callbackSendPort.send(result);
    }
  }
}
