import 'package:flutter/material.dart';

class Visita {
  final String id_visita;
  final String id_execucao;
  final String id_municipio;
  final String id_atividade;
  final String dt_cadastro;
  final String agente;

  const Visita({
    this.id_visita,
    @required this.id_execucao,
    @required this.id_municipio,
    @required this.id_atividade,
    @required this.dt_cadastro,
    @required this.agente,
  });
}
