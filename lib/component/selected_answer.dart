import 'package:flutter/material.dart';

class SelectedAnswer extends StatefulWidget {
  SelectedAnswer(
      {Key? key,
      this.selected = false,
      this.cauSo = "",
      this.cauTraLoi = "",
      this.ontap})
      : super(key: key);
  bool selected;
  final String cauSo;
  final String cauTraLoi;
  final VoidCallback? ontap;

  @override
  _SelectedAnswerState createState() => _SelectedAnswerState();
}

class _SelectedAnswerState extends State<SelectedAnswer> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.ontap,
      // onTap: () {
      //   setState(() {
      //     widget.selected = !widget.selected;
      //     turns = widget.selected ? turns + 1.0 : turns - 1.0;
      //     widget.selected ? _controller.forward() : _controller.reverse();
      //   });
      // },
      child: AnimatedContainer(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.all(5),
        duration: const Duration(milliseconds: 100),
        decoration: BoxDecoration(
            color:
                widget.selected ? Colors.grey : Colors.black.withOpacity(0.8),
            borderRadius: BorderRadius.circular(50)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            AnimatedOpacity(
              opacity: widget.selected ? 0.0 : 1.0,
              duration: const Duration(milliseconds: 100),
              child: AnimatedSlide(
                offset: widget.selected ? const Offset(3.0, 0) : Offset.zero,
                curve: Curves.easeInOut,
                duration: const Duration(milliseconds: 200),
                child: AnimatedRotation(
                  turns: widget.selected ? 1.0 : -1.0,
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(left: 5, right: 10),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blueAccent,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 8,
                              offset: const Offset(-5.0, 5.0))
                        ]),
                    child: Text(
                      widget.cauSo,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              child: Text(
                widget.cauTraLoi,
                style: TextStyle(
                    fontSize: 16,
                    color: widget.selected ? Colors.black : Colors.white),
              ),
            ),
            AnimatedOpacity(
              opacity: widget.selected ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 100),
              child: AnimatedSlide(
                offset: widget.selected ? Offset.zero : const Offset(-3.0, 0),
                curve: Curves.easeInOut,
                duration: const Duration(milliseconds: 200),
                child: AnimatedRotation(
                  turns: widget.selected ? 1.0 : -1.0,
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(left: 5, right: 10),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 8,
                              offset: const Offset(-5.0, 5.0))
                        ]),
                    child: const Icon(Icons.close),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
