import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// A subtle "thinking" animation with three pulsing dots.
/// Used after user makes a choice to simulate the philosopher considering
/// the response before replying.
class ThinkingIndicator extends StatefulWidget {
  /// If true, wraps in a chat-bubble-style container (for dialogue).
  /// If false, shows just the dots (for centered use in thought experiment).
  final bool asBubble;

  const ThinkingIndicator({super.key, this.asBubble = false});

  @override
  State<ThinkingIndicator> createState() => _ThinkingIndicatorState();
}

class _ThinkingIndicatorState extends State<ThinkingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Sine-based pulse: smooth 0→1→0 cycle
  double _pulse(double t) {
    return math.sin(t * math.pi);
  }

  @override
  Widget build(BuildContext context) {
    final dots = AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (i) {
            // Stagger each dot by 0.25
            final phase = (_controller.value + i * 0.25) % 1.0;
            final pulse = _pulse(phase);
            final scale = 0.6 + 0.4 * pulse;
            final opacity = 0.3 + 0.7 * pulse;
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 3),
              child: Transform.scale(
                scale: scale,
                child: Opacity(
                  opacity: opacity,
                  child: Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
            );
          }),
        );
      },
    );

    if (!widget.asBubble) return dots;

    // Chat bubble style wrapper
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: const BoxDecoration(
            color: AppColors.surfaceLight,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              bottomLeft: Radius.circular(4),
              bottomRight: Radius.circular(16),
            ),
          ),
          child: dots,
        ),
      ),
    );
  }
}
