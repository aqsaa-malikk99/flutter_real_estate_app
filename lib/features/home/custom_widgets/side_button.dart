import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SideButton extends StatefulWidget {
  const SideButton({
    Key? key,
  }) : super(key: key);

  @override
  State<SideButton> createState() => _SideButtonState();
}

class _SideButtonState extends State<SideButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );

    _sizeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _sizeAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.forward(); // Start opacity animation after size animation
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: _sizeAnimation.value * 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: AnimatedOpacity(
              opacity: _opacityAnimation.value,
              duration: const Duration(milliseconds: 3000),
              child: GestureDetector(
                onTap: (){},
                child: Icon(
                  FontAwesomeIcons.bars,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
