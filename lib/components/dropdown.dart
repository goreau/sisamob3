import 'package:flutter/material.dart';

import '../util/db_helper.dart';
/*
class DropDown extends StatefulWidget {
  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  String nomeItem = "";
  var _itens = ['Santos', 'Porto Alegre', 'Campinas', 'Rio de Janeiro'];
  var _itemSelecionado = 'Santos';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DropDownButton"),
        backgroundColor: Colors.red,
      ),
      body: criaDropDownButton(),
    );
  }

  criaDropDownButton() {
    print('entrou');
    return Container(
      child: Column(
        children: <Widget>[
          Text("Selecione a cidade"),
          TextField(
            onSubmitted: (String userInput) {
              setState(() {
                debugPrint('chamei setState');
                nomeItem = userInput;
              });
            },
          ),
          DropdownButton<String>(
              items: _itens.map((String dropDownStringItem) {
                return DropdownMenuItem<String>(
                  value: dropDownStringItem,
                  child: Text(dropDownStringItem),
                );
              }).toList(),
              onChanged: (String novoItemSelecionado) {
                _dropDownItemSelected(novoItemSelecionado);
                setState(() {
                  this._itemSelecionado = novoItemSelecionado;
                });
              },
              value: _itemSelecionado),
          Text(
            "A cidade selecionada foi \n$_itemSelecionado",
            style: TextStyle(fontSize: 20.0),
          ),
        ],
      ),
    );
  }

  void _dropDownItemSelected(String novoItem) {
    setState(() {
      this._itemSelecionado = novoItem;
    });
  }
}*/

class Dropdown extends StatefulWidget {
  @override
  _DropdownState createState() {
    return _DropdownState();
  }
}

class _DropdownState extends State<Dropdown> {
  String _value;
  final dbHelper = DbHelper.instance;
  //Map<String, dynamic> _itens = await dbHelper.combo('municipio');
  final _itens = {
    '12': 'Santos',
    '18': 'Porto Alegre',
    '123': 'Campinas',
    '456': 'Rio de Janeiro'
  };
  /* _DropdownState() {
    _itens = dbHelper.combo('municipio');
  }*/

  List<DropdownMenuItem<String>> menuItems = List();
  //Map<String, dynamic> _itens;
  //Future<void> popula() async {

  //}

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
