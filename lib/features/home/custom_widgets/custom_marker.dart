import 'package:flutter/material.dart';
import 'package:real_estate_app/core/constants/colors.dart';

class CustomMarker extends StatelessWidget {
  const CustomMarker({
    super.key,
    required this.text,
    this.toggleText = false,
  });
  final String text;
  final bool toggleText;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
              bottomRight: Radius.circular(15)),
          shape: BoxShape.rectangle,
        ),
        padding: !toggleText
            ? const EdgeInsets.all(10.0)
            : const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
        child: Row(
          children: [
            !toggleText
                ? Icon(
              Icons.apartment_outlined,
              color: kWhiteColor,
              size: 32,
            )
                : const SizedBox(),
            toggleText
                ? Expanded(
              child: Text(
                text,
                style: TextStyle(
                    color: kWhiteColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            )
                : const SizedBox(),
          ],
        ));
  }
}