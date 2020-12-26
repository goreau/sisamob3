import 'package:flutter/material.dart';
import 'package:sisamob3/util/routes.dart';
import 'package:sisamob3/views/com_importa.dart';
import 'package:sisamob3/views/principal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        Routes.HOME: (_) => Principal(),
        Routes.COM_IMPORTA: (_) => ComImporta(),
      },
    );
  }
}
