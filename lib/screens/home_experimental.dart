import 'package:flutter/material.dart';
import '../global.dart';
import '../model/todo.dart';
import '../constants/colors.dart';
import '../widgets/my_drawer.dart';
import '../widgets/todolist_items.dart';
import '../widgets/button.dart';
import 'home_notes.dart';
import 'dart:convert' as convert; // Import the convert package
import 'package:http/http.dart' as http;
import 'app_state.dart';
//the homepage here just includes the todo list
class HomeExperimental extends StatefulWidget {
  HomeExperimental({super.key});

  @override
  State<HomeExperimental> createState() => _HomeExperimentalState();
}

class _HomeExperimentalState extends State<HomeExperimental> {

  //final todosList = ToDo.todoList(); ==> used before la n3rod tasks sebten awal ma ynfata7 el app


  final List<ToDo>  todosList = [];// variable to store the created tasks

  List<ToDo> _foundToDo = [];// to be used for search purposes

  final _todoController = TextEditingController(); // A controller for the textField

  bool _isDisposed = false;//just for memory leaks
  /*@override
  void initState() {
    super.initState();
    _foundToDo = AppState().todos; // Use AppState singleton
  }
*/
  @override
  void initState() {
    super.initState();
    fetchTasks().then((_) {
      if (!_isDisposed) { // Check if the widget is still mounted
        setState(() {
          _foundToDo = AppState().todos;
        });
      }
    }).catchError((error) {
      print('Error fetching tasks: $error');
    });
  }

  @override
  void dispose() {
    _isDisposed = true;
    _todoController.dispose();
    super.dispose();
  }

