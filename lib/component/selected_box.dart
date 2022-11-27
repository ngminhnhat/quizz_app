import 'package:flutter/material.dart';

class SelectedBox extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SelectedBoxState();
  }
}

class SelectedBoxState extends State<SelectedBox>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _animationTextController;
  late Animation _colorTween;
  late Animation _colorTextTween;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _animationTextController = AnimationController(
      vsync: this,
      reverseDuration: Duration(milliseconds: 200),
    );
    _colorTween = ColorTween(
            begin: Color.fromARGB(255, 211, 211, 211),
            end: Colors.amber.shade900)
        .animate(_animationController);
    _colorTextTween = ColorTween(begin: Colors.black, end: Colors.white)
        .animate(_animationController);
    _fadeAnimation = CurvedAnimation(
      parent: _animationTextController,
      curve: Curves.easeOut,
    );

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 10,
            offset: Offset(-8, 8),
          ),
        ],
      ),
      child: AnimatedBuilder(
        animation: _colorTween,
        builder: ((context, child) => ElevatedButton(
              onPressed: () {
                if (_animationController.status == AnimationStatus.completed) {
                  _animationController.reverse();
                } else {
                  _animationController.forward();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _colorTween.value,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35),
                ),
              ),
              child: Row(
                children: [
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 10,
                              offset: Offset(-8, 8),
                            ),
                          ]),
                      margin: EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                        right: 10,
                      ),
                      child: Material(
                        shape: CircleBorder(),
                        color: Colors.amber.shade900,
                        child: Center(
                          child: Text(
                            'A',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'data',
                      style: TextStyle(color: _colorTextTween.value),
                    ),
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 10,
                            offset: Offset(-8, 8),
                          ),
                        ]),
                    margin: EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                      left: 10,
                    ),
                    child: Material(
                      shape: CircleBorder(),
                      color: Colors.white,
                      child: Center(
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.close,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
