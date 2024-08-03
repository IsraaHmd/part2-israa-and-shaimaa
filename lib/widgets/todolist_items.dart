import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../model/todo.dart';

class ToDoItem extends StatelessWidget {
  final ToDo todo;
  final onToDoChanged;
  final onDeleteItem;

  const ToDoItem({
    Key? key,
    required this.todo,
    required this.onToDoChanged,
    required this.onDeleteItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20), // each task is seperated from the other
      child: ListTile(
        /*list tile encapsulates a single row of data and can be
        customized to include text, icons, images,
        and interactive elements like checkboxes and radio buttons*/
        onTap:(){
          onToDoChanged(todo);
        },

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),

        ),

        tileColor: tdBGColor,//bg color of the tile
        leading: Icon(
            todo.isDone? Icons.check_box: Icons.check_box_outline_blank,
            color:tdBlack),
        //title of the task
        title: Text(todo.todoText!, style: TextStyle(fontSize:16 ,color: tdBlack,
            //so that if it is checked then a line would appear through the words:
            decoration: todo.isDone? TextDecoration.lineThrough: null, decorationColor: tdBlack)),

        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical:5),

        //the delete icon
        trailing: Container(
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: tdBlue,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            padding:EdgeInsets.all(0),//center
            color: Colors.white,
            iconSize: 18,
            icon: Icon(Icons.delete),
            onPressed: (){
              onDeleteItem(todo.id);
            },
            /*onPressed: () {
              // print('Clicked on delete icon');
              onDeleteItem(todo.id);
            },*/
          ),
        ),
      ),
    );
  }
}
