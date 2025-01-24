import 'package:animal_sound/data/animal_data.dart';
import 'package:animal_sound/widgets/animals_card_widget.dart';
import 'package:animal_sound/widgets/appbar_widget.dart';
import 'package:animal_sound/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();
    //Color(0xFFF6A629)

    return Scaffold(
      key: scaffoldKey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBarWidget(scaffoldKey: scaffoldKey),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: animals.length,
          itemBuilder: (BuildContext context, int index) {
            return AnimalsCardWidget(list: animals[index]);
          },
        ),
      ),
      drawer: const DrawerWidget(),
    );
  }
}
