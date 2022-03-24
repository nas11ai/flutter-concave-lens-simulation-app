import 'package:flutter/material.dart';

class ObjectLine extends StatefulWidget {
  final double heightValue;
  final double distanceValue;
  final double shadowDistance;
  final double shadowHeight;
  final double focusValue;

  const ObjectLine({
    Key? key,
    required this.heightValue,
    required this.distanceValue,
    required this.shadowDistance,
    required this.shadowHeight,
    required this.focusValue,
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
        widget.focusValue,
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
  final double focusValue;

  ObjectLinePainter(
    this.heightValue,
    this.distanceValue,
    this.shadowDistance,
    this.shadowHeight,
    this.focusValue,
  );

  @override
  void paint(Canvas canvas, Size size) {
    var shadowX = (size.width / 2) - shadowDistance;
    var shadowY = (size.height / 2) + shadowHeight;
    var objectPaint = Paint()
      ..color = Colors.yellow
      ..strokeWidth = 30
      ..strokeCap = StrokeCap.butt;

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
      ..color = Colors.yellow[100]!
      ..strokeWidth = 30
      ..strokeCap = StrokeCap.butt;

    var firePaint = Paint()
      ..color = Colors.pink
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;

    var shadowFirePaint = Paint()
      ..color = Colors.pink[100]!
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;

    // var objWidth = 20;
    var objHeight = 40;

    // canvas.drawLine(Offset(distanceValue - objWidth, heightValue + objHeight),
    //     Offset(distanceValue - objWidth, size.height / 2), objectPaint);

    // canvas.drawLine(Offset(distanceValue + objWidth, heightValue + objHeight),
    //     Offset(distanceValue + objWidth, size.height / 2), objectPaint);

    // canvas.drawLine(Offset(distanceValue - objWidth, heightValue + objHeight),
    //     Offset(distanceValue + objWidth, heightValue + objHeight), objectPaint);

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

    // canvas.drawLine(Offset(distanceValue, heightValue),
    //     Offset(-size.width / 2, -shadowY), focusPaint);

    if (heightValue < (size.height / 2) - objHeight) {
      // draw distance
      canvas.drawLine(
          distanceStartingPoint, distanceEndingPoint, distancePaint);

      // draw focus
      canvas.drawLine(focusStartingPoint, focusEndingPoint, focusPaint);

      // draw shadow focus
      canvas.drawLine(
          shadowFocusStartingPoint, shadowFocusEndingPoint, shadowFocusPaint);

      // draw shadow distance
      canvas.drawLine(shadowDistanceStartingPoint, shadowDistanceEndingPoint,
          shadowDistancePaint);

      // draw object
      canvas.drawLine(objectStartingPoint, objectEndingPoint, objectPaint);

      canvas.drawOval(
          Offset(distanceValue - 15, heightValue - objHeight) &
              const Size(30.0, 40.0),
          firePaint);

      // draw shadow object
      canvas.drawLine(shadowObjectStartingPoint, shadowObjectEndingPoint,
          shadowObjectPaint);

      if (focusValue > 0) {
        if (shadowDistance > 0) {
          canvas.drawOval(
              Offset(shadowX - 15, shadowY) & const Size(30.0, 40.0),
              shadowFirePaint);
        } else {
          canvas.drawOval(
              Offset(shadowX - 15, shadowY - objHeight) &
                  const Size(30.0, 40.0),
              shadowFirePaint);
        }
      }
    } else if (heightValue > (size.height / 2) + objHeight) {
      // draw object
      canvas.drawLine(objectStartingPoint, objectEndingPoint, objectPaint);
      focusEndingPoint = Offset(size.width / 2, size.height - shadowY);

      shadowFocusEndingPoint = Offset(shadowX, size.height - shadowY);

      Offset shadowDistanceStartingPoint =
          Offset(shadowX, size.height - shadowY);
      Offset shadowDistanceEndingPoint =
          Offset(size.width / 2, size.height - shadowY);

      // shadow object line
      Offset shadowObjectStartingPoint = Offset(shadowX, size.height / 2);
      Offset shadowObjectEndingPoint = Offset(shadowX, shadowY + objHeight);

      // shadow object line
      shadowObjectStartingPoint = Offset(shadowX, size.height / 2);
      shadowObjectEndingPoint = Offset(shadowX, size.height - shadowY);

      canvas.drawOval(
          Offset(distanceValue - 15, heightValue) & const Size(30.0, 40.0),
          firePaint);

      if (focusValue > 0) {
        canvas.drawOval(
            Offset(shadowX - 15, size.height - shadowY - objHeight) &
                const Size(30.0, 40.0),
            shadowFirePaint);
      }

      // draw distance
      canvas.drawLine(
          distanceStartingPoint, distanceEndingPoint, distancePaint);

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
