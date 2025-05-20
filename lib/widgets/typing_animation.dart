
import 'package:flutter/material.dart';
import 'dart:async';

class TypingAnimation extends StatefulWidget {
  final String text;
  final TextStyle style;
  final Duration duration;
  
  const TypingAnimation({
    super.key,
    required this.text,
    this.style = const TextStyle(),
    this.duration = const Duration(milliseconds: 40),
  });

  @override
  State<TypingAnimation> createState() => _TypingAnimationState();
}

class _TypingAnimationState extends State<TypingAnimation> {
  String _displayText = '';
  int _characterCount = 0;
  late Timer _timer;
  
  @override
  void initState() {
    super.initState();
    _startTyping();
  }
  
  void _startTyping() {
    _timer = Timer.periodic(widget.duration, (timer) {
      setState(() {
        if (_characterCount < widget.text.length) {
          _displayText = widget.text.substring(0, _characterCount + 1);
          _characterCount++;
        } else {
          _timer.cancel();
        }
      });
    });
  }
  
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Text(
      _displayText,
      style: widget.style,
    );
  }
}