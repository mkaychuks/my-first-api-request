import 'package:flutter/material.dart';

import '../model/teams.dart';

class DetailsScreen extends StatelessWidget {

  final Teams team;
  const DetailsScreen({Key? key, required this.team}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        title: Text(team.fullName),
        centerTitle: true,
      ),
    );
  }
}
