import 'package:flutter/material.dart';

import '../basic_features.dart';
import 'custom_image.dart';

class ExpansionRow extends StatefulWidget {
  final String title;
  final Widget expandedWidget;

  const ExpansionRow(
      {super.key, required this.title, required this.expandedWidget});

  @override
  State<ExpansionRow> createState() => _ExpansionFaqRowFaqRowState();
}

class _ExpansionFaqRowFaqRowState extends State<ExpansionRow>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  bool showAddIcon = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 350), vsync: this);
    _animation = Tween(begin: 0.0, end: .5)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.primaryColor,
                width: Dimensions.w2,
              ),
              borderRadius: BorderRadius.circular(Dimensions.r10),
            ),
            child: ExpansionTile(
              onExpansionChanged: (value) {
                setState(() {
                  value ? _controller.forward() : _controller.reverse();
                  showAddIcon = value;
                });
              },
              initiallyExpanded: false,
              title: Padding(
                padding: EdgeInsets.only(
                  // top: Dimensions.commonPaddingForScreen,
                  left: Dimensions.w8,
                  // bottom: Dimensions.commonPaddingForScreen
                ),
                child: Text(
                  widget.title,
                  style: fontStyleSemiBold18.copyWith(
                      color: AppColors.primaryColor),
                ),
              ),
              trailing: Padding(
                padding: EdgeInsets.only(right: Dimensions.w3),
                child: RotationTransition(
                  turns: _animation,
                  child: CustomSvgAssetImage(
                    image: !showAddIcon ? AppImages.icPlus : AppImages.icMinus,
                    width: Dimensions.w30,
                  ),
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimensions.r10)),
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(
                      Dimensions.r8,
                    ),
                    bottomLeft: Radius.circular(
                      Dimensions.r8,
                    ),
                  ),
                  child: SizedBox(
                      width: double.infinity, child: widget.expandedWidget),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
