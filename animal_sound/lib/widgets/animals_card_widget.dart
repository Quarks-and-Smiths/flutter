import 'package:animal_sound/views/detail_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimalsCardWidget extends StatelessWidget {
  final list;
  const AnimalsCardWidget({
    super.key,
    this.list,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => const DetailScreen(), arguments: {
          "title": list["title"],
          "image": list["image"],
          "desc": list["desc"],
          "color": list["color"],
          "textColor": list["textColor"],
          "lifeSpan": list["lifeSpan"],
          "speed": list["speed"],
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Stack(
          //overflow: Overflow.visible,
          //clipBehavior: Clip.hardEdge,
          alignment: Alignment.centerLeft,
          children: [
            Container(
              //padding: const EdgeInsets.only(left: 80, right: 25),
              margin: const EdgeInsets.only(left: 30),
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: list["color"],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    list["title"],
                    style: GoogleFonts.nerkoOne(
                      color: list["textColor"],
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    width: 250,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 55.0),
                      child: Text(
                        list["desc"],
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.nerkoOne(
                          color: list["textColor"],
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SvgPicture.asset(
              "assets/svg/${list["image"]}.svg",
              width: 120,
              height: 120,
            ),
          ],
        ),
      ),
    );
  }
}
