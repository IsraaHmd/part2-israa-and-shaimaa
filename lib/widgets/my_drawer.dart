import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../global.dart';
class myDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Drawer(
      backgroundColor: Colors.white,
      // The drawer's child is a ListView which is a scrollable list of widgets
      child: ListView(
        // Sets the padding of the list view to zero
        padding: EdgeInsets.zero,
        children: [

          SizedBox(height: 60,),

          ListTile(
            // Icon and text
            leading: Icon(Icons.person_rounded,color: tdBlue,),
            title: Text('Username: ${User.username}', style: TextStyle(fontWeight: FontWeight.bold, color: tdBlack)),
          ),
          SizedBox(height: 20,),

          ListTile(
            // Icon and text
            leading: Icon(Icons.home,color: tdBlue,),
            // Sets an icon to the left of the list item text
            title: Text('Home', style: TextStyle(color: tdBlack)),
            // Text beside the icon
            onTap: () {
              Navigator.pushNamed(
                  context, '/notes'); // Function to take me to the page I want
            },
          ),

          ListTile(
            leading: Icon(Icons.app_registration,color: tdBlue,),
            title: Text('Register Another Account', style: TextStyle(color: tdBlack)),
            onTap: () {
              Navigator.pushNamed(context, '/register');
            },
          ),
          ListTile(
            leading: Icon(Icons.logout,color: tdBlue,),
            title: Text('Logout',style: TextStyle(color: tdBlack)),
            onTap: () {
              User.id = '';
              User.username ='';
              print('${User.id},${User.username}');
              Navigator.pushNamed(context, '/');

            },
          ),
        ],
      ),
      
    );
  }
}
/*  ListTile(
            leading: Icon(Icons.login,color: tdBlue,),
            title: Text('Login', style: TextStyle(color: tdBlack)),
            onTap: () {
              Navigator.pushNamed(context, '/login');
            },
          ),*/
