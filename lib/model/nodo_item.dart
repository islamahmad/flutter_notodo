import 'package:flutter/material.dart';

class NoDoItem extends StatelessWidget {
  String _itemName;
  String _dateCreated;
  int _id;
  String get itemName => _itemName;
  String get dateCreated => _dateCreated;
  int get id => _id;
  NoDoItem(this._itemName, this._dateCreated);
  NoDoItem.map(dynamic obj) {
    this._itemName = obj["itemName"];
    this._dateCreated = obj["dateCreated"];
    if (this._id != null) this._id = obj["id"];
  }
  Map<String, dynamic> toMap() {
    Map map = Map<String, dynamic>();
    map["itemName"] = this.itemName;
    map["dateCreated"] = this._dateCreated;
    if (_id != null) map["id"] = this._id;
    return map;
  }

  NoDoItem.fromMap(Map<String, dynamic> map) {
    this._itemName = map["itemName"];
    this._dateCreated = map["dateCreated"];
    if (map["id"] != null) this._id = map["id"];
  }

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
