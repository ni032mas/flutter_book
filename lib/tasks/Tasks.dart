import 'package:flutter/material.dart';
import 'package:flutterbook/tasks/TasksDBWorker.dart';
import 'package:flutterbook/tasks/TasksEntry.dart';
import 'package:flutterbook/tasks/TasksList.dart';
import 'package:scoped_model/scoped_model.dart';

import 'TasksModel.dart' show Task, TasksModel, tasksModel;

class Tasks extends StatelessWidget {

  Tasks() {
    tasksModel.loadData("tasks", TasksDBWorker.db);
  }

  Widget build(BuildContext inContext) {
    return ScopedModel<TasksModel>(
        model: tasksModel,
        child: ScopedModelDescendant(builder:
            (BuildContext inContext, Widget inChild, TasksModel inModel) {
          return IndexedStack(
            index: inModel.stackIndex,
            children: [TasksList(), TasksEntry()],
          );
        }));
  }
}
