import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_estate_app/core/constants/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:real_estate_app/core/constants/icon_paths.dart';
import 'package:real_estate_app/features/home/elements/fav_screen.dart';
import 'package:real_estate_app/features/home/elements/home_screen.dart';
import 'package:real_estate_app/features/home/elements/message_screen.dart';
import 'package:real_estate_app/features/home/elements/profile_screen.dart';
import 'package:real_estate_app/features/home/elements/search_screen.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    return Scaffold(
      resizeToAvoidBottomInset: false,

      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: kWhiteColor,
      bottomNavigationBar: Obx(
        () =>AnimatedOpacity(
          opacity: controller.homeScreenAnimationsComplete.value ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 1000),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 35.0),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(50.0),
              ),
              child: NavigationBar(
                height: 80,
                elevation: 0,
                backgroundColor: kBlackColor,
                selectedIndex: controller.selectedIndex.value,
                onDestinationSelected: (index) =>
                    controller.selectedIndex.value = index,
                labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
                destinations: [
                  myNavigationDestionat(
                      icon: IconPaths.searchIcon,
                      label: 'Search',
                      index: 0,
                      controller: controller),
                  myNavigationDestionat(
                      icon: IconPaths.messageIcon,
                      label: 'Messages',
                      index: 1,
                      controller: controller),
                  myNavigationDestionat(
                      icon: IconPaths.homeIcon,
                      label: 'Home',
                      index: 2,
                      controller: controller),
                  myNavigationDestionat(
                      icon: IconPaths.heartIcon,
                      label: 'Heart',
                      index: 3,
                      controller: controller),
                  myNavigationDestionat(
                      icon: IconPaths.personIcon,
                      label: 'Profile',
                      index: 4,
                      controller: controller),
                ],
              ),
            ),
          ),
        ),
      ),

      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }

  NavigationDestination myNavigationDestionat(
      {required String icon,
      required String label,
      required index,
      required controller}) {
    return NavigationDestination(
        icon: AnimatedContainer(
          duration: const Duration(milliseconds: 1000),
          decoration: BoxDecoration(
              // borderRadius: BorderRadius.all(Radius.circular(20)),
              color: controller.selectedIndex.value == index
                  ? kPrimaryColor
                  : kBlackColorTransparent,
              shape: BoxShape.circle),

          child: Padding(
            padding: controller.selectedIndex.value == index
                ? const EdgeInsets.all(16.0)
                : const EdgeInsets.all(12.0),
            child: SvgPicture.asset(
              icon,
              width:controller.selectedIndex.value == index
                  ?  32:22,
              height: controller.selectedIndex.value == index
                  ? 32:22,
              color: kWhiteColor,
            ),
          ),
        ),
        label: label);
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 2.obs;
  final screens = [
    const SearchScreen(),
    const MessageScreen(),
    const HomeScreen(),
    const FavScreen(),
    const ProfileScreen(),
  ];
  final RxBool homeScreenAnimationsComplete = false.obs;

  void setHomeScreenAnimationsComplete() {

    homeScreenAnimationsComplete.value = true;
  }
}
