import 'package:flutter/material.dart';

import 'db_helper.dart';

class Auxiliar {
  static Future<List<DropdownMenuItem<String>>> loadData(
      String tabela, String filtro) async {
    final db = DbHelper.instance;
    List<DropdownMenuItem<String>> list = [];
    List<Map> ret;
    list.add(DropdownMenuItem<String>(
      child: Text(
        '--Selecione--',
        style: new TextStyle(
          fontSize: 12.0,
        ),
      ),
      value: '0',
    ));
    ret = await db.qryCombo(tabela, filtro);

    ret.map((map) {
      return getDropDownWidget(map);
    }).forEach((element) {
      list.add(element);
    });
    return list;
  }

  static DropdownMenuItem<String> getDropDownWidget(Map<String, dynamic> map) {
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
