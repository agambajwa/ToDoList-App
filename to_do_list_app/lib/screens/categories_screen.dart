import 'package:flutter/material.dart';
import 'package:todolistapp/screens/home_screen.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {

  _showFormDialog(BuildContext context) {
    return showDialog(context: context, barrierDismissible: true, builder: (param){
      return AlertDialog(
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(28.0)
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
            textColor: Colors.yellowAccent,
            color: Colors.black26,
            shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)
            ),
          ),
          FlatButton(
            onPressed: (){},
            child: Text('Add'),
            textColor: Colors.black,
            color: Colors.yellowAccent,
            shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)
            ),
          ),
        ],
        title: Text('Add a category'),
        content: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: FlatButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
          },
          child: Icon(Icons.home, color: Colors.black,),
          color: Colors.yellow,
        ),
        title: Text('Categories'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showFormDialog(context);
        },
        child: Icon(Icons.add),
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(28.0)
        ),
      ),
    );
  }
}
