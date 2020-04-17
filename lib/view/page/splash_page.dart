import 'package:flutter/material.dart';
import 'package:roamcat_flutter/view/router.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashPageState();
  }
}

//with是mixin的关键字(mixin: 混入，相当于dart中的多继承)
class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  AnimationController _logoController;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    //flutter中动画的官方文档：https://flutterchina.club/tutorials/animation/
    //创建动画控制器，设置TickerProvider(当前state继承自TickerProvider的子类mixin)和Duration间隔
    _logoController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    //创建Animation对象，Tween表示动画原始值区间，CurvedAnimation原生值映射为一个曲线，Curves中内置了一些常用的曲线
    _animation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(curve: Curves.easeInOutCirc, parent: _logoController))
      //..为Dart级联符号，表示返回的为..前表达式的值，并用改值继续执行后面的操作
      ..addStatusListener((status) {
        //设置动画一直循环
        if (status == AnimationStatus.completed) {
          _logoController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _logoController.forward();
        }
      });
    //开始动画
    _logoController.forward();

    //2秒后跳转到首页
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacementNamed(
        RouteName.mainTab,
        arguments: {'index': 0},
      );
    });
  }

  @override
  void dispose() {
    _logoController?.dispose(); //释放动画防止内存泄漏
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedLogo(animation: _animation),
      ),
    );
  }
}

class AnimatedLogo extends AnimatedWidget {
  AnimatedLogo({
    Key key,
    Animation<double> animation,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    //AnimatedAlign为控制alignment的位移动画，duration为回调间隔，alignment设置Widget位置，curve为映射曲线
    return AnimatedAlign(
      duration: Duration(milliseconds: 20),
      alignment: Alignment(0, -0.2 + animation.value * 0.3),
      curve: Curves.ease,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(Icons.public, size: 60),
          Container(height: 3),
          Text(
            'RoamCatFlutter',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              //设置字体样式，传在pubspec.yaml配置的fonts-family对应的字符串
              fontFamily: "happyfont",
            ),
          ),
        ],
      ),
    );
  }
}
