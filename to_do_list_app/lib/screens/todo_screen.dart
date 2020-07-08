import 'package:flutter/material.dart';
import 'package:todolistapp/services/category_service.dart';

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  var todoNameController = TextEditingController();
  var todoDescController = TextEditingController();
  var todoDateController = TextEditingController();

  var _selectedCategory;
  var _categories = List<DropdownMenuItem>();


  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  _loadCategories() async {
    var _categoryService = CategoryService();
    var categories = await _categoryService.readCategories();
    categories.forEach((category) {
      setState(() {
        _categories.add(DropdownMenuItem(
          child: Text(category['name']),
          value: category['name'],
        ));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create a new to-do'),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 20.0, left: 16.0, right: 16.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 12.0),
              child: TextField(
                controller: todoNameController,
                decoration: InputDecoration(
                    labelText: "Name",
                    hintText: "Buy mangoes",
                    fillColor: Colors.black54,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.yellowAccent,
                            width: 2.0
                        )
                    )
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 12.0),
              child: TextField(
                  controller: todoDescController,
                  decoration: InputDecoration(
                      labelText: "Description",
                      hintText: "Alphonso mangoes from nearby supermarket",
                      fillColor: Colors.black54,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.yellowAccent,
                              width: 2.0
                          )
                      )
                  ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 12.0),
              child: TextField(
                  controller: todoDateController,
                  decoration: InputDecoration(
                      labelText: "Date",
                      hintText: "22-07-2020",
                      fillColor: Colors.black54,
                      prefixIcon: InkWell(
                        onTap: () {},
                        child: Icon(Icons.date_range),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.yellowAccent,
                              width: 2.0
                          )
                      )
                  ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 12.0),
              child: DropdownButtonFormField(
                value: _selectedCategory,
                items: _categories,
                hint: Text('Category'),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: FlatButton(
                onPressed: () {},
                child: Text('Save'),
                textColor: Colors.black,
                color: Colors.yellowAccent,
                shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
