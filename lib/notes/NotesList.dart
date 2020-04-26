import "package:flutter/material.dart";
import "package:scoped_model/scoped_model.dart";
import "package:flutter_slidable/flutter_slidable.dart";
import "NotesDBWorker.dart";
import "NotesModel.dart" show Note, NotesModel, notesModel;

class NotesList extends StatelessWidget {
  @override
  Widget build(BuildContext inContext) {
    // TODO: implement build
    return ScopedModel<NotesModel>(
      model: notesModel,
      child: ScopedModelDescendant(builder:
          (BuildContext inContext, Widget inChild, NotesModel inModel) {
        return Scaffold(
            floatingActionButton: FloatingActionButton(
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () {
                  notesModel.entityBeingEdited = Note();
                  notesModel.setColor(null);
                  notesModel.setStackIndex(1);
                }),
            body: ListView.builder(
                itemCount: notesModel.entityList.length,
                itemBuilder: (BuildContext context, int index) {
                  Note note = notesModel.entityList[index];
                  Color color = Colors.white;
                  switch (note.color) {
                    case "red":
                      color = Colors.red;
                      break;
                    case "green":
                      color = Colors.green;
                      break;
                    case "blue":
                      color = Colors.blue;
                      break;
                    case "yellow":
                      color = Colors.yellow;
                      break;
                    case "grey":
                      color = Colors.grey;
                      break;
                    case "purple":
                      color = Colors.purple;
                      break;
                  }
                  return Container(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      actionExtentRatio: .25,
                      secondaryActions: <Widget>[
                        IconSlideAction(
                          caption: "Delete",
                          color: Colors.red,
                          icon: Icons.delete,
                          onTap: () => _deleteNotes(context, note),
                        )
                      ],
                      child: Card(
                        elevation: 8,
                        color: color,
                        child: ListTile(
                          title: Text("${note.title}"),
                          subtitle: Text("${note.content}"),
                          onTap: () async {
                            notesModel.entityBeingEdited =
                                await NotesDBWorker.db.get(note.id);
                            notesModel
                                .setColor(notesModel.entityBeingEdited.color);
                            notesModel.setStackIndex(1);
                          },
                        ),
                      ),
                    ),
                  );
                }));
      }),
    );
  }

  _deleteNotes(BuildContext context, Note note) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext inAlertContext) {
          return AlertDialog(
            title: Text("Delete note"),
            content: Text("Are you sure want to delete ${note.title}"),
            actions: <Widget>[
              FlatButton(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.of(inAlertContext).pop();
                },
              ),
              FlatButton(
                child: Text("Delete"),
                onPressed: () async {
                  await NotesDBWorker.db.delete(note.id);
                  Navigator.of(inAlertContext).pop();
                  Scaffold.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 2),
                      content: Text("Note deleted")));
                  notesModel.loadData("notes", NotesDBWorker.db);
                },
              ),
            ],
          );
        });
  }
}
