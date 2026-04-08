import 'package:flutter/material.dart';
import 'package:issues_app/theme/app_theme.dart';

class SegmentedControl<T> extends StatefulWidget {
  final List<T> items;
  final T selectedValue;
  final Function(T) onChange;
  final Widget Function(T, bool isSelected) itemBuilder;
  final bool isFullWidth;

  const SegmentedControl({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.onChange,
    required this.itemBuilder,
    this.isFullWidth = false,
  });

  @override
  State<SegmentedControl<T>> createState() => _SegmentedControlState<T>();
}

class _SegmentedControlState<T> extends State<SegmentedControl<T>> {
  final Map<T, GlobalKey> _keys = {};

  @override
  void initState() {
    super.initState();
    _updateKeys();
  }

  @override
  void didUpdateWidget(covariant SegmentedControl<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.items != oldWidget.items) {
      _updateKeys();
    }
  }

  void _updateKeys() {
    for (var item in widget.items) {
      _keys[item] ??= GlobalKey();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.customColors.gray60,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: context.customColors.gray40!, width: 1),
      ),
      padding: const EdgeInsets.all(4),
      child: widget.isFullWidth
          ? LayoutBuilder(builder: _buildFullWidth)
          : _buildIntrinsicWidth(),
    );
  }

  Widget _buildFullWidth(BuildContext context, BoxConstraints constraints) {
    final int selectedIndex = widget.items.indexOf(widget.selectedValue);
    final double segmentWidth = constraints.maxWidth / widget.items.length;

    return Stack(
      children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          left: selectedIndex * segmentWidth,
          width: segmentWidth,
          top: 0,
          bottom: 0,
          child: _SelectionPainter(),
        ),
        Row(
          children: widget.items.map((item) {
            return Expanded(child: _buildItem(item));
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildIntrinsicWidth() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(() {});
    });

    final selectedRect = _getSelectedRect();

    return Stack(
      children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          left: selectedRect.left != 0 ? selectedRect.left - 4 : 0,
          width: selectedRect.width,
          top: 0,
          bottom: 0,
          child: _SelectionPainter(),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: widget.items.map(_buildItem).toList(),
        ),
      ],
    );
  }

  Widget _buildItem(T item) {
    final isSelected = item == widget.selectedValue;
    return GestureDetector(
      key: _keys[item],
      behavior: HitTestBehavior.opaque,
      onTap: () => widget.onChange(item),
      child: Center(child: widget.itemBuilder(item, isSelected)),
    );
  }

  Rect _getSelectedRect() {
    final key = _keys[widget.selectedValue];
    final RenderBox? renderBox =
        key?.currentContext?.findRenderObject() as RenderBox?;
    final RenderBox? containerBox = context.findRenderObject() as RenderBox?;

    if (renderBox == null || containerBox == null) return Rect.zero;

    final position = renderBox.localToGlobal(
      Offset.zero,
      ancestor: containerBox,
    );
    return Rect.fromLTWH(
      position.dx,
      position.dy,
      renderBox.size.width,
      renderBox.size.height,
    );
  }
}

class _SelectionPainter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 4),
        ],
      ),
    );
  }
}
