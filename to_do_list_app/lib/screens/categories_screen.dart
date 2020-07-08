import 'package:flutter/material.dart';
import 'package:todolistapp/models/category.dart';
import 'package:todolistapp/screens/home_screen.dart';
import 'package:todolistapp/services/category_service.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  var _categoryNameController = TextEditingController();
  var _categoryDescController = TextEditingController();

  var _editNameController = TextEditingController();
  var _editDescController = TextEditingController();

  var category;

  var _category = Category();
  var _categoryService = CategoryService();

  final GlobalKey<ScaffoldState> _globalKey = new GlobalKey<ScaffoldState>();

  List<Category> _categoryList = List<Category>();

  @override
  void initState() {
    super.initState();
    getAllCategories();

  }

  getAllCategories() async {
    _categoryList = List<Category>();
    var categories = await _categoryService.readCategories();
    categories.forEach((category){
      setState(() {
        var categoryModel = Category();
        categoryModel.name = category['name'];
        categoryModel.description = category['description'];
        categoryModel.id = category['id'];
        _categoryList.add(categoryModel);
      });
    });
  }

  editCategory(BuildContext context, categoryID) async {
    category = await _categoryService.readCategoryByID(categoryID);
    setState(() {
      _editNameController.text = category[0]['name']??'No name';
      _editDescController.text = category[0]['description']??'No description';
    });
    _editFormDialog(context);
  }

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
            onPressed: () async {
              _category.name = _categoryNameController.text;
              _category.description = _categoryDescController.text;

              var result = await _categoryService.saveCategory(_category);
              if(result > 0) {
                print(result);
                Navigator.pop(context);
                getAllCategories();
                showSuccessSnackBar('Added successfully!');
              }
            },
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
                controller: _categoryNameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
              ),
              TextField(
                controller: _categoryDescController,
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
  _editFormDialog(BuildContext context) {
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
            onPressed: () async {
              _category.id = category[0]['id'];
              _category.name = _editNameController.text;
              _category.description = _editDescController.text;

              var result = await _categoryService.updateCategory(_category);
              if(result > 0) {
                print(result);
                Navigator.pop(context);
                getAllCategories();
                showSuccessSnackBar('Updated successfully!');
              }
            },
            child: Text('Update'),
            textColor: Colors.black,
            color: Colors.yellowAccent,
            shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)
            ),
          ),
        ],
        title: Text('Edit a category'),
        content: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextField(
                controller: _editNameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
              ),
              TextField(
                controller: _editDescController,
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

  showSuccessSnackBar(message) {
    var _snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(
        color: Colors.yellowAccent
        ),
      ),
      action: SnackBarAction(
          label: 'Hide',
          textColor: Colors.yellowAccent,
          onPressed: () {

          }),
      backgroundColor: Colors.black,
    );
    _globalKey.currentState.showSnackBar(_snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
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
      body: ListView.builder(itemCount: _categoryList.length, itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
          child: Card(
            child: ListTile(
              leading: IconButton(
                icon: Icon(Icons.edit_attributes),
                onPressed: (){
                  editCategory(context, _categoryList[index].id);
                },
              ),
              title: Text(_categoryList[index].name),
              subtitle: Padding(
                padding: EdgeInsets.only(top: 5.0, bottom: 7.0),
                child: Text(
                    _categoryList[index].description,
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete_sweep),
                color: Colors.yellowAccent,
                onPressed: (){},
              ),
            ),
          ),
        );
      }),
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
