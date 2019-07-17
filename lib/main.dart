import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'dart:math' as math;
import 'dart:ui' as ui;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hey There App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HeyTherePage(title: 'Hey There App'),
    );
  }
}

class HeyTherePage extends StatefulWidget {
  HeyTherePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HeyTherePageState createState() => _HeyTherePageState();
}

class _HeyTherePageState extends State<HeyTherePage>
    with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  Color color;

  _setRandomBgColor() {
    setState(() {
      controller = AnimationController(
          duration: const Duration(milliseconds: 1000), vsync: this);
      animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
      controller.reverse();
      color = Color((math.Random().nextDouble() * 0xFFFFFF).toInt() << 0)
          .withOpacity(1.0);
      controller.forward();
    });
  }

  @override
  void initState() {
    super.initState();
    color = Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FadeTransition(
        opacity: animation,
        child: Stack(
          children: <Widget>[
            Center(
              child: ShadowText(
                'Hey there',
                style: Theme.of(context).textTheme.display3,
              ),
            ),
            GestureDetector(
              onTap: _setRandomBgColor,
            ),
          ],
        ),
      ),
    );
  }
}

class ShadowText extends StatelessWidget {
  ShadowText(this.data, {this.style}) : assert(data != null);

  final String data;
  final TextStyle style;

  Widget build(BuildContext context) {
    return ClipRect(
      child: Stack(
        children: [
          Positioned(
            top: 2.0,
            left: 2.0,
            child: Text(
              data,
              style: style.copyWith(color: Colors.black.withOpacity(0.5)),
            ),
          ),
          BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: Text(data, style: style),
          ),
        ],
      ),
    );
  }
}
