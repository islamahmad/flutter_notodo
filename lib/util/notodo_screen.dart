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
  final List <NoDoItem> _itemList = <NoDoItem>[]; // must initialize with empty list becasue it's final  
  void _handleSubmitted(String text) async {
    _tec.clear();
    NoDoItem item = NoDoItem(text, DateTime.now().toIso8601String());
    //int savedID = await db.saveRecord(item); 
    var saved = await db.insertRecordFromList([text,DateTime.now().toIso8601String()]);
    print("saved ID is : "+ saved.toString()); 
    var addedItem = await db.findRecord(saved);
    print(addedItem.itemToString());
    setState(() {
      _itemList.insert(0, addedItem); 
    });
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
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              reverse: false,
              itemCount: _itemList.length,
              itemBuilder: (_, int index){
                return Card(
                  color: Colors.white10,
                  child: 
                    ListTile(
                      title: _itemList[index],
                      onLongPress: ()=> debugPrint("${_itemList[index].dateCreated}"),
                      trailing: 
                        Listener(
                          key: Key(_itemList[index].itemName),
                          child: 
                            Icon(
                              Icons.remove_circle, 
                              color: Colors.redAccent,
                            ),
                            onPointerDown: (PointerEvent) {
                              debugPrint("onPointerDown Event happened");
                            },
                        ),
                    ),
                );
              } ,
          ),
          ),
          Divider(
            height: 1.0,
          ),
        ],
      ),
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
