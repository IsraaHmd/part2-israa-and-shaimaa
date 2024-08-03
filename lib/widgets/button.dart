import 'package:flutter/material.dart';

import '../constants/colors.dart';


class MyButtonNavBar extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const MyButtonNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  _MyButtonNavBarState createState() => _MyButtonNavBarState();
}

class _MyButtonNavBarState extends State<MyButtonNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: tdBGColor,
      unselectedItemColor: tdDarkestGrey,
      selectedItemColor: Colors.blue,
      items: const <BottomNavigationBarItem>[

        BottomNavigationBarItem(
          icon: Icon(Icons.note),
          label: 'Notes',
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.check_circle),
          label: 'Tasks',
        ),
      ],
      currentIndex: widget.selectedIndex,
      onTap: widget.onItemTapped,
    );
  }
}


