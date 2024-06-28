import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/constants/colors.dart';

class CustomSearchBar extends StatefulWidget {
  final Function(String) onSubmit;

  const CustomSearchBar({
    Key? key,
    required this.onSubmit,
  }) : super(key: key);

  @override
  _CustomSearchBarState createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);


    // Initialize the animation to animate from 0 to 1
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
      animation: _animation,
      builder: (context, child) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          width: max(0, _animation.value * MediaQuery.of(context).size.width - 100),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [

              Expanded(
                child: TextFormField(
                  enabled: false,
                  autovalidateMode: AutovalidateMode.always,
                  onTapOutside: (v){
                    FocusScope.of(context).unfocus();

                  },
                  onFieldSubmitted: (value) {
                    widget.onSubmit(value);
                  },
                  decoration: InputDecoration(
                    icon: Icon(
                      FontAwesomeIcons.search,
                      color: Colors.grey,
                    ),
                      hintText: 'Saint Petersburg',
                    hintStyle: TextStyle(
                      color: kGrey,
                      fontWeight: FontWeight.w300,
                    ),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
                  style: TextStyle(
                    color: kBlackColor,
                    fontWeight: FontWeight.w500,
                  ),
                  onTap: () {
                    _controller.forward();
                  },
                  onEditingComplete: () {
                    _controller.reverse();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
