import 'package:flutter/material.dart';
import 'package:sisamob3/components/combo_box.dart';
import 'package:sisamob3/models/visita.dart';

class VisImovel extends StatefulWidget {
  @override
  _VisImovelState createState() => _VisImovelState();
}

class _VisImovelState extends State<VisImovel> {
  final _form = GlobalKey<FormState>();
  Visita vis;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    vis = ModalRoute.of(context).settings.arguments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Local da Atividade'),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: _form,
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.location_city),
                  title: Text(
                    'Área:',
                    style: new TextStyle(
                      fontSize: 13,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  subtitle: ComboBox('area', vis.id_municipio),
                ),
                ListTile(
                  leading: const Icon(Icons.location_city),
                  title: Text(
                    'Censitário:',
                    style: new TextStyle(
                      fontSize: 13,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  subtitle: ComboBox('censitario', vis.id_municipio),
                ),
                ListTile(
                  leading: const Icon(Icons.location_city),
                  title: Text(
                    'Quarteirão:',
                    style: new TextStyle(
                      fontSize: 13,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  subtitle: ComboBox('quarteirao', vis.id_municipio),
                ),
              ],
            )),
      ),
    );
  }
}
