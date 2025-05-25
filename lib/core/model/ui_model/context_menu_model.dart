import 'package:flutter/material.dart';

class ContextMenuModel {
  String title;
  final String svgIcon;
  final Color? svgColor;
  final Color? textColor;
  final double? svgSize;
  final Function onTap;

  ContextMenuModel({
    required this.title,
    required this.svgIcon,
    required this.onTap,
    this.svgColor,
    this.svgSize,
    this.textColor,
  });
}
