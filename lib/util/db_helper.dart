import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static final _databaseName = "sisamob1.db";
  static final _databaseVersion = 8;

  Map registros = Map<String, dynamic>();

  // Uso

  // final dbHelper = DatabaseHelper.instance;

  static final sqlCreate = [
    "CREATE TABLE municipio(id_municipio INTEGER, nome TEXT, codigo TEXT)",
    "CREATE TABLE area(id_area INTEGER, id_municipio INTEGER, codigo TEXT)",
    "CREATE TABLE censitario(id_censitario INTEGER, id_area INTEGER, codigo TEXT)",
    "CREATE TABLE quarteirao(id_quarteirao INTEGER, id_censitario INTEGER, numero TEXT, sub_numero TEXT)",
    "CREATE TABLE imovel(id_imovel INTEGER, id_municipio INTEGER, id_quarteirao INTEGER, numero_imovel TEXT, endereco TEXT, id_atividade INTEGER)",
    "CREATE TABLE grupo_rec(id_grupo_rec INTEGER, codigo TEXT, nome TEXT)",
    "CREATE TABLE tipo_rec(id_tipo_rec INTEGER, id_grupo_rec INTEGER, nome TEXT)",
    "CREATE TABLE atividade(id_atividade INTEGER, nome TEXT, grupo INTEGER)"
  ];
  static final tabelas = {
    "municipio",
    "area",
    "censitario",
    "quarteirao",
    "imovel",
    "grupo_rec",
    "tipo_rec",
    "atividade"
  };

  // torna esta classe singleton
  DbHelper._privateConstructor();
  static final DbHelper instance = DbHelper._privateConstructor();
  // tem somente uma referência ao banco de dados
  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    // instancia o db na primeira vez que for acessado
    _database = await _initDatabase();
    return _database;
  }

  // abre o banco de dados e o cria se ele não existir
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onUpgrade: _onUpgrade,
      onCreate: _onCreate,
    );
  }

  Future _onUpgrade(Database db, int version, int newVersion) async {
    await _persiste(db);
    for (var e in tabelas) {
      await db.execute("DROP TABLE IF EXISTS $e");
    }
    await _onCreate(db, newVersion);
    _recupera(db);
  }

  // Código SQL para criar o banco de dados e as tabelas
  Future _onCreate(Database db, int version) async {
    //
    Batch batch = db.batch();
    try {
      sqlCreate.forEach((e) {
        batch.execute(e);
      });
      List<dynamic> res = await batch.commit();
    } catch (e) {
      debugPrint('Erro criando tabela $e');
    }
  }

  Future<int> insert(Map<String, dynamic> row, String table) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  // Todas as linhas são retornadas como uma lista de mapas, onde cada mapa é
  // uma lista de valores-chave de colunas.
  Future<List<Map<String, dynamic>>> queryAllRows(String table) async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<int> queryRowCount(String table) async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  Future<int> update(Map<String, dynamic> row, String table, int id) async {
    Database db = await instance.database;
    String idField = 'id_$table';
    return await db.update(table, row, where: '$idField = ?', whereArgs: [id]);
  }

  Future<int> delete(int id, String table) async {
    Database db = await instance.database;
    String idField = 'id_$table';
    return await db.delete(table, where: '$idField = ?', whereArgs: [id]);
  }

  Future<void> limpa(String table) async {
    Database db = await instance.database;
    return await db.delete(table);
  }

  Future<void> _persiste(Database db) async {
    //fornecer valor padrão para o campo alterado
    final persTabela = ["municipio", "area", "censitario", "quarteirao"];
    for (var element in persTabela) {
      var lista = [];
      await db.query(element).then((value) {
        for (var row in value) {
          //value.forEach((row) {
          lista.add(row);
        } //);
        registros[element] = lista;
      });
    }
  }

  _recupera(Database db) async {
    print(registros);
    final persTabela = ["municipio", "area", "censitario", "quarteirao"];
    for (var element in persTabela) {
      var tab = registros[element];
      for (var reg in tab) {
        db.insert(element, reg);
      }
    }
  }

  Future<List<Map>> qryCombo(String tabela) async {
    Database db = await instance.database;
    return await db
        .rawQuery('SELECT id_$tabela as id, nome FROM $tabela order by id');
  }
}
