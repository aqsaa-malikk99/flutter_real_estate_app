import 'package:flutter/material.dart';

class TextTransform extends StatefulWidget {
  final String text;
  final TextStyle textStyle;
  final Duration? duration;
  TextTransform(
      {super.key, required this.text, required this.textStyle, this.duration});
  @override
  _TextTransformState createState() => _TextTransformState();
}

class _TextTransformState extends State<TextTransform>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: widget.duration ?? const Duration(milliseconds: 2000),
      vsync: this,
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.75,
          1.0,
          curve: Curves.easeOut,
        ),
      ),
    );


    // Start the animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 5),
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Opacity(
              opacity: _opacityAnimation.value,
              child: RichText(
                text: TextSpan(
                  style: widget.textStyle,
                  children: widget.text
                      .split('\n')
                      .asMap()
                      .map((index, char) {
                        return MapEntry(
                          index,
                          WidgetSpan(
                            child: Transform.translate(
                              offset: Offset(0, 100 * (1 - _controller.value)),
                              child: Text(
                                char,
                                style: const TextStyle(fontSize: 32, height: 1.2),
                              ),
                            ),
                          ),
                        );
                      })
                      .values
                      .toList(),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
