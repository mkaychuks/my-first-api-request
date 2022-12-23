import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nda_api/model/team.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  List<Team> teams = [];

  Future getTeams() async {
    var url = Uri.https('balldontlie.io', '/api/v1/teams');
    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    for (var eachTeam in jsonData['data']) {
      final team = Team(
        abbreviation: eachTeam['abbreviation'],
        city: eachTeam['city'],
      );
      teams.add(team);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text("NBA TEAMS"),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: FutureBuilder(
        future: getTeams(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: teams.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    title: Text(
                      teams[index].city,
                    ),
                    subtitle: Text(
                      teams[index].abbreviation,
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: SizedBox(
                width: 40.0,
                child: LinearProgressIndicator(
                  color: Colors.blueGrey,
                  backgroundColor: Colors.white,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
