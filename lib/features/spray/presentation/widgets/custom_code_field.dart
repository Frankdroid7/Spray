import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spray/core/extensions/app_extensions.dart';
import 'package:spray/theme/app_colors.dart';

class CustomCodeField extends StatefulWidget {
  final int fields;
  final void Function(String) onComplete;

  const CustomCodeField({
    super.key,
    required this.fields,
    required this.onComplete,
  });

  @override
  State<CustomCodeField> createState() => _CustomCodeFieldState();
}

class _CustomCodeFieldState extends State<CustomCodeField> {
  late List<TextEditingController> controllers;
  late List<FocusNode> nodes;

  @override
  void initState() {
    super.initState();
    controllers = List.generate(
      widget.fields,
      (_) => TextEditingController(),
    );
    nodes = List.generate(widget.fields, (i) {
      return FocusNode(
        onKeyEvent: (_, event) => _handleKeyEvent(i, event),
      );
    });

    for (int i = 0; i < widget.fields; ++i) {
      controllers[i].addListener(() => _onTextChanged(i));
    }
  }

  @override
  void dispose() {
    for (TextEditingController controller in controllers) {
      controller.dispose();
    }

    for (FocusNode node in nodes) {
      node.dispose();
    }

    super.dispose();
  }

  void _onTextChanged(int index) {
    String text = controllers[index].text.trim();
    if (text.length == 1) {
      if (index == widget.fields - 1) {
        nodes[index].unfocus();
      } else {
        _focusAndSelect(index + 1);
      }
    }
  }

  void _focusAndSelect(int index) {
    nodes[index].requestFocus();
    final controller = controllers[index];
    if (controller.text.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.selection = TextSelection(
          baseOffset: 0,
          extentOffset: controller.text.length,
        );
      });
    }
  }

  KeyEventResult _handleKeyEvent(int index, KeyEvent event) {
    if (event is! KeyDownEvent) return KeyEventResult.ignored;

    if (event.logicalKey == LogicalKeyboardKey.backspace) {
      final controller = controllers[index];
      if (controller.text.isNotEmpty) {
        controller.clear();
      }
      if (index > 0) {
        nodes[index - 1].requestFocus();
      }
      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(widget.fields, (i) {
          return SizedBox(
            width: 40,
            child: TextField(
              controller: controllers[i],
              focusNode: nodes[i],
              keyboardType: TextInputType.number,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
              textAlign: TextAlign.center,
              style: context.textTheme.bodyLarge?.copyWith(
                color: AppColors.textDark,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "–",
                hintStyle: context.textTheme.bodyLarge?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
