import 'package:flutter/material.dart';
import 'package:sisamob3/util/db_helper.dart';

class Dropdown extends StatefulWidget {
  final String _key;
  final List<DropdownMenuItem<String>> _list;
  final int _value;
  final Function update; // Add this line.

  Dropdown(this._key, this._list, this._value,
      {this.update = null}); // Fix this line.

  @override
  _DropdownState createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  var _chosenValue;
  final db = DbHelper.instance;
  List<DropdownMenuItem<String>> list;

  @override
  void initState() {
    _chosenValue = widget._value.toString();
    list = widget._list;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //if (list == null) {
    //  return CircularProgressIndicator();
    // }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: DropdownButton<String>(
        hint: Text(widget._key),
        value: _chosenValue,
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 24,
        isExpanded: true,
        items: list,
        onChanged: (String value) {
          // Fix start.
          setState(() {
            _chosenValue = value;
          });
          if (widget.update != null) {
            //(widget._key == 'Favourite Animal' && _chosenValue == 'Cat')?
            widget.update(_chosenValue);
            //   : widget.update(false);
          }
          // Fix end.
        },
      ),
    );
  }
}
