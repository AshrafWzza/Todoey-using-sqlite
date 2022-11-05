import 'package:flutter/material.dart';
import 'package:todoey_sqlite/models/task.dart';
import 'package:todoey_sqlite/models/task_data.dart';
import 'package:todoey_sqlite/screens/tasks_screen.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? nameTask;
    return Column(
      children: [
        const Text(
          'Add Task',
          style: TextStyle(
            fontSize: 50.0,
            fontWeight: FontWeight.w500,
            color: Colors.lightBlueAccent,
          ),
        ),
        TextField(
          autofocus: true,
          textAlign: TextAlign.center,
          decoration: const InputDecoration(
            filled: true,
            hintText: 'Add new task',
          ),
          // use provider instead
          onChanged: (value) {
            nameTask = value;
          },
          //onChanged: (newText) => context.read<Task>().add(newText),
        ),
        TextButton(
          onPressed: () {
            TaskData.add(Task(name: nameTask!));
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const TasksScreen()));
          },
          style: TextButton.styleFrom(
            //Chane textButton Colors
            foregroundColor: Colors.white,
            backgroundColor: Colors.lightBlueAccent,
          ),
          child: const Text(
            'Add',
            style: TextStyle(),
          ),
        ),
      ],
    );
  }
}
