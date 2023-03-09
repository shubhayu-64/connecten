import 'package:flutter/material.dart';
import 'package:ConnecTen/ProfileScreen/widgets/social_links.dart';
import 'package:ConnecTen/utils/assets.dart';
import 'package:ConnecTen/utils/size_config.dart';

Widget socialCard(BuildContext context) {
  return Container(
    padding: EdgeInsets.all(20),
    child: Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          social(index: 1, image: ImageAsset.linkedinlogo, text: "Linkedin"),
          social(index: 2, image: ImageAsset.githublogo, text: "Github"),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          social(index: 3, image: ImageAsset.websitelogo, text: "Portfolio"),
          social(index: 4, image: ImageAsset.twitterlogo, text: "Twitter"),
        ]),
        SizedBox(
          height: screenHeight! * 0.02,
        ),
        Text(
          "Click to edit",
          textAlign: TextAlign.center,
          style: TextStyle(
            letterSpacing: 1,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        )
      ],
    ),
  );
}
