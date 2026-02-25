import 'dart:async';
import 'dart:ui';

/// Shared typewriter controller — encapsulates Timer + revealedChars logic.
///
/// Usage:
///   final _tw = TypewriterController();
///   _tw.start(text: '...', isZh: true, onUpdate: () => setState(() {}));
///   // In build: Text(_tw.displayText)
///   // Fast-forward: _tw.skip(); setState(() {});
///   // Don't forget: _tw.dispose() in State.dispose()
class TypewriterController {
  Timer? _timer;
  int revealedChars = 0;
  String text = '';
  bool isComplete = false;

  /// The currently revealed portion of [text].
  String get displayText =>
      text.substring(0, revealedChars.clamp(0, text.length));

  /// Whether the typewriter is actively revealing characters.
  bool get isTyping => _timer?.isActive == true;

  /// Start typing [text] character by character.
  ///
  /// [onUpdate] is called on every character reveal (typically `setState`).
  /// [onComplete] is called once the full text is revealed.
  /// [onScroll] is called periodically during typing for auto-scroll.
  void start({
    required String text,
    required bool isZh,
    required VoidCallback onUpdate,
    VoidCallback? onComplete,
    VoidCallback? onScroll,
    bool fast = false,
  }) {
    _timer?.cancel();
    this.text = text;
    revealedChars = 0;
    isComplete = false;

    final interval = fast
        ? (isZh ? 55 : 35)   // faster for story content
        : (isZh ? 100 : 60); // normal speed

    _timer = Timer.periodic(Duration(milliseconds: interval), (t) {
      revealedChars++;

      // Periodic scroll during typing
      if (onScroll != null && revealedChars % 8 == 0) {
        onScroll();
      }

      onUpdate();

      if (revealedChars >= text.length) {
        t.cancel();
        isComplete = true;
        onComplete?.call();
      }
    });
  }

  /// Skip to end — reveal all text immediately.
  /// Caller should call setState() after this.
  void skip() {
    _timer?.cancel();
    if (!isComplete && text.isNotEmpty) {
      revealedChars = text.length;
      isComplete = true;
    }
  }

  /// Reset to idle state (no text, not typing).
  void reset() {
    _timer?.cancel();
    text = '';
    revealedChars = 0;
    isComplete = false;
  }

  void dispose() {
    _timer?.cancel();
  }
}
