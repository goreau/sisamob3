import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static final _databaseName = "sisamob3.db";
  static final _databaseVersion = 1;

  // Uso

  // final dbHelper = DatabaseHelper.instance;

  static final sqlCreate = [
    "CREATE TABLE municipio(id_municipio INTEGER, nome TEXT, codigo TEXT)",
    "CREATE TABLE area(id_area INTEGER, id_municipio INTEGER, codigo TEXT)",
    "CREATE TABLE censitario(id_censitario INTEGER, id_area INTEGER, codigo TEXT)",
    "CREATE TABLE quarteirao(id_quarteirao INTEGER, id_censitario INTEGER, numero_quarteirao TEXT, sub_numero TEXT)",
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
    if (_database != null) return _database;
    // instancia o db na primeira vez que for acessado
    _database = await _initDatabase();
    return _database;
  }

  // abre o banco de dados e o cria se ele não existir
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // Código SQL para criar o banco de dados e as tabelas
  Future _onCreate(Database db, int version) async {
    persiste(db);
    sqlCreate.map((e) => db.execute(e));
  }

  persiste(Database db) {
    tabelas.map((e) => db.execute("DROP TABLE IF EXISTS $e"));
  }

  // métodos Helper
  //----------------------------------------------------
  // Insere uma linha no banco de dados onde cada chave
  // no Map é um nome de coluna e o valor é o valor da coluna.
  // O valor de retorno é o id da linha inserida.
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

  // Todos os métodos : inserir, consultar, atualizar e excluir,
  // também podem ser feitos usando  comandos SQL brutos.
  // Esse método usa uma consulta bruta para fornecer a contagem de linhas.
  Future<int> queryRowCount(String table) async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  // Assumimos aqui que a coluna id no mapa está definida. Os outros
  // valores das colunas serão usados para atualizar a linha.
  Future<int> update(Map<String, dynamic> row, String table, int id) async {
    Database db = await instance.database;
    String idField = 'id_$table';
    return await db.update(table, row, where: '$idField = ?', whereArgs: [id]);
  }

  // Exclui a linha especificada pelo id. O número de linhas afetadas é
  // retornada. Isso deve ser igual a 1, contanto que a linha exista.
  Future<int> delete(int id, String table) async {
    Database db = await instance.database;
    String idField = 'id_$table';
    return await db.delete(table, where: '$idField = ?', whereArgs: [id]);
  }
}
