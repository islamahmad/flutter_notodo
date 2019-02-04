import 'package:flutter/material.dart';
import 'package:notodo/model/nodo_item.dart';
import 'database_helper.dart';

class NoTodoScreen extends StatefulWidget {
  @override
  _NoTodoScreenState createState() => _NoTodoScreenState();
}

class _NoTodoScreenState extends State<NoTodoScreen> {
  final TextEditingController _tec = TextEditingController();
  var db = databaseHelper(); 
  void _handleSubmitted(String text) async {
    _tec.clear();
    NoDoItem item = NoDoItem(text, DateTime.now().toIso8601String());
    int savedID = await db.saveRecord(item); 
    print("saved ID is : "+ savedID.toString()); 
    //_readNoDoList();
  }
  _readNoDoList() async{
    List items = await db.getAllRecords();
    items.forEach((item) {
      NoDoItem noDoItem = NoDoItem.map(item);
      print( noDoItem.id.toString() + " ${noDoItem.itemName}");
    });
  }
  @override
  void initState(){
    super.initState();
    _readNoDoList();
  }
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
        onPressed:
        // null, 
        () => _showFormDialog(),
        tooltip: "Add Item",
        child: Icon(Icons.add),
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
      ),
      body: Column(),
    );
  }

  _showFormDialog() {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: <Widget>[
          Expanded(
              child: TextField(
            controller: _tec,
            autofocus: true,
            decoration: InputDecoration(
              labelText: 'Item',
              hintText: 'e.g. dont buy stuff',
              icon: Icon(Icons.save),
            ),
          ),
          ),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () 
          { 
            _handleSubmitted(_tec.text);
            _tec.clear()  ; 
          },
          child: Icon(Icons.save_alt),
        ),
        FlatButton(
          onPressed: () { 
            Navigator.pop(context);
          },
          child: Icon(Icons.cancel),
        )
      ],
    );
    showDialog(
        context: context,
        builder: (_) {
          return alert;
        },
        );
  }

  
}
