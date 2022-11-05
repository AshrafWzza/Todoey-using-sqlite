//You should separate task.dart and taskData.dart because if you make it one file it make error crash app
//"this error happens when you try to create and read provider immediately"
const String tableTasks = 'tasks';

class TaskFields {
  static const List<String> values = [
    /// Add all fields
    id, name, isDone
  ];

  static const String id = 'id';
  static const String name = 'name';
  static const String isDone = 'isDone';
}

class Task {
  int? id; //id always optional
  String name;
  bool isDone;

  Task({this.id, required this.name, this.isDone = false});

  /* void toggleDone() {
    isDone = !isDone;
  }*/
  Task copyWith({
    int? id,
    String? name,
    bool? isDone,
  }) {
    return Task(
      id: id ?? this.id,
      name: name ?? this.name,
      isDone: isDone ?? this.isDone,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      TaskFields.id: id,
      TaskFields.name: name,
      //TaskFields.isDone: isDone,
      TaskFields.isDone: isDone ? 1 : 0,

      /// Special cases bool,datetime. Only num, String and Uint8List are supported
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map[TaskFields.id] as int,
      name: map[TaskFields.name] as String,
      // isDone: map['isDone'] as bool,
      isDone: map[TaskFields.isDone] == 1,

      /// Special cases bool,datetime. Only num, String and Uint8List are supported
    );
  }
}
