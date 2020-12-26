import 'package:flutter/material.dart';
import 'package:sisamob3/models/menu.dart';

const DUMMY_DATA = {
  '1': const Menu(
    nome: 'Home',
    icon: Icon(Icons.home),
  ),
  '2': const Menu(
    nome: 'Atividades',
    icon: null,
  ),
  '3': const Menu(
    nome: 'Registrar',
    icon: Icon(Icons.home_work),
  ),
  '4': const Menu(
    nome: 'Consultar',
    icon: Icon(Icons.list),
  ),
  '5': const Menu(
    nome: 'Coordenadas',
    icon: Icon(Icons.add_location_outlined),
  ),
  '6': const Menu(
    nome: 'Relatório',
    icon: Icon(Icons.home),
  ),
  '7': const Menu(
    nome: 'Manutenção',
    icon: Icon(Icons.plumbing_outlined),
  ),
  '8': const Menu(
    nome: 'Comunicação',
    icon: null,
  ),
  '9': const Menu(
    nome: 'Exportar Produção',
    icon: Icon(Icons.cloud_upload_outlined),
  ),
  '10': const Menu(
    nome: 'Importar Cadastros',
    icon: Icon(Icons.cloud_download_outlined),
  ),
};
