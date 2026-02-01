import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:spray/core/extensions/app_extensions.dart';
import 'package:spray/theme/app_colors.dart';

export 'package:flutter/services.dart' show LengthLimitingTextInputFormatter;

class CommaInputFormatter extends TextInputFormatter {
  final NumberFormat formatter = NumberFormat.decimalPattern();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final digitsOnly = newValue.text.replaceAll(RegExp(r'[^\d]'), '');

    final formatted = formatter.format(int.parse(digitsOnly));

    final selectionIndex =
        formatted.length - (oldValue.text.length - oldValue.selection.end);

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(
        offset: selectionIndex.clamp(0, formatted.length),
      ),
    );
  }
}

class CustomTextField extends StatefulWidget {
  final Widget? prefix;
  final Widget? suffix;
  final double? prefixWidth;
  final double? suffixWidth;
  final String? hint;
  final Color? fillColor;
  final Color? borderColor;
  final EdgeInsets? padding;
  final bool obscure;
  final bool autoValidate;
  final FocusNode? focus;
  final bool autoFocus;
  final Function? onChange;
  final Function? onActionPressed;
  final Function? onValidate;
  final Function? onSave;
  final BorderRadius? radius;
  final TextEditingController controller;
  final TextInputType type;
  final TextInputAction action;
  final TextStyle? hintStyle;
  final bool readOnly;
  final bool disableFocusedBorder;
  final Color? disabledFocusedBorderColor;
  final int maxLines;
  final int? maxCharacters;
  final double? width;
  final List<TextInputFormatter> formatters;
  final String? label;
  final TextStyle? style;

  const CustomTextField({
    super.key,
    required this.controller,
    this.formatters = const [],
    this.style,
    this.width,
    this.fillColor,
    this.borderColor,
    this.padding,
    this.hintStyle,
    this.disableFocusedBorder = false,
    this.disabledFocusedBorderColor,
    this.focus,
    this.autoFocus = false,
    this.readOnly = false,
    this.obscure = false,
    this.autoValidate = false,
    this.type = TextInputType.text,
    this.action = TextInputAction.next,
    this.onActionPressed,
    this.onChange,
    this.onValidate,
    this.onSave,
    this.radius,
    this.hint,
    this.prefix,
    this.suffix,
    this.label,
    this.prefixWidth,
    this.suffixWidth,
    this.maxLines = 1,
    this.maxCharacters,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  int count = 0, limit = 0;

  @override
  void initState() {
    super.initState();
    if (widget.maxCharacters != null) {
      limit = widget.maxCharacters!;
    }

    widget.controller.addListener(onType);
  }

  void onType() {
    if (limit != 0) {
      count = widget.controller.text.length;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null)
          Text(
            widget.label!,
            style: context.textTheme.labelSmall?.copyWith(
              color: AppColors.textSecondary,
              letterSpacing: -0.3,
              fontWeight: FontWeight.w500,
            ),
          ),
        SizedBox(
          width: widget.width,
          child: TextFormField(
            autovalidateMode: widget.autoValidate
                ? AutovalidateMode.always
                : AutovalidateMode.disabled,
            maxLines: widget.maxLines,
            inputFormatters: [
              ...widget.formatters,
              if (widget.maxCharacters != null)
                LengthLimitingTextInputFormatter(widget.maxCharacters),
            ],
            focusNode: widget.focus,
            autofocus: widget.autoFocus,
            controller: widget.controller,
            obscureText: widget.obscure,
            keyboardType: widget.type,
            textInputAction: widget.action,
            readOnly: widget.readOnly,
            onEditingComplete: () {
              if (widget.onActionPressed != null) {
                widget.onActionPressed!(widget.controller.text);
              } else {
                FocusScope.of(context).nextFocus();
              }
            },
            cursorColor: AppColors.brandPrimary,
            style:
                widget.style ??
                context.textTheme.bodyMedium?.copyWith(
                  color: AppColors.surfaceDark,
                ),
            decoration: InputDecoration(
              errorMaxLines: 1,
              errorStyle: context.textTheme.bodyMedium?.copyWith(
                color: Colors.red,
              ),
              fillColor: widget.fillColor ?? AppColors.surfaceBackground,
              filled: true,
              contentPadding:
                  widget.padding ??
                  EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: widget.maxLines == 1 ? 5 : 15,
                  ),
              prefixIcon: widget.prefix != null
                  ? SizedBox(
                      height: kMinInteractiveDimension,
                      width: widget.prefixWidth ?? kMinInteractiveDimension,
                      child: Center(child: widget.prefix),
                    )
                  : null,
              suffixIcon: widget.suffix != null
                  ? SizedBox(
                      height: kMinInteractiveDimension,
                      width: widget.suffixWidth ?? kMinInteractiveDimension,
                      child: Center(child: widget.suffix),
                    )
                  : null,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: widget.disableFocusedBorder
                      ? widget.disabledFocusedBorderColor!
                      : widget.borderColor ?? AppColors.brandPrimary,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: widget.borderColor ?? AppColors.borderLight,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: widget.borderColor ?? AppColors.borderLight,
                ),
              ),
              hintText: widget.hint,
              hintStyle:
                  widget.hintStyle ??
                  context.textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 14
                  ),
            ),
            onChanged: (value) {
              if (widget.onChange == null) return;
              widget.onChange!(value);
            },
            validator: (value) {
              if (widget.onValidate == null) return null;
              return widget.onValidate!(value);
            },
            onSaved: (value) {
              if (widget.onSave == null) return;
              widget.onSave!(value);
            },
          ),
        ),
      ],
    );
  }
}
