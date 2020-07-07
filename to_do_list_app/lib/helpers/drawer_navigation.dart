import 'package:flutter/material.dart';
import 'package:todolistapp/screens/categories_screen.dart';
import 'package:todolistapp/screens/home_screen.dart';

class DrawerNavigation extends StatefulWidget {
  @override
  _DrawerNavigationState createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('Username'),
              accountEmail: Text(
                'email@email.com',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                ),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: ExactAssetImage("assets/images/user.png"),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text(
                "Home",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text("Categories"),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => CategoriesScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
