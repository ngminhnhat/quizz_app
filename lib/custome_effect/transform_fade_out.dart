import 'package:flutter/material.dart';

class TransformFadeOut extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TransformFadeOutState();
  }
}

class TransformFadeOutState extends State<TransformFadeOut> {
  bool visible = true;
  double _turn = 0.0;
  Widget child = Container();

  void _toggle() {
    setState(() {
      visible = !visible;
      _turn += 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 200,
        height: 350,
        child: Stack(
          children: <Widget>[
            AnimatedPositioned(
              left: visible ? 50 : -50,
              duration: Duration(milliseconds: 300),
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 300),
                opacity: visible ? 1.0 : 0.0,
                curve: Curves.easeOut,
                child: AnimatedPositioned(
                  right: visible ? 50 : 150,
                  duration: Duration(milliseconds: 300),
                  child: GestureDetector(
                    onTap: _toggle,
                    child: AnimatedRotation(
                      turns: _turn,
                      duration: Duration(milliseconds: 300),
                      child: Container(
                        color: Colors.amber,
                        child: Icon(Icons.abc),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
