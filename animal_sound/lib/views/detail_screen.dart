import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var veriler = Get.arguments;
    final player = AudioPlayer();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    width: Get.width,
                    height: 400,
                    decoration: BoxDecoration(
                      color: veriler["color"],
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: InkWell(
                      onTap: () => player.play(AssetSource('sounds/duck.mp3')),
                      child: Padding(
                        padding: const EdgeInsets.all(70.0),
                        child: SvgPicture.asset(
                          "assets/svg/${veriler["image"]}.svg",
                          fit: BoxFit.cover,
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: InkWell(
                      onTap: () => Get.back(),
                      child: SvgPicture.asset(
                        "assets/svg/back.svg",
                        width: 40,
                        height: 40,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16),
                child: Text(
                  veriler["title"],
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.nerkoOne(
                    //color: veriler["textColor"],
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, left: 16, right: 16),
                child: Text(
                  veriler["desc"],
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.roboto(
                    //color: veriler["textColor"],
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Lifespan",
                      style: GoogleFonts.nerkoOne(
                        //color: veriler["textColor"],
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      veriler["lifeSpan"],
                      style: GoogleFonts.roboto(
                        //color: veriler["textColor"],
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Speed",
                      style: GoogleFonts.nerkoOne(
                        //color: veriler["textColor"],
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      veriler["speed"],
                      style: GoogleFonts.roboto(
                        //color: veriler["textColor"],
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            player.play(AssetSource('sounds/${veriler["image"]}.mp3')),
        backgroundColor: veriler["color"],
        child: Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: SvgPicture.asset(
            "assets/svg/play.svg",
            width: 30,
            height: 30,
            color: veriler["textColor"],
          ),
        ),
      ),
    );
  }
}
