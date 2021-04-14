import 'package:flutter/material.dart';
import 'package:sisamob3/util/routes.dart';
import 'package:sisamob3/views/atividade.dart';
import 'package:sisamob3/views/com_importa.dart';
import 'package:sisamob3/views/im_cadastrado.dart';
import 'package:sisamob3/views/imovel.dart';
import 'package:sisamob3/views/principal.dart';
import 'package:sisamob3/views/recipiente.dart';
import 'package:sisamob3/views/vis_imovel.dart';

import 'views/formulario.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SisaMob 3',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        Routes.HOME: (_) => Principal(),
        Routes.COM_IMPORTA: (_) => ComImporta(),
        Routes.VISITA: (_) => Atividade(),
        Routes.VIS_IMOVEL: (_) => VisImovel(),
        Routes.IMOVEL: (_) => Imovel(),
        Routes.IM_CADASTRADO: (_) => ImCadastrado(),
        Routes.RECIPIENTE: (_) => Recipiente(),
        Routes.FORMULARIO: (_) => Formulario(),
      },
      builder: (BuildContext context, Widget widget) {
        Widget error = Text('Encontramos um erro....');
        if (widget is Scaffold || widget is Navigator)
          error = Scaffold(body: Center(child: error));
        ErrorWidget.builder = (FlutterErrorDetails errorDetails) => error;
        return widget;
      },
    );
  }
}
