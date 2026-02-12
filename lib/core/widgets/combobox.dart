import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:spray/core/extensions/app_extensions.dart';
import 'package:spray/theme/app_colors.dart';

class ComboBox extends StatelessWidget {
  final String hint;
  final String? value;
  final String? label;
  final List<String> dropdownItems;
  final ValueChanged<String?>? onChanged;
  final DropdownButtonBuilder? selectedItemBuilder;
  final Alignment? hintAlignment;
  final Alignment? valueAlignment;
  final double? buttonHeight, buttonWidth;
  final EdgeInsetsGeometry? buttonPadding;
  final BoxDecoration? buttonDecoration;
  final int? buttonElevation;
  final BorderRadiusGeometry? radius;
  final Widget? icon;
  final double? iconSize;
  final Color? iconEnabledColor;
  final Color? iconDisabledColor;
  final double? itemHeight;
  final EdgeInsetsGeometry? itemPadding;
  final double? dropdownHeight, dropdownWidth;
  final EdgeInsetsGeometry? dropdownPadding;
  final BoxDecoration? dropdownDecoration;
  final int? dropdownElevation;
  final Radius? scrollbarRadius;
  final double? scrollbarThickness;
  final bool? scrollbarAlwaysShow;
  final Offset offset;
  final bool noDecoration;

  const ComboBox({
    required this.hint,
    required this.value,
    required this.dropdownItems,
    required this.onChanged,
    this.label,
    this.radius,
    this.noDecoration = false,
    this.selectedItemBuilder,
    this.hintAlignment,
    this.valueAlignment,
    this.buttonHeight,
    this.buttonWidth,
    this.buttonPadding,
    this.buttonDecoration,
    this.buttonElevation,
    this.icon,
    this.iconSize,
    this.iconEnabledColor,
    this.iconDisabledColor,
    this.itemHeight,
    this.itemPadding,
    this.dropdownHeight,
    this.dropdownWidth,
    this.dropdownPadding,
    this.dropdownDecoration,
    this.dropdownElevation,
    this.scrollbarRadius,
    this.scrollbarThickness,
    this.scrollbarAlwaysShow,
    this.offset = Offset.zero,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null)
          Text(
            label!,
            style: context.textTheme.labelSmall?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,
            hint: Container(
              alignment: hintAlignment,
              child: Text(
                hint,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: context.textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 14
                ),
              ),
            ),
            value: value,
            items: dropdownItems
                .map(
                  (String item) => DropdownMenuItem<String>(
                value: item,
                child: Container(
                  alignment: valueAlignment,
                  child: Text(
                    item,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: AppColors.textDark,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            )
                .toList(),
            onChanged: onChanged,
            selectedItemBuilder: selectedItemBuilder,
            buttonStyleData: ButtonStyleData(
              height:
              (noDecoration) ? null : buttonHeight ?? kMinInteractiveDimension,
              width: (noDecoration) ? null : buttonWidth ?? 375,
              padding: (noDecoration)
                  ? null
                  : buttonPadding ?? EdgeInsets.symmetric(horizontal: 15),
              decoration: (noDecoration)
                  ? null
                  : buttonDecoration ??
                  BoxDecoration(
                    borderRadius: radius ?? BorderRadius.circular(10),
                    border: Border.all(color: AppColors.borderLight),
                    color: Colors.transparent,
                  ),
              elevation: buttonElevation,
            ),
            iconStyleData: IconStyleData(
              icon: icon ?? const Icon(Icons.keyboard_arrow_down_rounded),
              iconSize: iconSize ?? 26,
              iconEnabledColor: iconEnabledColor,
              iconDisabledColor: iconDisabledColor,
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: dropdownHeight ?? 200,
              width: dropdownWidth ?? 335,
              padding: dropdownPadding,
              decoration: dropdownDecoration ??
                  BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
              elevation: dropdownElevation ?? 8,
              offset: offset,
              scrollbarTheme: ScrollbarThemeData(
                radius: scrollbarRadius ?? const Radius.circular(40),
                thickness: scrollbarThickness != null
                    ? WidgetStateProperty.all<double>(scrollbarThickness!)
                    : null,
                thumbVisibility: scrollbarAlwaysShow != null
                    ? WidgetStateProperty.all<bool>(scrollbarAlwaysShow!)
                    : null,
              ),
            ),
            menuItemStyleData: MenuItemStyleData(
              height: itemHeight ?? 40,
              padding: itemPadding ?? const EdgeInsets.only(left: 14, right: 14),
            ),
          ),
        ),
      ],
    );
  }
}
