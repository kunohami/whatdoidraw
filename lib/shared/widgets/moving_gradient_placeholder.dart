import 'package:flutter/material.dart';

class MovingGradientPlaceholder extends StatefulWidget {
  final double height;
  final IconData icon;
  final Widget? child;

  const MovingGradientPlaceholder({
    super.key,
    required this.height,
    this.icon = Icons.link,
    this.child,
  });

  @override
  State<MovingGradientPlaceholder> createState() =>
      _MovingGradientPlaceholderState();
}

class _MovingGradientPlaceholderState extends State<MovingGradientPlaceholder>
    with TickerProviderStateMixin {
  late AnimationController _gradientController;
  late Animation<double> _gradientAnimation;

  @override
  void initState() {
    super.initState();

    _gradientController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat(reverse: true);

    _gradientAnimation = CurvedAnimation(
      parent: _gradientController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _gradientController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Harmonious color palette aligned with the deepPurple seed theme
    final baseColors = [
      colorScheme.primary.withValues(alpha: 0.85),
      colorScheme.secondary.withValues(alpha: 0.7),
      colorScheme.tertiary.withValues(alpha: 0.85),
      colorScheme.primaryContainer.withValues(alpha: 0.75),
    ];

    return AnimatedBuilder(
      animation: _gradientAnimation,
      builder: (context, child) {
        final t = _gradientAnimation.value;

        // Shift alignments gracefully over time to animate the gradient flow
        final begin = Alignment(-1.2 + t * 0.4, -1.2 + t * 0.4);
        final end = Alignment(1.2 - t * 0.4, 1.2 - t * 0.4);

        return Container(
          height: widget.height,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: begin,
              end: end,
              colors: baseColors,
              stops: const [0.0, 0.35, 0.68, 1.0],
            ),
          ),
          child: child,
        );
      },
      child: Center(child: widget.child ?? FloatingIcon(icon: widget.icon)),
    );
  }
}

class FloatingIcon extends StatefulWidget {
  final IconData icon;

  const FloatingIcon({super.key, required this.icon});

  @override
  State<FloatingIcon> createState() => _FloatingIconState();
}

class _FloatingIconState extends State<FloatingIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _floatController;
  late Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();

    _floatController = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: -6.0, end: 6.0).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _floatAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _floatAnimation.value),
          child: child,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.15),
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.25),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Icon(widget.icon, size: 38, color: Colors.white),
      ),
    );
  }
}
