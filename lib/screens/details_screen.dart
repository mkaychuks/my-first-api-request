import 'package:flutter/material.dart';

import '../model/teams.dart';

class DetailsScreen extends StatelessWidget {
  final Teams team;
  const DetailsScreen({Key? key, required this.team}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 229, 229),
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text(team.fullName),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 40),
        children: [
        detailCards(title: team.name, subtitle: "Name"),
        detailCards(title: team.fullName, subtitle: "Full Name"),
        detailCards(title: team.abbreviation, subtitle: "Abbreviation"),
        detailCards(title: team.city, subtitle: "City"),
        detailCards(title: team.conference, subtitle: "Conference"),
        detailCards(title: team.division, subtitle: "Division"),
        ]
      ),
    );
  }

  Container detailCards({required String title, required String subtitle}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
      ),
    );
  }
}
