import 'package:flutter/material.dart';
import 'package:flutterbook/notes/NotesDBWorker.dart';
import 'package:flutterbook/notes/NotesEntry.dart';
import 'package:flutterbook/notes/NotesList.dart';
import 'package:scoped_model/scoped_model.dart';

import 'NotesModel.dart' show Note, NotesModel, notesModel;

class Notes extends StatelessWidget {

  Notes() {
    notesModel.loadData("notes", NotesDBWorker.db);
  }

  Widget build(BuildContext inContext) {
    return ScopedModel<NotesModel>(
        model: notesModel,
        child: ScopedModelDescendant(builder:
            (BuildContext inContext, Widget inChild, NotesModel inModel) {
          return IndexedStack(
            index: inModel.stackIndex,
            children: [NotesList(), NotesEntry()],
          );
        }));
  }
}
