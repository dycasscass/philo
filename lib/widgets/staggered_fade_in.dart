import 'dart:async';
import 'package:flutter/material.dart';

/// Displays a list of children with staggered fade-in animation.
///
/// When [show] becomes true, children appear one by one with a delay
/// of [staggerDelay] between each. Each child fades in over [fadeDuration].
///
/// Children are NOT interactive until their fade-in has completed.
class StaggeredFadeIn extends StatefulWidget {
  final List<Widget> children;
  final Duration staggerDelay;
  final Duration fadeDuration;
  final bool show;

  const StaggeredFadeIn({
    super.key,
    required this.children,
    this.show = true,
    this.staggerDelay = const Duration(milliseconds: 200),
    this.fadeDuration = const Duration(milliseconds: 400),
  });

  @override
  State<StaggeredFadeIn> createState() => _StaggeredFadeInState();
}

class _StaggeredFadeInState extends State<StaggeredFadeIn> {
  int _visibleCount = 0;
  final List<Timer> _timers = [];

  @override
  void initState() {
    super.initState();
    if (widget.show) _startStagger();
  }

  @override
  void didUpdateWidget(StaggeredFadeIn oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.show && !oldWidget.show) {
      _startStagger();
    } else if (!widget.show && oldWidget.show) {
      _cancelTimers();
      setState(() => _visibleCount = 0);
    }
  }

  void _startStagger() {
    _cancelTimers();
    for (int i = 0; i < widget.children.length; i++) {
      final timer = Timer(widget.staggerDelay * i, () {
        if (mounted) setState(() => _visibleCount = i + 1);
      });
      _timers.add(timer);
    }
  }

  void _cancelTimers() {
    for (final t in _timers) {
      t.cancel();
    }
    _timers.clear();
  }

  @override
  void dispose() {
    _cancelTimers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(widget.children.length, (i) {
        final visible = i < _visibleCount;
        return IgnorePointer(
          ignoring: !visible,
          child: AnimatedOpacity(
            opacity: visible ? 1.0 : 0.0,
            duration: widget.fadeDuration,
            child: widget.children[i],
          ),
        );
      }),
    );
  }
}
