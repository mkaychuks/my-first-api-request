import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:nda_api/screens/details_screen.dart';

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
      backgroundColor: const Color.fromARGB(255, 245, 229, 229),
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text('NBA Teams'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: MySearch(),
              );
            },
            icon: const Icon(Icons.search),
          ),
        ],
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
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              itemCount: teams.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 4.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: ListTile(
                    title: Text(
                      teams[index].fullName,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(
                      teams[index].abbreviation,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return DetailsScreen(team: teams[index]);
                          },
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class MySearch extends SearchDelegate<String> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    throw UnimplementedError();
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    throw UnimplementedError();
  }
}
