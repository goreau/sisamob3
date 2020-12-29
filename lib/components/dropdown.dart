import 'package:flutter/material.dart';

class Dropdown extends StatefulWidget {
  @override
  _DropdownState createState() {
    return _DropdownState();
  }
}

class _DropdownState extends State<Dropdown> {
  String _value;
  var _itens = {
    '12': 'Santos',
    '18': 'Porto Alegre',
    '123': 'Campinas',
    '456': 'Rio de Janeiro'
  };

  List<DropdownMenuItem<String>> menuItems = List();

  @override
  Widget build(BuildContext context) {
    for (String key in _itens.keys) {
      menuItems.add(DropdownMenuItem<String>(
        child: Text(_itens[key]),
        value: key,
      ));
    }
    return Center(
      child: DropdownButton<String>(
        items: menuItems,
        onChanged: (String value) {
          setState(() {
            _value = value;
            print(value);
          });
        },
        hint: Text('Select Item'),
      ),
    );
  }
}
