import 'package:flutter/material.dart';
import 'package:todolistapp/helpers/drawer_navigation.dart';
import 'package:todolistapp/screens/todo_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'To-Do List',
            style: TextStyle(
              fontWeight: FontWeight.bold
            ),
        ),
      ),
      drawer: DrawerNavigation(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => TodoScreen()));
        },
        child: Icon(Icons.add),
        shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(28.0)
        ),
      ),
    );
  }
}