  Future<void> _addToDoItem(String toDo) async {
    if (toDo.isEmpty) return;

    final url = Uri.parse('http://mobilenoteproject.atwebpages.com/addtodo.php');
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: convert.jsonEncode(<String, dynamic>{
          'user_id': int.parse(User.id),
          'todo_text': toDo,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = convert.jsonDecode(response.body);
        if (responseData['status'] == 'success') {
          _todoController.clear();
          await fetchTasks(); // Fetch tasks again after adding the new task==> await is im
        } else {
          print('Error: ${responseData['message']}');
        }
      } else {
        print('Server error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }

/*-------------------------------Fetch tasks ----------------------------------*/

  Future<void> fetchTasks() async {
    try {
      final response = await http.post(
        Uri.parse('http://mobilenoteproject.atwebpages.com/fetchtasks.php'),
        headers: {"Content-Type": "application/json"},
        body: convert.jsonEncode({
          'user_id': int.parse(User.id),
        }),
      );

      if (response.statusCode == 200) {
        final List<dynamic> tasksData = convert.jsonDecode(response.body);
        AppState().todos.clear();


        for (var task in tasksData) {
          AppState().addToDo(ToDo(
            id: task['id'].toString(),
            todoText: task['todo_text'],
            isDone: task['is_done'] == 1,
          ));
        }


        print('Tasks fetched: ${AppState().todos.length}');


        if (!_isDisposed) {
          setState(() {
            _foundToDo = AppState().todos;
          });
        }
      } else {
        print('Error: Failed to fetch tasks, status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }
/*-------------------------------updating tasks---------------------*/
  Future<void> updateTask(String taskId, bool isDone) async {
    final response = await http.post(
      Uri.parse('http://mobilenoteproject.atwebpages.com/updatetask.php'),
      headers: {"Content-Type": "application/json"},
      body: convert.jsonEncode({
        'id': taskId,
        'is_done': isDone ? '1' : '0', // sending '1' for true and '0' for false
      }),
    );

    if (!mounted) return;

    if (response.statusCode == 200) {
      final result = convert.jsonDecode(response.body);
      if (result['status'] == 'success') {
        print('Task updated successfully');
      } else {
        print('Error updating task: ${result['message']}');
      }
    } else {
      print('Failed to update task');
    }
  }
/*----------------------Delete task------------------*/
  Future<void> deleteTask(String taskId) async {
    final response = await http.post(
      Uri.parse('http://mobilenoteproject.atwebpages.com/deletetask.php'), // Make sure the URL is correct
      headers: {
        'Content-Type': 'application/json',
      },
      body: convert.jsonEncode({
        'id': taskId,
      }),
    );

    if (response.statusCode == 200) {
      final result = convert.jsonDecode(response.body);
      if (result['status'] == 'success') {
        print('Task deleted successfully');
      } else {
        print('Error deleting task: ${result['message']}');
      }
    } else {
      print('Failed to delete task: ${response.statusCode}');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //the background having the same color as the appbar:
        backgroundColor: Colors.white,//tdBGColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0, //removes the shadow under the appbar
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                color: tdBlue,
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),

        ),
        /*----------------------------Done with appBar-----------------------------------*/
      drawer: myDrawer(),
      body: Stack(
                children: [
            Container(
            //padding for container
            child: Column(children: [
                Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
            ),
            child: Column(
              children: [
                Align(
                  alignment:
                  Alignment.topLeft, // Adjust this alignment as needed
                  child: Container(
                    //Heading 'My Tasks'
                    margin: EdgeInsets.only(
                      top: 30,
                      bottom: 20,
                      left: 0,
                    ),
                    child: Text(
                      'My Tasks',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          color: tdBlack),
                    ),
                  ),
                ),
                searchBox(),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
          //it doesn't work now, to make it work shel el // mn 7ad onchange

          /*--------------Viewing tasks------------*/
          Expanded(
          child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.only(
          bottom: 50), // Add padding to avoid overlap with button
          children: [

          Container(
          margin: EdgeInsets.only(
          top: 20,
          bottom: 20,
          left: 0,
          ),
          ),
          //To do list items:
          for (ToDo todoo in _foundToDo) //TO desplay them from the most recent added to the leat recent use _foundToDo with .reversed
          ToDoItem(
          todo: todoo,
          onToDoChanged: _handleToDoChange,
          onDeleteItem: _deleteToDoItem,
          ),
          ]),
          ),
          ),
          ])),
          /*------------------------------------------Done with tasks-----------------------------------*/
          /*------------------------------------------ Add text field and button-----------------------------------*/
          Align(
          alignment: Alignment.bottomRight, // Keep it bottomRight
          child: Container(
          margin: EdgeInsets.only(
          bottom: 20,
          right: 20, // Keep right margin
          ),
          child: ElevatedButton(
          child: Icon(
          Icons.add,
          size: 40,
          color: Colors.white,
          ),
          onPressed: () {
          // Call a function to show the new UI component with TextField
          _showAddTaskDialog(context);
          },
          style: ElevatedButton.styleFrom(
          shape: CircleBorder(), // Make the button circular
          backgroundColor: tdBlue,// tdDarkestGrey,
          minimumSize: Size(60, 60),
          elevation: 10,
          ),
          ),
          ),
          ),
          ],
    ),
/*----------------------Bottom nav bar-----------*/
      bottomNavigationBar: MyButtonNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onButtonNavItemTapped,
      ),
    );

  }
/*--------------------------------------Some methods--------------------------------*/
  //For buttom navbar:
  int _selectedIndex = 1; // Default index for 'Tasks'

  void _onButtonNavItemTapped(int index) {
    setState(() {
      if (index != _selectedIndex) { // Only navigate if the index changes
        _selectedIndex = index;
        if (index == 0) {
          // Navigate to HomeNotes page
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => NotesHome()),
          );
        } else if (index == 1) {
          // Navigate to HomeExperimental page (this page)
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeExperimental()),
          );
        }
        // Add navigation logic for other items if needed
      }
    });
  }

  //for other functionalities
  //the funciton that shows the text field to add the task
  void _showAddTaskDialog(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: tdBGColor,
      context: context,
      isScrollControlled: true,
      builder: (context) => FractionallySizedBox(
        heightFactor: 0.5, // Adjust this factor as needed
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _todoController,
                  decoration: InputDecoration(
                    hintText: 'Input new task here',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  child: Text(
                    'Add',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  onPressed: () {
                    _addToDoItem(_todoController.text);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: tdBlue,
                    minimumSize: Size(double.infinity, 50),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //To check and uncheck the task:
  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
    updateTask(todo.id!, todo.isDone); // Update task on the server
  }
  //the function that handles the functionality of delete button
  void _deleteToDoItem(String? id) {
    if (id == null) {
      print('Cannot delete task: ID is null');
      return;
    }

    setState(() {
      _foundToDo.removeWhere((todo) => todo.id == id);//delete locally
    });
    deleteTask(id); // Delete task from the server
  }

  void _runFilter(String enteredKeyword) {
    if (!mounted) return;
    List<ToDo> results = [];
    // if the user did not search for anything
    if (enteredKeyword.isEmpty) {
      results = AppState().todos; // Use AppState for default view
    }
    // if they entered something
    else {
     // results = _foundToDo ==> replaced with below to solve issue
      results = AppState().todos
          .where((item) => item.todoText!
          .toLowerCase()
          .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundToDo = results;
    });
  }



  Widget searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: tdBGColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }

}

