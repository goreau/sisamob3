import 'package:flutter/cupertino.dart';

class Visita {
  final int id_visita;
  int id_execucao;
  int id_municipio;
  int id_atividade;
  String dt_cadastro;
  String agente;

  int id_area;
  int id_censitario;
  int id_quarteirao;
  int tipo_trab;
  int id_focal;
  int id_peri;
  int id_nebul;

  Visita({
    this.id_visita,
    @required this.id_execucao,
    @required this.id_municipio,
    @required this.id_atividade,
    @required this.dt_cadastro,
    @required this.agente,
    this.id_area,
    this.id_censitario,
    this.id_quarteirao,
    this.tipo_trab,
    this.id_focal,
    this.id_peri,
    this.id_nebul,
  });
}
