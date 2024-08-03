import '../model/notes_list.dart'; // Replace with your correct import
import '../model/todo.dart'; // Replace with your correct import

class AppState {
  // Private constructor
  AppState._privateConstructor();

  // Singleton instance
  static final AppState _instance = AppState._privateConstructor();

  // Factory constructor to return the singleton instance
  factory AppState() {
    return _instance;
  }

  // Your global state variables
  //to store notes
  List<Note> notes = [];
  //to store to do list
  List<ToDo> todos = [];

  // Methods to manipulate state
  void addNote(Note note) {
    notes.add(note);
  }

  void removeNoteById(String id) {
    notes.removeWhere((note) => note.id == id);
  }

  void addToDo(ToDo todo) {
    todos.add(todo);
  }

  void removeToDoById(String id) {
    todos.removeWhere((todo) => todo.id == id);
  }

}
