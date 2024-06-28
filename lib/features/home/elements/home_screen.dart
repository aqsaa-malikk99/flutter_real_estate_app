
import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:real_estate_app/core/constants/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:real_estate_app/features/home/custom_widgets/my_staggered_anim_tile.dart';
import 'package:real_estate_app/features/home/custom_widgets/text_transform_anim_widget.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../core/constants/image_paths.dart';
import '../../../core/constants/icon_paths.dart';
import '../navigation_menu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  String userName = 'Marina';
  String location='Saint Peterburg';
  String urlImage="https://lh3.googleusercontent.com/pw/AP1GczN3B7jTk9NFtxKIYxJ55eDb8LoOqQ-X1EVomekBgp_-qSWWISdZN-ssNPMT73hHP9rXqqlSyriCDHJxiOmLAsqy2-qPNqvW5dGVMLUtkqvivDfSB64";
  bool showLocationBar = false;
  bool showCircularImage = false;
  bool showGreetingText = false;
  bool showSelectionText = false;
  bool showStatsContainers = false;
  bool showCircleContainer = false;

  bool _bottomSheetVisible = false;
  bool _sliderAnimationStarted = false;
  String buyStatValue = '1034';
  String rentStatValue = '2212';

  final controller = Get.find<NavigationController>();


  @override
  void initState() {
    super.initState();
    animateElements();
  }

  void animateElements() {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        showLocationBar = true;
      });
    }).then((_) {
      Future.delayed(const Duration(milliseconds: 1000), () {
        setState(() {
          showCircularImage = true;
        });
      }).then((_) {
        Future.delayed(const Duration(milliseconds: 1000), () {
          setState(() {
            showGreetingText = true;
          });
        }).then((_) {
          Future.delayed(const Duration(milliseconds: 1000), () {
            setState(() {
              showSelectionText = true;
            });
          }).then((_) {
            Future.delayed(const Duration(milliseconds: 3000), () {
              setState(() {
                showStatsContainers = true;
              });
            }).then((_) {
              setState(() {
                showCircleContainer = true;
                // Once all animations are complete, show the bottom sheet
                _showBottomSheet();
              });
            });
          });
        });
      });
    });
  }

  void _showBottomSheet() {

    // Use showModalBottomSheet to display a bottom sheet
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _bottomSheetVisible = true;
      });
    }).then((value) {
      Future.delayed(const Duration(milliseconds: 1000), () {
        setState(() {
          _sliderAnimationStarted = true;
        });
      }).then((value) {
     Future.delayed(const Duration(milliseconds: 1200),(){
       setState(() {
         controller.setHomeScreenAnimationsComplete();
       });
     });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Use transparent background
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0XFFF8F7F7),
              Color(0XFFF9EDE1),
              Color(0XFFFAD5AA),
            ],
          ),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AnimatedOpacity(
                      opacity: showLocationBar ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 1000),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 1000),
                        width: showLocationBar ? null : 0,
                        child: createLocationBar(location: location),
                      ),
                    ),
                    AnimatedOpacity(
                      opacity: showCircularImage ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 1000),
                      child: createCircularImage(),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                AnimatedOpacity(
                  opacity: showGreetingText ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 1000),
                  child: Text(
                    "Hi, $userName",
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 24,
                      color: kSecondaryColor,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                TextTransform(
                  text: "let's select your",
                  textStyle: const TextStyle(fontSize: 32, height: 1.2),
                  duration: const Duration(milliseconds: 3000),
                ),
                TextTransform(
                  text: "perfect place",
                  textStyle: const TextStyle(fontSize: 32, height: 1.2),
                  duration: const Duration(milliseconds: 5000),
                ),
                const SizedBox(height: 30),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: createStatsContainer(
                        title: 'BUY',
                        stats: double.parse(buyStatValue),
                        end: 'offers',
                        isCircle: true,
                        backgroundColor: kPrimaryColor,
                        foregroundColor: kWhiteColor,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: createStatsContainer(
                        title: 'RENT',
                        stats: double.parse(rentStatValue),
                        end: 'offers',
                        isCircle: false,
                        backgroundColor: kWhiteColor,
                        foregroundColor: kSecondaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: AnimatedOpacity(
                opacity: _bottomSheetVisible ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 500),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.easeInOut,
                  height: _bottomSheetVisible
                      ? MediaQuery.of(context).size.height * 0.67
                      : 0,
                  decoration: BoxDecoration(
                    color: kWhiteColor,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(30)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: StaggeredGrid.count(
                      crossAxisCount: 6,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 2,
                      children: [
                        MyStaggeredGridTile(
                          crossCellCount: 6,
                          mainAxisCellCount: 3,
                          imagePath: ImagesPaths.realEstate1,
                          address: 'Gladkova St, 25..',
                          sliderAnimationStarted: _sliderAnimationStarted,
                        ),
                        MyStaggeredGridTile(
                          crossCellCount: 3,
                          mainAxisCellCount: 4,
                          imagePath: ImagesPaths.realEstate2,
                          address: 'Main traford, St3',
                          sliderAnimationStarted: _sliderAnimationStarted,
                        ),
                        MyStaggeredGridTile(
                          crossCellCount: 3,
                          mainAxisCellCount: 2,
                          imagePath: ImagesPaths.realEstate3,
                          address: 'Albaina St3,...',
                          sliderAnimationStarted: _sliderAnimationStarted,
                        ),
                        MyStaggeredGridTile(
                          crossCellCount: 3,
                          mainAxisCellCount: 2,
                          imagePath: ImagesPaths.realEstate4,
                          address: 'Garden St4',
                          sliderAnimationStarted: _sliderAnimationStarted,
                        ),
                        MyStaggeredGridTile(
                          crossCellCount: 6,
                          mainAxisCellCount: 3,
                          imagePath: ImagesPaths.realEstate5,
                          address: 'Gladkova St, 25..',
                          sliderAnimationStarted: _sliderAnimationStarted,
                        ),
                        MyStaggeredGridTile(
                          crossCellCount: 6,
                          mainAxisCellCount: 3,
                          imagePath: ImagesPaths.realEstate6,
                          address: 'Gladkova St, 25..',
                          sliderAnimationStarted: _sliderAnimationStarted,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  createStatsContainer(
      {required String title,
      required double stats,
      required String end,
      required bool isCircle,
      required Color backgroundColor,
      required Color foregroundColor}) {
    return AnimatedOpacity(
        opacity: showCircleContainer ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 500),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 1000),
          width: showCircleContainer ? null : 0,
          decoration: BoxDecoration(
            shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
            color:
                backgroundColor, // Change this to your desired background color
            borderRadius: !isCircle ? BorderRadius.circular(30) : null,
          ),
          child: Column(
            mainAxisSize:
                MainAxisSize.min, // Center the column within the circle

            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                title,
                style: TextStyle(
                  color: foregroundColor,
                  // fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Countup(
                begin: 1000,
                end: stats,
                duration: const Duration(seconds: 1),
                separator: ',',
                style: TextStyle(
                    color: foregroundColor,
                    fontSize: 42,
                    letterSpacing: 0.2,
                    height: 1,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                end,
                style: TextStyle(
                  color: foregroundColor,
                  // fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ));
  }

  Widget createLocationBar({required String location}) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade50,
                offset: const Offset(0, 1),
                blurRadius: 20)
          ]),
      padding: const EdgeInsets.all(10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SvgPicture.asset(
            IconPaths.locationIcon,
            width: 24,
            height: 24,
            color: kSecondaryColor,
          ),
          const SizedBox(width: 5),
          Text(
            location,
            style: TextStyle(
              color: kSecondaryColor,
              fontSize: 20,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }

  Widget createCircularImage() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 1000),
      height: showCircularImage ? 60 : 0,
      width: showCircularImage ? 60 : 50,
      child: CachedNetworkImage(
        imageUrl:urlImage,
        errorWidget: (context, url, error) => Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(ImagesPaths.placeHolder),
              fit: BoxFit.cover,
            ),
          ),
        ),
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.shade300,
            ),
          ),
        ),
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}


