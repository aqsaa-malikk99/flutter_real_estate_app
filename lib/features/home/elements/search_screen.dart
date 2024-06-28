import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:real_estate_app/core/constants/colors.dart';
import 'package:real_estate_app/features/home/custom_widgets/search_bar.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

import '../custom_widgets/custom_marker.dart';
import '../custom_widgets/side_button.dart';
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  late GoogleMapController mapController;
  final GlobalKey<PopupMenuButtonState> popUpKey = GlobalKey();

  String selectedItem = '';

  final List<LatLng> _markerLocations = [
    const LatLng(45.527831, -122.687512),  // Original location
    const LatLng(45.529831, -122.689512),  // -200m North-West
    const LatLng(45.522831, -122.687512),  // 500m South
    const LatLng(45.527831, -122.682512),  // 500m East
    const LatLng(45.527831, -122.677512),  // 500m East of point 4 (2km East of original)
    const LatLng(45.530831, -122.677512)   // 300m North of point 5
  ];

  Set<Marker> markers = {};
  late String _mapStyle = "";
  bool _showText = true;

  @override
  void initState() {
    super.initState();


    initMarkers();
  }


  initMarkers() async {
    await rootBundle
        .loadString('assets/json_assets/map_style.txt')
        .then((string) {
      _mapStyle = string;
    });
    setState(() {});

    markers = {};
    for (int i = 0; i < _markerLocations.length; i++) {
      final location = _markerLocations[i];
      final markerId = MarkerId('$i');

      final marker = Marker(
        markerId: markerId,
        position: location,
        icon: await CustomMarker(
          text: '10$i.$i mn P',
          toggleText: _showText,
        ).toBitmapDescriptor(
          logicalSize: _showText ? const Size(150, 150) : const Size(52, 52),
          imageSize: _showText ? const Size(300, 400) : const Size(102, 102),
        ),
      );

      markers.add(marker);
      setState((){});
    }

  }




  void _toggleMarkerText(bool show) {
    setState(() {
      markers.clear();
      initMarkers();
      _showText = show;
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(

        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            style: _mapStyle,
            initialCameraPosition: CameraPosition(
              target: _markerLocations.first,
              zoom: 15.0,
            ),
            markers: markers,
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                 Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20.0),
                  child: Row(
                    children: [
                      CustomSearchBar(
                        onSubmit: (String val){
                          //TODO: THIS IS SET BECAUSE WE CAN EASILY USE TO REMOVE keyboard
                        },
                      ),
                      SizedBox(width: 8),
                      SideButton(),
                    ],
                  ),
                ),
                const Expanded(child: SizedBox()),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FloatingActionButton(
                          onPressed: () {
                            popUpKey.currentState?.showButtonMenu();
                            showMenu(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                              context: context,
                              position: const RelativeRect.fromLTRB(0, 450, 0, 0.0),
                              items: [
                                buildPopItem(
                                    icon: Icons.safety_check_outlined,
                                    text: 'Cosy areas',
                                    onTap: () {}),
                                buildPopItem(
                                    icon: Icons.wallet_outlined,
                                    text: 'Price',
                                    onTap: () {
                                      _toggleMarkerText(true);
                                    }),
                                buildPopItem(
                                    icon: Icons.emoji_transportation_sharp,
                                    text: 'Infrastructure',
                                    onTap: () {}),
                                buildPopItem(
                                    icon: Icons.layers_outlined,
                                    text: 'Without any Layer',
                                    onTap: () {
                                      _toggleMarkerText(false);
                                    }),
                              ],
                            );
                          },
                          backgroundColor: kGreyTransaparent,
                          child: const Icon(Icons.menu),
                        ),
                        const SizedBox(height: 8.0),
                        FloatingActionButton(
                          backgroundColor: kGreyTransaparent,
                          onPressed: () {},
                          child: const Icon(Icons.location_on_outlined),
                        ),
                      ],
                    ),
                    const Expanded(child: SizedBox()),
                    ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kGreyTransaparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 15.0),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.menu,
                              color: kWhiteColor,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "List of Variants",
                              style: TextStyle(color: kWhiteColor),
                            ),
                          ],
                        )),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  PopupMenuItem buildPopItem(
      {required IconData icon,
        required String text,
        required Function() onTap}) {
    return PopupMenuItem(
      child: ListTile(
        leading: Icon(
          icon,
          color: selectedItem == text ? kPrimaryColor : kGrey,
        ),
        title: Text(
          text,
          style: TextStyle(
            color: selectedItem == text ? kPrimaryColor : kGrey,
          ),
        ),
        onTap: () {
          setState(() {
            selectedItem = text;
          });
          Navigator.pop(context);
          onTap();
        },
      ),
    );
  }
}






