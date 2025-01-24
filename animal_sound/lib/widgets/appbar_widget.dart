import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    Key? key,
    required this.scaffoldKey,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: SvgPicture.asset(
          "assets/svg/menu.svg",
          width: 25,
          height: 25,
        ),
        onPressed: () => scaffoldKey.currentState?.openDrawer(),
      ),
      title: Center(
        child: Text(
          'Learn',
          style: GoogleFonts.nerkoOne(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(
            "assets/svg/tiger.svg",
            width: 30,
            height: 30,
          ),
        )
      ],
    );
  }
}
