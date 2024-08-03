//for the task itself that is the todotext is going to be the title, the id is what we will use to
//delete and uniquely identify the task, and isDone to check/uncheck it
//this class will be useful to create the todolist Item since it is a part of it

class ToDo {
  String? id;
  String? todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

}
