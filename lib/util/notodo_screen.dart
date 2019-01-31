import 'package:flutter/material.dart';

class NoTodoScreen extends StatefulWidget {
  @override
  _NoTodoScreenState createState() => _NoTodoScreenState();
}

class _NoTodoScreenState extends State<NoTodoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text("noTodo App"),
        centerTitle: true,
        backgroundColor: Colors.black54,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showFormDialog(),
        tooltip: "Add Item",
        child: Icon(Icons.add),
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: <Widget>[
          Card(
            color: Colors.black45,
            child: ListTile(),
            elevation: 3.0,
          ),
          Padding(padding: EdgeInsets.all(5.0)),
          Card(
            child: ListTile(),
            color: Colors.black45,
            elevation: 3.0,
          ),
        ],
      ),
    );
  }

  _showFormDialog() {}
}
