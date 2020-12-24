import 'dart:convert';
import 'package:http/http.dart' as http;

class Comunica {
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

  Future fetchDados() async {
    final response = await http.get(
        'http://200.144.1.24/dados/Cadastros.php?tipo=sistema&nivel=2&id=645'); // tipo=cadastro

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
          }
        } else if (linha == 'area') {
          for (var campo in obj) {
            row['id_area'] = campo['id_area'];
            row['id_municipio'] = campo['id_municipio'];
            row['codigo'] = campo['codigo'].toString().trim();
            //  print(row);
          }
        } else if (linha == 'censitario') {
          for (var campo in obj) {
            row['id_censitario'] = campo['id_censitario'];
            row['id_area'] = campo['id_area'];
            row['codigo'] = campo['codigo'].toString().trim();
            // print(row);
          }
        } else if (linha == 'quarteirao') {
          for (var campo in obj) {
            row['id_quarteirao'] = campo['id_quarteirao'];
            row['id_censitario'] = campo['id_censitario'];
            row['numero'] = campo['numero'].toString().trim();
            row['sub_numero'] = campo['sub_numero'].toString().trim();
            // print(row);
          }
        } else if (linha == 'grupo_rec') {
          for (var campo in obj) {
            row['id_grupo_rec'] = campo['id_grupo_rec'];
            row['codigo'] = campo['codigo'];
            row['nome'] = campo['nome'].toString().trim();
            print(row);
          }
        } else if (linha == 'tipo_rec') {
          for (var campo in obj) {
            row['id_tipo_rec'] = campo['id_tipo_rec'];
            row['id_grupo_rec'] = campo['id_grupo_rec'];
            row['nome'] = campo['nome'].toString().trim();
            print(row);
          }
        } else if (linha == 'atividade') {
          for (var campo in obj) {
            row['id_atividade'] = campo['id_atividade'];
            row['nome'] = campo['nome'].toString().trim();
            row['grupo'] = campo['grupo'];
            print(row);
          }
        }
      }

      /*  for (Map i in area) {
        print(i);
      }
       setState(() {
        
        loading = false;
      })*/
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
