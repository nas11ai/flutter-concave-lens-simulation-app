import 'package:flutter/material.dart';

class MainAxis extends StatelessWidget {
  const MainAxis({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MainAxisPainter(),
      child: Container(),
    );
  }
}

class MainAxisPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var xAxisPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;

    var yAxisPaint = Paint()
      ..color = Colors.lightGreen
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;

    Offset xStartingPoint = Offset(0, size.height / 2);
    Offset xEndingPoint = Offset(size.width, size.height / 2);

    Offset yStartingPoint = Offset(size.width / 2, 0);
    Offset yEndingPoint = Offset(size.width / 2, size.height);

    canvas.drawLine(xStartingPoint, xEndingPoint, xAxisPaint);
    canvas.drawLine(yStartingPoint, yEndingPoint, yAxisPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
