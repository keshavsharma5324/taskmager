
class Task {
  Task({
    this.taskDescription,
    this.status,

  });

  String? taskDescription;
  String? status;
  //String? tasklist;

  factory Task.fromJson(Map<String, dynamic> json) => Task(
      taskDescription: json["task_Description"],
      status: json["status"],
      //tasklist: json["task_list"]
  );

  Map<String, dynamic> toJson() => {
    "task_Description": taskDescription,
    "status": status,
  };
}