import 'package:flutter/material.dart';
import 'package:todoey_sqlite/models/task.dart';
import 'package:todoey_sqlite/models/task_database.dart';
import 'package:todoey_sqlite/screens/add_task_screen.dart';
import 'package:todoey_sqlite/widgets/task_list.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  late List<Task> tasks;
  bool isLoading = false;
  @override
  void dispose() {
    TasksDatabase.instance.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    //firstInitiation();
    refreshTasks();
  }

  // firstInitiation() {
  //   TaskData.add(Task(name: 'zzzzzzzzzzzzzzzzz'));
  // }

  Future refreshTasks() async {
    setState(() => isLoading = true);

    tasks = await TasksDatabase.instance.readAllTasks();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.lightBlueAccent,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // //Receiving value from pop()-> addTaskScreen
          // use provider instead
          // var nameTask = await showModalBottomSheet(
          await showModalBottomSheet(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                  bottomRight: Radius.zero,
                  bottomLeft: Radius.zero),
            ),
            isScrollControlled: true,
            context: context,
            builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: const AddTaskScreen(),
              ),
            ),
          );
          refreshTasks();
        },
        backgroundColor: Colors.lightBlueAccent,
        child: const Icon(Icons.add),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.lightBlueAccent,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 30.0,
                        child: Icon(
                          Icons.list,
                          size: 40.0,
                          color: Colors.lightBlueAccent,
                        ),
                      ),
                      Expanded(child: Container()),
                      IconButton(
                          icon: const Icon(Icons.lightbulb), onPressed: () {}),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Text(
                    'Todoey',
                    style: TextStyle(
                      fontSize: 45.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '${tasks.length} Tasks',

                    // style: TextStyle(
                    //   color: Colors.white,
                    // ),
                  ),
                ],
              ),
            ),
          ),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : tasks.isEmpty
                  ? const Center(
                      child: Text('No Tasks yet!'),
                    )
                  : Expanded(
                      child: TaskList(tasks: tasks),
                    ),
        ],
      ),
    );
  }
}
