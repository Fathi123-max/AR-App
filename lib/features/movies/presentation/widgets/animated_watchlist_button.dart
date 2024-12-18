import 'package:flutter/material.dart';

class AnimatedWatchlistButton extends StatefulWidget {
  final bool isWatchlisted;
  final VoidCallback onPressed;

  const AnimatedWatchlistButton({
    Key? key,
    required this.isWatchlisted,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<AnimatedWatchlistButton> createState() => _AnimatedWatchlistButtonState();
}

class _AnimatedWatchlistButtonState extends State<AnimatedWatchlistButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.3),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.3, end: 1.0),
        weight: 50,
      ),
    ]).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    widget.onPressed();
    _controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) => Transform.scale(
        scale: _scaleAnimation.value,
        child: IconButton(
          icon: Icon(
            widget.isWatchlisted ? Icons.bookmark : Icons.bookmark_border,
            color: widget.isWatchlisted ? Colors.blue : Colors.grey,
          ),
          onPressed: _handleTap,
        ),
      ),
    );
  }
}