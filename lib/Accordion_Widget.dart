library accordion_widget;

import 'package:flutter/material.dart';

class AccordionWidget extends StatefulWidget {
  final Widget header;
  final Widget content;
  final bool isInitiallyExpanded;
  final bool isToggleable;
  final Duration animationDuration;
  final bool showIcon;
  final Decoration? decoration;
  final EdgeInsetsGeometry? padding;
  final Curve animationCurve;

  const AccordionWidget({
    required this.header,
    required this.content,
    this.isInitiallyExpanded = false,
    this.isToggleable = true,
    this.animationDuration = const Duration(milliseconds: 300),
    this.decoration,
    this.showIcon = true,
    this.padding,
    this.animationCurve = Curves.easeInOut,
  });

  @override
  _AccordionWidgetState createState() => _AccordionWidgetState();
}

class _AccordionWidgetState extends State<AccordionWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _heightFactor;
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.isInitiallyExpanded;

    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _heightFactor = CurvedAnimation(
      parent: _controller,
      curve: widget.animationCurve,
    );

    if (_isExpanded) {
      _controller.value = 1.0;
    }
  }

  void _toggleExpansion() {
    if (!widget.isToggleable) return;

    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding ?? EdgeInsets.zero,
      width: double.infinity,
      decoration:
          (widget.decoration is BoxDecoration
              ? (widget.decoration as BoxDecoration).copyWith(
                color:
                    (widget.decoration as BoxDecoration).color ??
                    Theme.of(context).cardColor,
              )
              : widget.decoration) ??
          BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black12.withOpacity(0.1),
                blurRadius: 4,
                spreadRadius: 1,
              ),
            ],
          ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: widget.isToggleable ? _toggleExpansion : null,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: widget.header),
                if (widget.showIcon)
                  AnimatedRotation(
                    turns: _isExpanded ? 0.5 : 0,
                    duration: widget.animationDuration,
                    child: Icon(Icons.expand_more, size: 24),
                  ),
              ],
            ),
          ),
          SizeTransition(
            sizeFactor: _heightFactor,
            axisAlignment: -1.0,
            child: widget.content,
          ),
        ],
      ),
    );
  }
}
