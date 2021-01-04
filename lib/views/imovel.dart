import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sisamob3/components/steper.dart';
import 'package:sisamob3/models/imovel_vc.dart';

class Imovel extends StatefulWidget {
  @override
  _ImovelState createState() => _ImovelState();
}

class _ImovelState extends State<Imovel> {
  final _form = GlobalKey<FormState>();
  ImovelVC _imovel;
  final _ordemController = TextEditingController();
  final _casaController = TextEditingController();

  Position position;

  Future<void> getPosition() async {
    Position pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      position = pos;
      print('posicao $pos');
    });
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
    _imovel = ModalRoute.of(context).settings.arguments;
  }

  @override
  void initState() {
    super.initState();
    getPosition();
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
            child: Column(children: <Widget>[
              ListTile(
                leading: const Icon(Icons.accessibility),
                title: Text(
                  'Imovel:',
                  style: new TextStyle(
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.start,
                ),
                subtitle: TextFormField(
                  style: new TextStyle(
                    fontSize: 12,
                  ),
                  controller: _ordemController,
                  decoration: InputDecoration(labelText: 'Imovel'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'O número de ordem é obrigatório!!';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) => _imovel.ordem = int.parse(value),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.accessibility),
                title: TextFormField(
                  style: new TextStyle(
                    fontSize: 12,
                  ),
                  controller: _casaController,
                  decoration: InputDecoration(labelText: 'Casa:'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'O número da casa é obrigatório!!';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) => _imovel.casa = value,
                ),
              ),
              ListTile(
                title: Text(
                  'Execução:',
                  style: new TextStyle(
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.start,
                ),
                subtitle: Column(
                  children: <Widget>[
                    new Row(children: <Widget>[
                      new Radio(
                        value: 1,
                        groupValue: _imovel.id_situacao,
                        onChanged: _handleRadioSitChange,
                      ),
                      new Text(
                        'Trabalhada',
                        style: new TextStyle(fontSize: 12.0),
                      ),
                    ]),
                    Row(
                      children: [
                        new Radio(
                          value: 2,
                          groupValue: _imovel.id_situacao,
                          onChanged: _handleRadioSitChange,
                        ),
                        new Text(
                          'Fechada',
                          style: new TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        new Radio(
                          value: 3,
                          groupValue: _imovel.id_situacao,
                          onChanged: _handleRadioSitChange,
                        ),
                        new Text(
                          'Desocupado',
                          style: new TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        new Radio(
                          value: 4,
                          groupValue: _imovel.id_situacao,
                          onChanged: _handleRadioSitChange,
                        ),
                        new Text(
                          'Temporada',
                          style: new TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        new Radio(
                          value: 5,
                          groupValue: _imovel.id_situacao,
                          onChanged: _handleRadioSitChange,
                        ),
                        new Text(
                          'Parcial',
                          style: new TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        new Radio(
                          value: 6,
                          groupValue: _imovel.id_situacao,
                          onChanged: _handleRadioSitChange,
                        ),
                        new Text(
                          'Recusa',
                          style: new TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [Text('Tratamento')],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [Text('Quantidade')],
                    )
                  ],
                ),
                subtitle: Column(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(children: [
                          Row(
                            children: [
                              Checkbox(
                                value: _imovel.focal == 1,
                                onChanged: (value) {},
                              ),
                              Text('Focal'),
                            ],
                          ),
                        ]),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              CustomStepper(
                                  lowerLimit: 0,
                                  upperLimit: 100,
                                  stepValue: 1,
                                  iconSize: 20,
                                  value: 0),
                            ]),
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(children: [
                          Row(
                            children: [
                              Checkbox(
                                value: _imovel.perifocal == 1,
                                onChanged: (value) {},
                              ),
                              Text('Perifocal'),
                            ],
                          ),
                        ]),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              CustomStepper(
                                  lowerLimit: 0,
                                  upperLimit: 100,
                                  stepValue: 1,
                                  iconSize: 20,
                                  value: 0),
                            ]),
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(children: [
                          Row(
                            children: [
                              Checkbox(
                                value: _imovel.nebulizacao == 1,
                                onChanged: (value) {},
                              ),
                              Text('Nebulização'),
                            ],
                          ),
                        ]),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              CustomStepper(
                                  lowerLimit: 0,
                                  upperLimit: 100,
                                  stepValue: 1,
                                  iconSize: 20,
                                  value: 0),
                            ]),
                      ]),
                  Row(children: [
                    Column(children: [
                      Row(
                        children: [
                          Checkbox(
                            value: _imovel.mecanico == 1,
                            onChanged: (value) {},
                          ),
                          Text('Mecanico'),
                        ],
                      ),
                    ]),
                    Column(children: []),
                  ]),
                  Row(children: [
                    Column(children: [
                      Row(
                        children: [
                          Checkbox(
                            value: _imovel.mecanico == 1,
                            onChanged: (value) {},
                          ),
                          Text('Alternativo'),
                        ],
                      ),
                    ]),
                    Column(children: []),
                  ]),
                ]),
              ),
              ListTile(
                  leading: const Icon(Icons.accessibility),
                  title: Text(
                    'Coordenadas:',
                    style: new TextStyle(
                      fontSize: 13,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  subtitle: position == null
                      ? Text('aguandando...')
                      : Row(
                          children: [
                            Text(position.latitude.toString()),
                            Text(position.longitude.toString()),
                          ],
                        ))
            ]),
          ),
        ));
  }

  void _handleRadioSitChange(int value) {
    setState(() {
      _imovel.id_situacao = value;
    });
  }
}
