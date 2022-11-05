//You should separate task.dart and taskData.dart because if you make it one file it make error crash app
//"this error happens when you try to create and read provider immediately"
import 'package:todoey_sqlite/models/task_database.dart';

import 'task.dart';

class TaskData {
  // List<Task> get tasks => tasks;
  static void add(Task newTask) {
    TasksDatabase.instance.create(newTask);
  }

  Future<int> get taskCount async {
    final tasks = await TasksDatabase.instance.readAllTasks();
    return tasks.length;
  }

  void updateTask(Task taskwantedtochange, bool value) {
    taskwantedtochange.isDone = value;
    TasksDatabase.instance.update(taskwantedtochange);
  }

  void deleteTask(Task task) {
    TasksDatabase.instance.delete(task.id!);
  }
}
