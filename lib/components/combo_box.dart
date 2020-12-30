import 'package:flutter/material.dart';
import 'package:sisamob3/util/db_helper.dart';
import 'package:sisamob3/util/storage.dart';

class ComboBox extends StatefulWidget {
  final tab;
  final val;

  const ComboBox(this.tab, this.val);

  @override
  _ComboBoxState createState() => _ComboBoxState();
}

class _ComboBoxState extends State<ComboBox> {
  String _value = '';
  String _screenStage;

  DropdownButton<String> combo;

  List<DropdownMenuItem<String>> list;

  _setvalue(String value) {
    setState(() {
      _value = value;
      Storage.insere(widget.tab, _value);
    });
  }

  @override
  void initState() {
    super.initState();
    _value = widget.val.toString();
    _screenStage = "loading";
    _onceSetupDropDown();
  }

  _onceSetupDropDown() {
    list = [];

    list.add(DropdownMenuItem<String>(
      child: Text(
        '--Selecione--',
        style: new TextStyle(
          fontSize: 12.0,
        ),
      ),
      value: '0',
    ));
    final dbHelper = DbHelper.instance;
    dbHelper.qryCombo(widget.tab).then((listMap) {
      listMap.map((map) {
        return getDropDownWidget(map);
      }).forEach((element) {
        list.add(element);
      });
      _screenStage = "loaded";
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: _screenStage == "loaded"
            ? DropdownButton<String>(
                hint: Text(
                  '-- Selecione --',
                  style: new TextStyle(
                    fontSize: 12.0,
                  ),
                ),
                items: list,
                onChanged: _setvalue,
                isExpanded: true,
                value: _value,
              )
            : CircularProgressIndicator(),
      ),
      // ),
    );
  }

  DropdownMenuItem<String> getDropDownWidget(Map<String, dynamic> map) {
    return DropdownMenuItem<String>(
      child: Text(
        map['nome'],
        style: new TextStyle(
          fontSize: 12.0,
        ),
      ),
      value: map['id'].toString(),
    );
  }
}
