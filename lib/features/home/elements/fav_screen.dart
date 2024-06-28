import 'package:flutter/material.dart';
import 'package:real_estate_app/core/constants/image_paths.dart';

import '../../../core/constants/colors.dart';
import '../models/property.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({super.key});

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;
  late List<bool> favoriteStates;
  List<Property> propertyList = [
    Property(name: "Glamdone Property", address: "Hampton City, Street 3", isAvailable: true,imageUrl:  ImagesPaths.realEstate1,),
    Property(name: "Sunset Villa", address: "Beverly Hills, Avenue 4", isAvailable: true,imageUrl:  ImagesPaths.realEstate2,),
    Property(name: "Ocean Breeze", address: "Miami Beach, Ocean Drive", isAvailable: false,imageUrl:  ImagesPaths.realEstate3,),
    Property(name: "Mountain Retreat", address: "Aspen, Mountain Road", isAvailable: true,imageUrl:  ImagesPaths.realEstate4,),
    Property(name: "Urban Oasis", address: "New York, 5th Avenue", isAvailable: false,imageUrl:  ImagesPaths.realEstate5,),
    Property(name: "Country Cottage", address: "Nashville, Country Lane", isAvailable: true,imageUrl:  ImagesPaths.realEstate6,),
  ];
  @override
  void initState() {
    super.initState();




    // Initialize favorite states
    favoriteStates = List<bool>.generate(propertyList.length, (index) => true);

    // Create a list of animation controllers and animations for each message
    _controllers = List<AnimationController>.generate(
      propertyList.length,
          (index) => AnimationController(
        duration: Duration(milliseconds: 500),
        vsync: this,
      ),
    );

    _animations = _controllers.map((controller) {
      return CurvedAnimation(parent: controller, curve: Curves.easeIn);
    }).toList();

    // Start each animation with a delay to create a staggered effect
    for (var i = 0; i < _controllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 100), () {
        _controllers[i].forward();
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlackColorTransparent,
      appBar: AppBar(
        backgroundColor: kBlackColorTransparent,
        elevation: 0.7,
        foregroundColor: kPrimaryColor,
        title: Text("Saved"),
      ),
      body: ListView.builder(
        itemCount: propertyList.length,
        itemBuilder: (context, index) {
          return FadeTransition(
            opacity: _animations[index],
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      propertyList[index].imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 200,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  propertyList[index].name,
                                  style: TextStyle(
                                      color: kPrimaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22),
                                ),
                                Text(
                                 propertyList[index].address,
                                  style: TextStyle(
                                      color: kWhiteColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
                                ),
                                Text(
                                  propertyList[index].isAvailable

                                      ? "Available":"Unavailable",
                                  style: TextStyle(
                                      color: kGrey,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 11),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: kBlackColor,
                            ),
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  favoriteStates[index] = !favoriteStates[index];
                                });
                              },
                              icon: Icon(
                                favoriteStates[index] ? Icons.favorite : Icons.favorite_border,
                                color:  favoriteStates[index] ? kPrimaryColor:kGrey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
