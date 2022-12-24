import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../model/teams.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final List<Teams> teams = [];

  // get the total number of teams
  Future getTeams() async {
    // the uri for the teams
    final uri = Uri.https('balldontlie.io', '/api/v1/teams');
    // making the api call
    Response response = await http.get(uri);
    var jsonData = jsonDecode(response.body); // converting to JSON

    // circling through the JSON return and assigning values accordingly..
    for (var eachTeam in jsonData['data']) {
      final team = Teams(
          abbreviation: eachTeam['abbreviation'],
          city: eachTeam['city'],
          conference: eachTeam['conference'],
          division: eachTeam['division'],
          fullName: eachTeam['full_name'],
          id: eachTeam['id'],
          name: eachTeam['name']);

      teams.add(team);
    }
  }

  @override
  Widget build(BuildContext context) {
    getTeams();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        title: const Text('NBA Teams'),
        centerTitle: true,
      ),
    );
  }
}
