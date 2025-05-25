import 'package:flutter/material.dart';

import '../basic_features.dart';

enum MD2IndicatorSize {
  tiny,
  normal,
  full,
}

class MD2Indicator extends Decoration {
  final double indicatorHeight;
  final Color indicatorColor;
  final MD2IndicatorSize indicatorSize;

  const MD2Indicator(
      {required this.indicatorHeight,
      required this.indicatorColor,
      required this.indicatorSize});

  @override
  MD2Painter createBoxPainter([VoidCallback? onChanged]) {
    return MD2Painter(this, onChanged!);
  }
}

class MD2Painter extends BoxPainter {
  final MD2Indicator decoration;

  MD2Painter(this.decoration, VoidCallback onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);

    // Rect? rect;
    // if (decoration.indicatorSize == MD2IndicatorSize.full) {
    //   rect = Offset(offset.dx,
    //           (configuration.size!.height - decoration.indicatorHeight)) &
    //       Size(configuration.size!.width, decoration.indicatorHeight);
    // } else if (decoration.indicatorSize == MD2IndicatorSize.normal) {
    //   rect = Offset(offset.dx + 6,
    //           (configuration.size!.height - decoration.indicatorHeight)) &
    //       Size(configuration.size!.width - 12, decoration.indicatorHeight);
    // } else if (decoration.indicatorSize == MD2IndicatorSize.tiny) {
    //   rect = Offset(offset.dx + configuration.size!.width / 2 - 8,
    //           (configuration.size!.height - decoration.indicatorHeight)) &
    //       Size(16, decoration.indicatorHeight);
    // }

    final Paint paint = Paint();
    paint.color = decoration.indicatorColor;

    double cornerRadius = 5.0; // Adjust the radius to control the rounding

    RRect rRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        offset.dx + Dimensions.w20,
        configuration.size!.height - decoration.indicatorHeight - 3,
        configuration.size!.width - Dimensions.w40, // Width of the rectangle
        Dimensions.h4, // Height of the rectangle
      ),
      Radius.circular(cornerRadius), // Radius for rounding the corners
    );

    Path path = Path()..addRRect(rRect);

    Paint paintFill = Paint()..style = PaintingStyle.fill;
    paintFill.color = decoration.indicatorColor;
    paintFill.style = PaintingStyle.fill;
    canvas.drawPath(path, paintFill);
  }
}
