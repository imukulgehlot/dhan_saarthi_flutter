import 'package:dhan_saarthi/core/theme/color_scheme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../basic_features.dart';

class MyTextField extends StatelessWidget {
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  final double? height;
  final double? borderRadius;
  final String? currentCountryCode;
  final Function(String? countryCode, String? dialCode)? getCountryCode;
  final int? minLines;
  final Widget? suffixIcon;
  final String? title;
  final EdgeInsets? contentPadding;
  final TextEditingController? textController;
  final Color? hintTextColor;
  final FocusNode? focusNode;
  final bool showFocusedBorder;
  final TextInputAction? textInputAction;
  final int? maxLine, maxLength;
  final TextInputType? textInputType;
  final bool obscureText;
  final bool autoFocus;
  final bool? isEnabled;
  final bool readOnly;
  final Function(String)? onChanged;
  final Function? onTap;
  final ValueChanged<String>? onFieldSubmitted;
  final String? hintText;
  final Widget? prefixIcon;
  final TextStyle? textStyle;
  final TextStyle? hintTextStyle;
  final Color? textFieldColor;
  final Color? textFieldBorderColor;
  final double? iconBottomPadding;
  final double? titleTopPadding;

  // final EdgeInsets? padding;

  const MyTextField({
    super.key,
    this.readOnly = false,
    this.textCapitalization = TextCapitalization.sentences,
    this.inputFormatters,
    this.isEnabled,
    this.height,
    this.textInputAction,
    this.focusNode,
    this.maxLine,
    this.onTap,
    this.maxLength,
    this.textInputType,
    this.title,
    this.obscureText = false,
    this.textController,
    this.hintTextColor,
    this.suffixIcon,
    this.onChanged,
    this.borderRadius,
    this.textStyle,
    this.hintTextStyle,
    this.hintText,
    this.autoFocus = false,
    this.prefixIcon,
    this.textFieldColor,
    this.textFieldBorderColor,
    this.iconBottomPadding,
    // this.padding,
    this.onFieldSubmitted,
    this.titleTopPadding,
    this.showFocusedBorder = true,
    this.contentPadding,
    this.minLines,
    this.getCountryCode,
    this.currentCountryCode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (title != null)
          // Title
          Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding:
                      EdgeInsets.only(top: titleTopPadding ?? Dimensions.h10),
                  child: Text(title!,
                      textAlign: TextAlign.center, style: fontStyleMedium14),
                ),
              ),
              SizedBox(
                height: Dimensions.h10,
              )
            ],
          ),

        // Text Field
        GestureDetector(
          onTap: onTap as void Function()?,
          child: SizedBox(
            height: height ?? Dimensions.commonButtonHeight,
            // padding: padding ?? EdgeInsets.zero,
            child: Center(
              child: TextFormField(
                  maxLength: maxLength,
                  autofocus: autoFocus,
                  minLines: minLines,
                  enabled: isEnabled,
                  maxLines: obscureText || maxLine == null ? 1 : maxLine,
                  obscureText: obscureText,
                  focusNode: focusNode,
                  inputFormatters: textInputType == TextInputType.phone
                      ? [AppUtils.inputFormatter.number]
                      : [],
                  textCapitalization:
                      textInputType != TextInputType.emailAddress
                          ? textCapitalization
                          : TextCapitalization.none,
                  textAlignVertical: TextAlignVertical.center,
                  obscuringCharacter: '•',
                  style: textStyle ??
                      fontStyleRegular15.apply(
                          color: Theme.of(context).colorScheme.textColor),
                  cursorColor: AppColors.primaryColor,
                  // textAlign: textAlign ?? TextAlign.start,
                  onFieldSubmitted: onFieldSubmitted,
                  controller: textController,
                  // inputFormatters: widget.inputFormatters,
                  decoration: InputDecoration(
                    counterText: '',
                    contentPadding: contentPadding ??
                        EdgeInsets.symmetric(vertical: Dimensions.h13),
                    // labelText: widget.showLabelText ? widget.hintText : null,
                    hintStyle: hintTextStyle ??
                        fontStyleLight14.copyWith(
                            color: Get.theme.colorScheme.hintTextColor),
                    isDense: true,
                    prefixIconConstraints:
                        const BoxConstraints(minHeight: 0, minWidth: 0),
                    suffixIconConstraints:
                        const BoxConstraints(minHeight: 0, minWidth: 0),
                    focusedBorder: showFocusedBorder
                        ? OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              borderRadius ?? Dimensions.commonRadius,
                            ),
                            borderSide: BorderSide(
                              width: Dimensions.w2,
                              color: AppColors.textFieldBorderColor,
                            ),
                          )
                        : null,

                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        borderRadius ?? Dimensions.commonRadius,
                      ),
                      borderSide: BorderSide(
                        width: Dimensions.commonBorderWidth,
                        color: AppColors.borderColor,
                      ),
                    ),
                    fillColor: textFieldColor ?? AppColors.textFieldColor,
                    filled: true,
                    hintText: hintText ?? "",
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(
                        left: Dimensions.w12,
                        right: Dimensions.w5,
                      ),
                      child: prefixIcon,
                    ),
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(
                          left: Dimensions.w6, right: Dimensions.w8),
                      child: suffixIcon,
                    ),
                    // )),
                  ),
                  onChanged: onChanged,
                  onSaved: (value) {},
                  textInputAction: textInputAction ?? TextInputAction.next,
                  keyboardType: textInputType),
            ),
          ),
        ),
      ],
    );
  }
}
