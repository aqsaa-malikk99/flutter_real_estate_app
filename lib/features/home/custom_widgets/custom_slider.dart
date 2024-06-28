
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:real_estate_app/core/constants/colors.dart';

class CustomSlider extends StatefulWidget {
  final IconData thumbIcon;
  final String revealText;
  final bool animationStart;
  final int crossCellCount; // Add this parameter

  CustomSlider({
    super.key,
    required this.thumbIcon,
    required this.revealText,
    required this.animationStart,
    required this.crossCellCount, // Initialize it
  });

  @override
  CustomSliderState createState() => CustomSliderState();
}

class CustomSliderState extends State<CustomSlider>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000), // Adjust duration as needed
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _isVisible = true;
        });
      }
    });

    if (widget.animationStart) {
      _controller.forward();
    }
  }

  void startAnimation() {
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      height: 80.0,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          double leftValue;
          if (widget.crossCellCount == 6) {
            leftValue = (_animation.value * MediaQuery.of(context).size.width) - 120.0;
          } else if (widget.crossCellCount == 3) {
            leftValue = (_animation.value * MediaQuery.of(context).size.width) - 310.0;
          } else {
            leftValue = (_animation.value * MediaQuery.of(context).size.width) - 350.0;
          }

          return Align(
            alignment: Alignment.centerLeft,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  width: _animation.value * MediaQuery.of(context).size.width,
                  height: 50.0,
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: Colors.grey.shade200.withOpacity(0.5),
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment:widget.crossCellCount==6?Alignment.center:Alignment.centerLeft,
                        child: _isVisible
                            ? Text(
                          widget.revealText,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize:widget.crossCellCount==6? 16.0:11.0,
                          ),
                        )
                            : const SizedBox.shrink(),
                      ),
                      Positioned(
                        left: leftValue,
                        top: 2.5,
                        child: Container(
                          width: 30.0,
                          height: 45.0,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFFA9A299),
                                offset: Offset(-9, 4),
                                blurRadius: 14.2,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Icon(
                              widget.thumbIcon,
                              size: 10.0,
                              color:kGrey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
