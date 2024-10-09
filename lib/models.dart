class Todo {
  String title;
  bool completed;
  int createdAt;
  String id;

  // constructor
  Todo({
    required this.title,
    required this.completed,
    required this.createdAt,
    required this.id,
  });

  // JavaScript Oriented Notation *JSON*
  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        title: json["title"],
        completed: json["completed"],
        createdAt: json["created_at"],
        id: json["id"],
      );
}
