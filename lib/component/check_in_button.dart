import 'package:flutter/material.dart';

class CheckInButton extends StatelessWidget {
  final bool checkIn;

  CheckInButton({required this.checkIn});

  @override
  Widget build(BuildContext context) {
    Color iconColor = checkIn ? Colors.green : Colors.red;

    return Center(
        child: Container(
          width: 150,
          height: 150,
          child: CustomPaint(
            painter: CirclePainter(checkIn: checkIn),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 20,),
                  Icon(
                    Icons.front_hand_outlined,
                    color: iconColor,
                    size: 40,
                  ),
                  SizedBox(height: 25),
                  Text(
                    'Please Press Here',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Check ' + (checkIn ? 'In' : 'Out'),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  }
}


class CirclePainter extends CustomPainter {
  final bool checkIn;

  CirclePainter({required this.checkIn});

  @override
  void paint(Canvas canvas, Size size) {
    Color iconColor = checkIn ? Colors.green : Colors.red;

    Paint whitePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Paint colorPaint = Paint()
      ..color = iconColor
      ..style = PaintingStyle.fill;

    Paint borderPaint = Paint()
      ..color = iconColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0;

    // Draw the upper half with white color
    canvas.drawArc(
      Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: size.width / 2),
      0, // Start angle (in radians)
      -3.1416, // Sweep angle (in radians)
      true,
      whitePaint,
    );

    // Draw the lower half with red color
    canvas.drawArc(
      Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: size.width / 2),
      0, // Start angle (in radians)
      3.1416, // Sweep angle (in radians)
      true,
      colorPaint,
    );

    // Draw the red border around the circle
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), size.width / 2, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}