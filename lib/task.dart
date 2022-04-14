class Task {
  final int userId;
  final int id;
  final String title;
  final bool completed;

Task ({
  required this.userId,
  required this.id,
  required this.title,
  required this.completed,
}) ;

factory Task.fromJson(Map<String, dynamic> json) {
  return Task(
    userId: json['userId'] as int,
    id: json['id']as int,
    title: json['title']as String,
    completed: json['completed']as bool,);
}
}