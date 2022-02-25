import 'package:flutter/material.dart';

class ObjectLine extends StatefulWidget {
  final double heightValue;
  final double distanceValue;
  final double shadowDistance;
  final double shadowHeight;

  const ObjectLine({
    Key? key,
    required this.heightValue,
    required this.distanceValue,
    required this.shadowDistance,
    required this.shadowHeight,
  }) : super(key: key);

  @override
  State<ObjectLine> createState() => _ObjectLineState();
}

class _ObjectLineState extends State<ObjectLine> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ObjectLinePainter(
        widget.heightValue,
        widget.distanceValue,
        widget.shadowDistance,
        widget.shadowHeight,
      ),
      child: Container(),
    );
  }
}

class ObjectLinePainter extends CustomPainter {
  final double heightValue;
  final double distanceValue;
  final double shadowDistance;
  final double shadowHeight;

  ObjectLinePainter(
    this.heightValue,
    this.distanceValue,
    this.shadowDistance,
    this.shadowHeight,
  );

  @override
  void paint(Canvas canvas, Size size) {
    var shadowX = (size.width / 2) - shadowDistance;
    var shadowY = (size.height / 2) + shadowHeight;
    var objectPaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;

    var distancePaint = Paint()
      ..color = Colors.orange.shade900
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;

    var focusPaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;

    var shadowFocusPaint = Paint()
      ..color = Colors.purple
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;

    var shadowDistancePaint = Paint()
      ..color = Colors.pink
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;

    var shadowObjectPaint = Paint()
      ..color = Colors.amber
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;

    // object line
    Offset objectStartingPoint = Offset(distanceValue, heightValue);
    Offset objectEndingPoint = Offset(distanceValue, size.height / 2);

    // distance line
    Offset distanceStartingPoint = Offset(distanceValue, heightValue);
    Offset distanceEndingPoint = Offset(size.width / 2, heightValue);

    // focus line
    Offset focusStartingPoint = Offset(distanceValue, heightValue);
    Offset focusEndingPoint = Offset(size.width / 2, shadowY);

    // shadow focus line
    Offset shadowFocusStartingPoint = Offset(size.width / 2, heightValue);
    Offset shadowFocusEndingPoint = Offset(shadowX, shadowY);

    // shadow distance line
    Offset shadowDistanceStartingPoint = Offset(shadowX, shadowY);
    Offset shadowDistanceEndingPoint = Offset(size.width / 2, shadowY);

    // shadow object line
    Offset shadowObjectStartingPoint = Offset(shadowX, size.height / 2);
    Offset shadowObjectEndingPoint = Offset(shadowX, shadowY);

    // draw object
    canvas.drawLine(objectStartingPoint, objectEndingPoint, objectPaint);

    // draw distance
    canvas.drawLine(distanceStartingPoint, distanceEndingPoint, distancePaint);

    if (heightValue < size.height / 2) {
      // draw focus
      canvas.drawLine(focusStartingPoint, focusEndingPoint, focusPaint);

      // draw shadow focus
      canvas.drawLine(
          shadowFocusStartingPoint, shadowFocusEndingPoint, shadowFocusPaint);

      // draw shadow distance
      canvas.drawLine(shadowDistanceStartingPoint, shadowDistanceEndingPoint,
          shadowDistancePaint);

      // draw shadow object
      canvas.drawLine(shadowObjectStartingPoint, shadowObjectEndingPoint,
          shadowObjectPaint);
    } else {
      focusEndingPoint = Offset(size.width / 2, size.height - shadowY);

      shadowFocusEndingPoint = Offset(shadowX, size.height - shadowY);

      Offset shadowDistanceStartingPoint =
          Offset(shadowX, size.height - shadowY);
      Offset shadowDistanceEndingPoint =
          Offset(size.width / 2, size.height - shadowY);

      // shadow object line
      shadowObjectStartingPoint = Offset(shadowX, size.height / 2);
      shadowObjectEndingPoint = Offset(shadowX, size.height - shadowY);

      // draw focus
      canvas.drawLine(focusStartingPoint, focusEndingPoint, focusPaint);

      //draw shadow focus
      canvas.drawLine(
          shadowFocusStartingPoint, shadowFocusEndingPoint, shadowFocusPaint);
      // draw shadow distance
      canvas.drawLine(shadowDistanceStartingPoint, shadowDistanceEndingPoint,
          shadowDistancePaint);

      // draw shadow object
      canvas.drawLine(shadowObjectStartingPoint, shadowObjectEndingPoint,
          shadowObjectPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
