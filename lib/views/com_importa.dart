import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:sisamob3/data/dummy_local.dart';
import 'package:sisamob3/util/comunica.dart';

class ComImporta extends StatefulWidget {
  @override
  _ComImportaState createState() => _ComImportaState();
}

class _ComImportaState extends State<ComImporta> {
  final _form = GlobalKey<FormState>();
  final GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();
  final List<String> _sugestao = [];
  final List<String> _indices = [];
  SimpleAutoCompleteTextField autoLocal;

  void _setLocal(String local) {
    _local = _indices[_sugestao.indexOf(local)];
    autoLocal.textField.controller.text = local;
  }

  String _local = '';
  int _radioInfo = -1;
  void _handleRadioInfoChange(int value) {
    setState(() {
      _radioInfo = value;
    });
  }

  int _radioNivel = -1;
  void _handleRadioNivelChange(int value) {
    setState(() {
      _radioNivel = value;

      Map<String, Local> dados;
      switch (value) {
        case 0:
          dados = {...DUMMY_REGIONAL};
          break;
        case 1:
          dados = {...DUMMY_COLEGIADO};
          break;
        case 3:
          dados = {...DUMMY_DRS};
          break;
        default:
          dados = {...DUMMY_MUNICIPIO};
      }
      _sugestao.clear();
      _indices.clear();
      dados.forEach((key, value) {
        Local loc = value;
        _sugestao.add(loc.nome.toString());
        _indices.add(loc.codigo.toString());
      });
    });
  }

  String _resumo = '';
  void _handleRetornoRecebe(String value) {
    setState(() {
      _resumo = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Importar Cadastro'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _form,
              child: Column(
                children: <Widget>[
                  new Text(
                    'Tipo de Cadastro :',
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  new Row(children: <Widget>[
                    new Radio(
                      value: 1,
                      groupValue: _radioInfo,
                      onChanged: _handleRadioInfoChange,
                    ),
                    new Text(
                      'Sistema',
                      style: new TextStyle(fontSize: 16.0),
                    ),
                  ]),
                  Row(
                    children: [
                      new Radio(
                        value: 2,
                        groupValue: _radioInfo,
                        onChanged: _handleRadioInfoChange,
                      ),
                      new Text(
                        'Território',
                        style: new TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      new Radio(
                        value: 3,
                        groupValue: _radioInfo,
                        onChanged: _handleRadioInfoChange,
                      ),
                      new Text(
                        'Área Transmissão',
                        style: new TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                  new Text(
                    'Nível :',
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  Row(
                    children: [
                      new Radio(
                        value: 0,
                        groupValue: _radioNivel,
                        onChanged: _handleRadioNivelChange,
                      ),
                      new Text(
                        'Regional',
                        style: new TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      new Radio(
                        value: 3,
                        groupValue: _radioNivel,
                        onChanged: _handleRadioNivelChange,
                      ),
                      new Text(
                        'DRS',
                        style: new TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      new Radio(
                        value: 1,
                        groupValue: _radioNivel,
                        onChanged: _handleRadioNivelChange,
                      ),
                      new Text(
                        'Colegiado',
                        style: new TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      new Radio(
                        value: 2,
                        groupValue: _radioNivel,
                        onChanged: _handleRadioNivelChange,
                      ),
                      new Text(
                        'Município',
                        style: new TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                  autoLocal = SimpleAutoCompleteTextField(
                    key: key,
                    suggestions: _sugestao,
                    clearOnSubmit: false,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.black12,
                        hintText: 'Local a importar'),
                    textSubmitted: (text) => {_setLocal(text)},
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                        onPressed: () {
                          _form.currentState.save();
                          Comunica com = Comunica();
                          com
                              .fetchDados(
                                  _radioInfo, _radioNivel, _local, context)
                              .then(
                                (String value) => _handleRetornoRecebe(value),
                              );
                        },
                        child: Text('Carregar'),
                        style: ElevatedButton.styleFrom(primary: Colors.blue)),
                  ),
                  Text(
                    _resumo,
                    style: new TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
