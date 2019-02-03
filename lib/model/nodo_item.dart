import 'package:flutter/material.dart';

class NoDoItem extends StatelessWidget {
  String _itemName;
  String _dateCreated;
  int _id;
  String get itemName => _itemName;
  String get dateCreated => _dateCreated;
  int get id => _id;
  // default constructor
  NoDoItem(this._itemName, this._dateCreated);
  // named sonctructors to be compatible with SQFlite
  NoDoItem.map(dynamic obj) {
    // this is a named constructor, it will use a dynamic object
    // to return an object of type NoDoItem
    this._itemName = obj["itemName"];
    this._dateCreated = obj["dateCreated"];
    if (this._id != null) this._id = obj["id"];
  }
  // another named constructor that will be used to convert
  // a map to an object of type NoToDoItem
  NoDoItem.fromMap(Map<String, dynamic> map) {
    this._itemName = map["itemName"];
    this._dateCreated = map["dateCreated"];
    if (map["id"] != null) this._id = map["id"];
  }
  // this is a method that can be called by an object of type NoToDoItem to
  // convert it to a Map that is compatible with SQFlite package insert method
  Map<String, dynamic> toMap() {
    Map map = Map<String, dynamic>();
    map["itemName"] = this.itemName;
    map["dateCreated"] = this._dateCreated;
    if (_id != null) map["id"] = this._id;
    return map;
  }

  // this is me, not in the course
  String itemToString() {
    return 'NoDoItem{_itemName: $_itemName, _dateCreated: $_dateCreated, _id: $_id}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            _itemName,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16.9,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 5.0),
            child: Text(
              "Created On: " + _dateCreated,
              style: TextStyle(
                color: Colors.white70,
                fontStyle: FontStyle.italic,
                fontSize: 13.7,
              ),
            ),
          )
        ],
      ),
    );
  }
}
