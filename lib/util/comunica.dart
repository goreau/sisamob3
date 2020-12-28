import 'dart:convert';
import 'package:flutter/material.dart';
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

  Future<String> fetchDados(
      int tipo, int nivel, String local, BuildContext context) async {
    String _url = '';
    String resumo = 'Registros recebidos:\n';

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
        int ct = 0;
        if (linha == 'municipio') {
          ct = 0;
          for (var campo in obj) {
            row['id_municipio'] = campo['id_municipio'];
            row['nome'] = campo['nome'];
            row['codigo'] = campo['codigo'];
            await dbHelper.insert(row, linha);
            ct++;
          }
          resumo += ct > 0 ? 'Município: $ct registros\n' : '';
        } else if (linha == 'area') {
          ct = 0;
          for (var campo in obj) {
            row['id_area'] = campo['id_area'];
            row['id_municipio'] = campo['id_municipio'];
            row['codigo'] = campo['codigo'].toString().trim();
            await dbHelper.insert(row, linha);
            ct++;
            //print('$ct areas');
          }
          resumo += ct > 0 ? 'Área: $ct registros\n' : '';
        } else if (linha == 'censitario') {
          ct = 0;
          for (var campo in obj) {
            row['id_censitario'] = campo['id_censitario'];
            row['id_area'] = campo['id_area'];
            row['codigo'] = campo['codigo'].toString().trim();
            await dbHelper.insert(row, linha);
            ct++;
          }
          resumo += ct > 0 ? 'Censitário: $ct registros\n' : '';
        } else if (linha == 'quarteirao') {
          ct = 0;
          for (var campo in obj) {
            row['id_quarteirao'] = campo['id_quarteirao'];
            row['id_censitario'] = campo['id_censitario'];
            row['numero'] = campo['numero'].toString().trim();
            row['sub_numero'] = campo['sub_numero'].toString().trim();
            await dbHelper.insert(row, linha);
            ct++;
          }
          resumo += ct > 0 ? 'Quarteirão: $ct registros\n' : '';
        } else if (linha == 'grupo_rec') {
          ct = 0;
          for (var campo in obj) {
            row['id_grupo_rec'] = campo['id_grupo_rec'];
            row['codigo'] = campo['codigo'];
            row['nome'] = campo['nome'].toString().trim();
            await dbHelper.insert(row, linha);
            ct++;
          }
          resumo += ct > 0 ? 'Grupo Recipientes: $ct registros\n' : '';
        } else if (linha == 'tipo_rec') {
          ct = 0;
          for (var campo in obj) {
            row['id_tipo_rec'] = campo['id_tipo_rec'];
            row['id_grupo_rec'] = campo['id_grupo_rec'];
            row['nome'] = campo['nome'].toString().trim();
            await dbHelper.insert(row, linha);
            ct++;
          }
          resumo += ct > 0 ? 'Tipo de Recipiente: $ct registros\n' : '';
        } else if (linha == 'atividade') {
          ct = 0;
          for (var campo in obj) {
            row['id_atividade'] = campo['id_atividade'];
            row['nome'] = campo['nome'].toString().trim();
            row['grupo'] = campo['grupo'];
            await dbHelper.insert(row, linha);
            ct++;
            //print('$ct atividades');
          }
          resumo += ct > 0 ? 'Atividade: $ct registros\n' : '';
        }
      }
      /* final scaffold = ScaffoldMessenger.of(context);
      scaffold.showSnackBar(
        SnackBar(
          content: const Text('Cadastro recebido.'),
          backgroundColor: Colors.green[900],
        ),
      );*/
    } else {
      throw Exception('Falha ao carregar cadastro');
    }
    return resumo;
  }
}
