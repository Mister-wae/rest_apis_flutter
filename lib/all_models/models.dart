class Todo {
  String title;
  bool completed;
  String description;
  String id;

  // constructor
  Todo({
    required this.title,
    required this.completed,
    required this.description,
    required this.id,
  });

  // JavaScript Oriented Notation *JSON*
  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        title: json["title"],
        completed: json["completed"],
        description: json["description"],
        id: json["id"],
      );
}

// weekdays list
List<String> weekdays = [
  "Monday", // 0
  "Tuesday", // 1
  "Wednesday", // 2
  "Thursday", // 3
  "Friday", // 4
  "Saturday", // 5
  "Sunday", // 6
];
