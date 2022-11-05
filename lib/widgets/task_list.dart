import 'package:flutter/material.dart';
import 'package:todoey_sqlite/models/task.dart';
import 'package:todoey_sqlite/models/task_data.dart';

class TaskList extends StatefulWidget {
  final List<Task> tasks;
  const TaskList({Key? key, required this.tasks}) : super(key: key);

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  //use provider instead passing values

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.tasks.length,
      itemBuilder: (context, int index) {
        return ListTile(
            title: Text(
              widget.tasks[index].name,
              style: TextStyle(
                  decoration: widget.tasks[index].isDone
                      ? TextDecoration.lineThrough
                      : null),
            ),
            trailing: Checkbox(
                value: widget.tasks[index].isDone,
                onChanged: (bool? value) {
                  TaskData.updateTask(widget.tasks[index], value!);
                  setState(() {});
                }),
            onLongPress: () {
              setState(() {
                TaskData.deleteTask(widget.tasks[index]);
              });
            });
      },
    );
  }
}
