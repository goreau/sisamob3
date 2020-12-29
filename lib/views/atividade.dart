import 'package:flutter/material.dart';
import 'package:sisamob3/components/dropdown.dart';

class Atividade extends StatefulWidget {
  @override
  _AtividadeState createState() => _AtividadeState();
}

class _AtividadeState extends State<Atividade> {
  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar Atividade'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _form,
            child: Column(
              children: <Widget>[
                Dropdown(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
