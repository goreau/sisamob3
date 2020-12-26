import 'dart:convert';
import 'package:http/http.dart' as http;
import 'db_helper.dart';

class Comunica {
  final dbHelper = DbHelper.instance;

  List<String> entidades = [
    "municipio",
    "area",
    "censitario",
    "quarteirao",
    "imovel",
    "grupo_rec",
    "tipo_rec",
    "atividade"
  ];

  Future fetchDados(int tipo, int nivel, String local) async {
    String _url = '';
    if (tipo == 1) {
      _url =
          'http://200.144.1.24/dados/Cadastros.php?tipo=sistema&nivel=1&id=1';
    } else if (tipo == 2) {
      _url =
          'http://200.144.1.24/dados/Cadastros.php?tipo=cadastro&nivel=$nivel&id=$local';
    }
    final response = await http.get(_url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final dados = data['dados'];

      for (var linha in entidades) {
        final obj = dados[linha];
        if (obj == null) {
          continue;
        }
        Map<String, dynamic> row = new Map();
        if (linha == 'municipio') {
          for (var campo in obj) {
            row['id_municipio'] = campo['id_municipio'];
            row['nome'] = campo['nome'];
            row['codigo'] = campo['codigo'];
            //  print(row);
            int id = await dbHelper.insert(row, linha);
            print('Id mun inserido $id');
          }
        } else if (linha == 'area') {
          for (var campo in obj) {
            row['id_area'] = campo['id_area'];
            row['id_municipio'] = campo['id_municipio'];
            row['codigo'] = campo['codigo'].toString().trim();
            //print(row);
            int id = await dbHelper.insert(row, linha);
            print('Id area inserido $id');
          }
        } else if (linha == 'censitario') {
          for (var campo in obj) {
            row['id_censitario'] = campo['id_censitario'];
            row['id_area'] = campo['id_area'];
            row['codigo'] = campo['codigo'].toString().trim();
            // print(row);
            int id = await dbHelper.insert(row, linha);
            print('Id cens inserido $id');
          }
        } else if (linha == 'quarteirao') {
          for (var campo in obj) {
            row['id_quarteirao'] = campo['id_quarteirao'];
            row['id_censitario'] = campo['id_censitario'];
            row['numero'] = campo['numero'].toString().trim();
            row['sub_numero'] = campo['sub_numero'].toString().trim();
            // print(row);
            int id = await dbHelper.insert(row, linha);
            print('Id quart inserido $id');
          }
        } else if (linha == 'grupo_rec') {
          for (var campo in obj) {
            row['id_grupo_rec'] = campo['id_grupo_rec'];
            row['codigo'] = campo['codigo'];
            row['nome'] = campo['nome'].toString().trim();
            final tables = await dbHelper
                .queryGen('SELECT * FROM sqlite_master ORDER BY name;');
            print(tables);
            int id = await dbHelper.insert(row, linha);
            print('Id grupo inserido $id');
          }
        } else if (linha == 'tipo_rec') {
          for (var campo in obj) {
            row['id_tipo_rec'] = campo['id_tipo_rec'];
            row['id_grupo_rec'] = campo['id_grupo_rec'];
            row['nome'] = campo['nome'].toString().trim();
            //print(row);
            int id = await dbHelper.insert(row, linha);
            print('Id tipo inserido $id');
          }
        } else if (linha == 'atividade') {
          for (var campo in obj) {
            row['id_atividade'] = campo['id_atividade'];
            row['nome'] = campo['nome'].toString().trim();
            row['grupo'] = campo['grupo'];
            //print(row);
            int id = await dbHelper.insert(row, linha);
            print('Id ativ inserido $id');
          }
        }
      }
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
