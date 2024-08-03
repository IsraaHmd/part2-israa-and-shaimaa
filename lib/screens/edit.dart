import 'package:flutter/material.dart';
import 'package:note_and_todo_project/constants/colors.dart';

import '../model/notes_list.dart';

class EditScreen extends StatefulWidget {
  final Note? note;//receives the value from home_experimental.dart of the selected note
  const EditScreen({super.key, this.note});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController _titleController = TextEditingController();//initialize the title
  TextEditingController _contentController = TextEditingController();//initialize the content

  @override
  void initState() {
    // TODO: implement initState
    if (widget.note != null) {
      _titleController = TextEditingController(text: widget.note!.title);//display the title of the selected note
      _contentController = TextEditingController(text: widget.note!.content);//display the content of the selected note
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,//tdGrey,//background color grey
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);//to return to notes page
                  },
                  padding: const EdgeInsets.all(0),
                  icon: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: tdBlue.withOpacity(.8),//Colors.grey.shade800.withOpacity(.8),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                    ),
                  ))
            ],
          ),
          Expanded(
              child: ListView(
                children: [
                  TextField(
                    controller: _titleController,//to collect the user input
                    style: const TextStyle(color: tdBlack, fontSize: 30),
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Title',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 30)),
                  ),
                  TextField(
                    controller: _contentController,//to collect the user input
                    style: const TextStyle(
                      color: tdBlack,
                    ),
                    maxLines: null,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Type something here',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        )),
                  ),
                ],
              ))
        ]),
      ),
      floatingActionButton: FloatingActionButton(//button to save the note that we write
        onPressed: () {
          Navigator.pop(//to return back to notes page when we click on it and save info
              context, [_titleController.text, _contentController.text]);
        },
        elevation: 10,
        backgroundColor: tdBlue,//Colors.grey.shade800,
        child: const Icon(Icons.save, color:Colors.white ),
      ),
    );
  }
}