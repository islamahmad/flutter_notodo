import 'package:flutter/material.dart';

class NoTodoScreen extends StatefulWidget {
  @override
  _NoTodoScreenState createState() => _NoTodoScreenState();
}

class _NoTodoScreenState extends State<NoTodoScreen> {
  final TextEditingController _tec = TextEditingController();
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
      body: Column(),
    );
  }

  _showFormDialog() {
    var alert = AlertDialog(
      content: Row(
        children: <Widget>[
          Expanded(
              child: TextField(
            controller: _tec,
            autocorrect: true,
            decoration: InputDecoration(
              labelText: 'Item',
              hintText: 'e.g. dont buy stuff',
              icon: Icon(Icons.save),
            ),
          ))
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () => _handleSubmit(_tec.text),
          child: Icon(Icons.save_alt),
        ),
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Icon(Icons.cancel),
        )
      ],
    );
    showDialog(
        context: context,
        builder: (_) {
          return alert;
        });
  }

  _handleSubmit(String text) async {}
}
