import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../basic_features.dart';
import '../../custom_image.dart';
import '../../custom_text_widget.dart';

// import '../../core/utils/custom_text_style.dart';
// import '../../core/tabs/custom_text_widget.dart';

class SearchBarTextBoxField extends StatefulWidget {
  final List<TextInputFormatter>? inputFormatters;
  final double? height;
  final bool isRequiredField;
  final bool? autoFocus;
  final Widget? suffixIcon;
  final double? hintFontSize;
  final Widget? prefixIcon;
  final String? title;
  final String? headerText;
  final TextEditingController textController;
  final Color? hintTextColor;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final TextInputType? inputType;
  final TextAlign? textAlign;
  final int? maxLine, maxLength;
  final double? borderRadius;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final bool? isReadOnly;
  final Color? bgColor;
  final bool showLabelText;
  final Function(String) onChanged;
  final Function() afterClearButton;
  final ValueChanged? onFieldSubmit;
  final FormFieldValidator? validator;
  final String? hintText;
  final Function? onTap;

  const SearchBarTextBoxField(
      {super.key,
      this.inputFormatters,
      this.height,
      this.focusNode,
      this.maxLine,
      this.textAlign = TextAlign.start,
      this.maxLength,
      this.borderRadius,
      this.keyboardType,
      this.title,
      this.headerText,
      this.validator,
      this.obscureText = false,
      required this.textController,
      this.onFieldSubmit,
      this.bgColor,
      this.isReadOnly = false,
      this.showLabelText = false,
      this.hintTextColor,
      this.suffixIcon,
      this.prefixIcon,
      required this.onChanged,
      this.textInputAction,
      this.hintText,
      this.onTap,
      this.inputType,
      this.isRequiredField = false,
      required this.afterClearButton,
      this.autoFocus,
      this.hintFontSize});

  @override
  State<SearchBarTextBoxField> createState() => _SearchBarTextBoxFieldState();
}

class _SearchBarTextBoxFieldState extends State<SearchBarTextBoxField> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        children: [
          widget.headerText != null
              ? Padding(
                  padding: EdgeInsets.symmetric(vertical: Dimensions.h5),
                  child: Row(
                    children: [
                      CustomTextWidget.medium18(
                        text: widget.headerText.toString(),
                        color: AppColors.blackColor,
                      ),
                      if (widget.isRequiredField)
                        CustomTextWidget.medium18(
                          text: ' *',
                          color: Colors.red,
                        ),
                    ],
                  ),
                )
              : const SizedBox(),
          Container(
            height: widget.height ?? Dimensions.commonButtonHeight,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: AppColors.appNameBlackColor.withValues(alpha: 0.1),
                    blurRadius: 25,
                    spreadRadius: 0)
              ],
              borderRadius: BorderRadius.circular(
                  widget.borderRadius ?? Dimensions.commonRadius),
              color: widget.bgColor ?? AppColors.textFieldColor,
            ),
            child: TextFormField(
                enabled: !widget.isReadOnly!,
                autofocus: widget.autoFocus ?? false,
                obscureText: false,
                focusNode: widget.focusNode,
                textCapitalization: TextCapitalization.none,
                textAlignVertical: TextAlignVertical.center,
                style: fontStyleRegular17,
                cursorColor: AppColors.primaryColor,
                textAlign: widget.textAlign ?? TextAlign.start,
                onFieldSubmitted: widget.onFieldSubmit,
                controller: widget.textController,
                inputFormatters: widget.inputFormatters,
                decoration: InputDecoration(
                    labelText: widget.showLabelText ? widget.hintText : null,
                    isDense: true,
                    prefixIconConstraints:
                        BoxConstraints(minHeight: 0, minWidth: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          widget.borderRadius ?? Dimensions.commonRadius),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    labelStyle: fontStyleRegular15,
                    fillColor: widget.bgColor ?? AppColors.textFieldColor,
                    filled: true,
                    hintText: widget.hintText ?? "",
                    hintStyle: fontStyleRegular15.copyWith(
                        color: AppColors.hintColor,
                        fontSize: widget.hintFontSize),
                    prefixIcon: widget.prefixIcon ??
                        Padding(
                          padding: EdgeInsets.only(
                              right: Dimensions.w5,
                              left: Dimensions.w10,
                              top: Dimensions.w10,
                              bottom: Dimensions.w10),
                          child: Icon(
                            CupertinoIcons.calendar,
                            color: AppColors.blackColor,
                            size: Dimensions.w16,
                          ),
                        ),
                    suffixIconConstraints: BoxConstraints(
                        minHeight:
                            widget.height ?? Dimensions.commonButtonHeight,
                        minWidth: 0),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        if (widget.textController.text.isNotEmpty) {
                          setState(() => widget.textController.clear());
                          widget.afterClearButton.call();
                        }
                      },
                      child: widget.suffixIcon ??
                          Padding(
                            padding: EdgeInsets.only(
                                right: Dimensions.w10,
                                left: Dimensions.w10,
                                top: Dimensions.w10,
                                bottom: Dimensions.w10),
                            child: widget.textController.text.isNotEmpty
                                ? CustomSvgAssetImage(
                                    image: AppImages.icCancel,
                                    height: Dimensions.w20,
                                    width: Dimensions.w20,
                                  )
                                : const SizedBox(),
                          ),
                    )),
                onChanged: (val) {
                  widget.onChanged(val);
                  setState(() {});
                },
                onSaved: (value) {
                  value = widget.textController.text;
                },
                onTap: () {
                  widget.onTap?.call();
                },
                textInputAction: TextInputAction.search,
                keyboardType: TextInputType.text),
          ),
        ],
      ),
    );
  }
}
