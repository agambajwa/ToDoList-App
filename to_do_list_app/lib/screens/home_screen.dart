import 'package:flutter/material.dart';
import 'package:todolistapp/helpers/drawer_navigation.dart';
import 'package:todolistapp/models/todo.dart';
import 'package:todolistapp/screens/todo_screen.dart';
import 'package:todolistapp/services/todo_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  ToDoService _toDoService;

  List<ToDo> _toDoList = List<ToDo>();

  @override
  initState() {
    super.initState();
    getAllToDos();
  }

  getAllToDos() async {
    _toDoService = ToDoService();
    _toDoList = List<ToDo>();

    var toDos = await _toDoService.readToDo();
    toDos.forEach((toDo) {
      setState(() {
        var model = ToDo();
        model.id = toDo['id'];
        model.name = toDo['name'];
        model.description = toDo['description'];
        model.date = toDo['date'];
        model.category = toDo['category'];
        model.isFinished = toDo['isFinished'];

        _toDoList.add(model);
      });
    });
  }


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
      body: ListView.builder(itemCount: _toDoList.length, itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
          child: Card(
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(_toDoList[index].name ?? 'No name ')
                ],
              ),
              subtitle: Text(
                  _toDoList[index].category ?? 'No category',
                      style: TextStyle(
                  fontStyle: FontStyle.italic,
                ),
              ),
              trailing: Text(_toDoList[index].date ?? 'No date'),
            ),
          ),
        );
      }),
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
