import 'package:flutter/material.dart';
import 'package:sisamob3/components/combo_box.dart';
import 'package:sisamob3/models/visita.dart';

class Atividade extends StatefulWidget {
  @override
  _AtividadeState createState() => _AtividadeState();
}

class _AtividadeState extends State<Atividade> {
  final _form = GlobalKey<FormState>();
  List<Map> ativ;

  final dateController = TextEditingController();
  int ano = DateTime.parse(new DateTime.now().toString()).year;

  final Map<String, String> _formData = {};

  void _loadFormdata(Visita vis) {
    if (vis != null) {
      _formData['id_visita'] = vis.id_visita;
      _formData['id_execucao'] = vis.id_execucao;
      _formData['id_municipio'] = vis.id_municipio;
      _formData['id_atividade'] = vis.id_atividade;
      _formData['dt_cadastro'] = vis.dt_cadastro;
      _formData['agente'] = vis.agente;
    }
  }

  String _dtCad = '';
  Future<void> getCurrentDate(String date) async {
    var dateParse = DateTime.parse(date);

    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";

    setState(() {
      _dtCad = formattedDate.toString();
    });
  }

  int _radioAtiv = -1;
  void _handleRadioAtivChange(int value) {
    setState(() {
      _radioAtiv = value;
    });
    _formData['id_atividade'] = value.toString();
  }

  void _doRegister() {
    if (_radioAtiv < 1) {
      final scaffold = ScaffoldMessenger.of(context);
      scaffold.showSnackBar(SnackBar(
        content: const Text('Cadastro recebido.'),
        backgroundColor: Colors.redAccent[700],
      ));
      return;
    }
    if (_form.currentState.validate()) {
      _form.currentState.save();
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed
    dateController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Visita vis = ModalRoute.of(context).settings.arguments;
    _loadFormdata(vis);
  }

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
                Container(
                  width: double.infinity,
                  child: Text(
                    'Execução:',
                    style: new TextStyle(
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                new Row(children: <Widget>[
                  new Radio(
                    value: 1,
                    groupValue: _radioAtiv,
                    onChanged: _handleRadioAtivChange,
                  ),
                  new Text(
                    'Sucen',
                    style: new TextStyle(fontSize: 11.0),
                  ),
                ]),
                Row(
                  children: [
                    new Radio(
                      value: 2,
                      groupValue: _radioAtiv,
                      onChanged: _handleRadioAtivChange,
                    ),
                    new Text(
                      'Controle de Vetores',
                      style: new TextStyle(
                        fontSize: 11.0,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    new Radio(
                      value: 3,
                      groupValue: _radioAtiv,
                      onChanged: _handleRadioAtivChange,
                    ),
                    new Text(
                      'Agente Comunitário',
                      style: new TextStyle(
                        fontSize: 11.0,
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  initialValue: _formData['agente'],
                  decoration: InputDecoration(labelText: 'Agente'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'O nome é obrigatório!!';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) => _formData['agente'] = value,
                ),
                Container(
                  width: double.infinity,
                  child: Text(
                    'Município:',
                    style: new TextStyle(
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                ComboBox('municipio', _formData['id_municipio']),
                Container(
                  width: double.infinity,
                  child: Text(
                    'Atividade:',
                    style: new TextStyle(
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                ComboBox('atividade', _formData['id_atividade']),
                TextFormField(
                  readOnly: true,
                  controller: dateController,
                  initialValue: _formData['dt_cadastro'],
                  decoration: InputDecoration(hintText: 'Data da Atividade'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'A data da atividade deve ser informada!!';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) => _formData['dt_cadastro'] = value,
                  onTap: () async {
                    var date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(ano - 2),
                      lastDate: DateTime(ano + 1),
                    );
                    await getCurrentDate(date.toString().substring(0, 10));
                    dateController.text = _dtCad;
                    //date.toString().substring(0, 10);
                  },
                ),
                SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                      onPressed: () {
                        _form.currentState.save();
                      },
                      child: Text('Prosseguir'),
                      style: ElevatedButton.styleFrom(primary: Colors.blue)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
