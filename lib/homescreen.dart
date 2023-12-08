import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> users = [];
  int cnt = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                final email = user['email'];
                final name = user['name']['first'];
                final imageUrl = user['picture']['thumbnail'];

                return ListTile(
                  leading: Image.network(imageUrl),
                  title: Text(name.toString()),
                  subtitle: Text(email),
                );
              })),
    );
  }

  void usersData() async {
    final response =
        await get(Uri.parse('https://randomuser.me/api/?results=5'));
    final body = response.body;
    final json = jsonDecode(body);
    setState(() {
      users = json['results'];
    });
  }

  @override
  void initState() {
    usersData();
    super.initState();
  }
}
