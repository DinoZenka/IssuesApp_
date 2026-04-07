import 'package:flutter/material.dart';
import 'package:issues_app/theme/app_theme.dart';

class SegmentedControl<T> extends StatefulWidget {
  final List<T> items;
  final T selectedValue;
  final Function(T) onChange;
  final Widget Function(T, bool isSelected) itemBuilder;

  const SegmentedControl({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.onChange,
    required this.itemBuilder,
  });

  @override
  State<SegmentedControl<T>> createState() => _SegmentedControlState<T>();
}

class _SegmentedControlState<T> extends State<SegmentedControl<T>> {
  final Map<T, GlobalKey> _keys = {};

  @override
  void initState() {
    super.initState();
    for (var item in widget.items) {
      _keys[item] = GlobalKey();
    }
  }

  Rect _getSelectedRect() {
    final key = _keys[widget.selectedValue];
    if (key == null || key.currentContext == null) return Rect.zero;

    final renderBox = key.currentContext!.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(
      Offset.zero,
      ancestor: context.findRenderObject(),
    );

    return Rect.fromLTWH(
      position.dx,
      position.dy,
      renderBox.size.width,
      renderBox.size.height,
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedRect = _getSelectedRect();

    return Container(
      decoration: BoxDecoration(
        color: context.customColors.gray60,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: context.customColors.gray40!, width: 1),
      ),
      padding: const EdgeInsets.all(4),
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            left: selectedRect.left - 4,
            width: selectedRect.width,
            top: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainer,
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 4,
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: widget.items.map((item) {
              final isSelected = item == widget.selectedValue;
              return GestureDetector(
                key: _keys[item],
                behavior: HitTestBehavior.opaque,
                onTap: () => widget.onChange(item),
                child: widget.itemBuilder(item, isSelected),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
