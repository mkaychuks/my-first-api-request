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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        title: const Text('NBA Teams'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getTeams(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error occurred fetching data'),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SizedBox(
                width: 40,
                child: LinearProgressIndicator(
                  backgroundColor: Colors.white70,
                  color: Colors.indigoAccent,
                ),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: teams.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(teams[index].abbreviation),
                  onTap: () {
                    print(teams[index].id);
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
