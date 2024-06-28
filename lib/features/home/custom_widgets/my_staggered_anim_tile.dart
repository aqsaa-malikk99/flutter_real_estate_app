
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../custom_widgets/custom_slider.dart';


class MyStaggeredGridTile extends StatefulWidget {
  final int crossCellCount;
  final int mainAxisCellCount;
  final String address;
  final String imagePath;
  final bool sliderAnimationStarted;

  MyStaggeredGridTile({
    required this.crossCellCount,
    required this.mainAxisCellCount,
    required this.address,
    required this.imagePath,
    this.sliderAnimationStarted = false,
  });

  @override
  _MyStaggeredGridTileState createState() => _MyStaggeredGridTileState();
}

class _MyStaggeredGridTileState extends State<MyStaggeredGridTile> {
  bool animationStart = false;
  final GlobalKey<CustomSliderState> _sliderKey =
  GlobalKey<CustomSliderState>();


  void _startSliderAnimation() {

      if (widget.sliderAnimationStarted) {
        setState(() {
          animationStart = true;
        });
        _sliderKey.currentState?.startAnimation();


      }

  }

  @override
  Widget build(BuildContext context) {
    _startSliderAnimation();
    return StaggeredGridTile.count(
      crossAxisCellCount: widget.crossCellCount,
      mainAxisCellCount: widget.mainAxisCellCount,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.grey[200],
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset(
                  widget.imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 70,
                padding: const EdgeInsets.all(5.0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                  ),
                ),
                child: CustomSlider(
                  key: _sliderKey,
                  crossCellCount: widget.crossCellCount,
                  thumbIcon: FontAwesomeIcons.chevronRight,
                  revealText: widget.address,
                  animationStart: animationStart,
                ),

              ),
            ),
          ],
        ),
      ),
    );
  }
}