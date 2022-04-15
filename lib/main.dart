import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:color_gen/screens/color_user/color_user.dart';
import 'package:color_gen/services/data_sorter_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Top Color Generator',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Top Color Generator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map<String, int> lstFavorite = {};
  late DataSorterService service;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  initialize() async {

    service = DataSorterService();
    service.countFavouriteColors().then((value) {
      setState(() {
        lstFavorite = value;
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(30),
              child: Center(
                child: Text(
                  widget.title,
                  style: GoogleFonts.dancingScript(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Card(
                  child: Center(
                    child: ListView(
                      children: [
                        DataTable(
                          columns: const [
                            DataColumn(
                              label: Text('Color'),
                            ),
                            DataColumn(
                              label: Text('Number of users'),
                            ),
                          ],
                          rows: lstFavorite.entries
                              .map((entry) => DataRow(
                            cells: [
                              DataCell(
                                Text(entry.key),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ColorUsers(
                                        users: service.lstColorUsers[entry.key]!,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              DataCell(Text(entry.value.toString()),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ColorUsers(
                                          users: service.lstColorUsers[entry.key]!,
                                        ),
                                      ),
                                    );
                                  }),
                            ],
                          ))
                              .toList(),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
