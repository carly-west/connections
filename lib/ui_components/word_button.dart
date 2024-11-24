import 'package:flutter/material.dart';

class WordButton extends StatefulWidget {
  const WordButton({
    super.key,
    required this.word,
    required this.onPressed,
    required this.isSelected,
    this.correctButtonColor,
  });
  final String word;
  final VoidCallback onPressed;
  final bool isSelected;
  final Color? correctButtonColor;

  @override
  State<WordButton> createState() => _WordButtonState();
}

class _WordButtonState extends State<WordButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: widget.correctButtonColor ??
          (widget.isSelected ? Colors.blue : Colors.grey),
      onPressed: () {
        if (widget.correctButtonColor == null) {
          setState(() {
            widget.onPressed();
          });
        }
      },
      child: Text(widget.word),
    );
  }
}
