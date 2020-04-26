import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutterbook/notes/Notes.dart';
import 'package:flutterbook/tasks/Tasks.dart';
import 'package:path_provider/path_provider.dart';
import "utils.dart" as utils;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  startMeUp() async {
    Directory docsDir = await getApplicationDocumentsDirectory();
    utils.docsDir = docsDir;
    runApp(FlutterBook());
  }

  startMeUp();
}

class FlutterBook extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: Text("FlutterBook"),
            bottom: TabBar(tabs: [
              Tab(
                icon: Icon(Icons.date_range),
                text: "Appointment",
              ),
              Tab(
                icon: Icon(Icons.contacts),
                text: "Contacts",
              ),
              Tab(
                icon: Icon(Icons.note),
                text: "Notes",
              ),
              Tab(
                icon: Icon(Icons.assignment_turned_in),
                text: "Tasks",
              ),
            ]),
          ),
          body: TabBarView(children: [
            Text("Appointment()"),
            Text("Contacts()"),
            Notes(),
            Tasks(),
          ]),
        ),
      ),
    );
  }
}
