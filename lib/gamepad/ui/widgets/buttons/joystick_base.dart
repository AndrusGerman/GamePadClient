import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';

class JoystickBaseGamePad extends StatelessWidget {
  final JoystickMode mode;
  final double size;

  const JoystickBaseGamePad({
    required this.size,
    this.mode = JoystickMode.all,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.circle,
      ),
      child: CustomPaint(
        painter: _JoystickBasePainter(mode),
      ),
    );
  }
}

class _JoystickBasePainter extends CustomPainter {
  _JoystickBasePainter(this.mode);

  final JoystickMode mode;

  final _borderPaint = Paint()
    ..color = const Color(0x50616161)
    ..strokeWidth = 10
    ..style = PaintingStyle.stroke;
  final _centerPaint = Paint()
    ..color = const Color(0x50616161)
    ..style = PaintingStyle.fill;
  final _linePaint = Paint()
    ..color = const Color(0x50616161)
    ..strokeWidth = 5
    ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.width / 2);
    final radius = size.width / 2;
    canvas.drawCircle(center, radius, _borderPaint);
    canvas.drawCircle(center, radius - 12, _centerPaint);
    canvas.drawCircle(center, radius - 40, _centerPaint);

    if (mode != JoystickMode.horizontal) {
      // draw vertical arrows
      canvas.drawLine(Offset(center.dx - 10, center.dy - 50),
          Offset(center.dx, center.dy - 50), _linePaint);
      canvas.drawLine(Offset(center.dx + 10, center.dy - 50),
          Offset(center.dx, center.dy - 50), _linePaint);
      canvas.drawLine(Offset(center.dx - 10, center.dy + 50),
          Offset(center.dx, center.dy + 50), _linePaint);
      canvas.drawLine(Offset(center.dx + 10, center.dy + 50),
          Offset(center.dx, center.dy + 50), _linePaint);
    }

    if (mode != JoystickMode.vertical) {
      // draw horizontal arrows
      canvas.drawLine(Offset(center.dx - 50, center.dy - 10),
          Offset(center.dx - 50, center.dy), _linePaint);
      canvas.drawLine(Offset(center.dx - 50, center.dy + 10),
          Offset(center.dx - 50, center.dy), _linePaint);
      canvas.drawLine(Offset(center.dx + 50, center.dy - 10),
          Offset(center.dx + 50, center.dy), _linePaint);
      canvas.drawLine(Offset(center.dx + 50, center.dy + 10),
          Offset(center.dx + 50, center.dy), _linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
