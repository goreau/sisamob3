import 'package:flutter/material.dart';
import 'package:sisamob3/components/combo_box.dart';
import 'package:sisamob3/models/visita.dart';
import 'package:sisamob3/util/routes.dart';
import 'package:sisamob3/util/storage.dart';

class Atividade extends StatefulWidget {
  @override
  _AtividadeState createState() => _AtividadeState();
}

class _AtividadeState extends State<Atividade> {
  final _form = GlobalKey<FormState>();

  Visita vis;

  final dateController = TextEditingController();
  int ano = DateTime.parse(new DateTime.now().toString()).year;

  final _agenteController = TextEditingController();

  Future<void> getCurrentDate(String date) async {
    var dateParse = DateTime.parse(date);

    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";

    setState(() {
      _data = formattedDate.toString();
    });
  }

  // valores iniciais //
  int _radioExec = -1;
  int _spinAtiv = 0;
  int _spinMun = 0;
  String _agente = '';
  String _data = new DateTime.now().toString().substring(0, 10);

  //=================//

  void _loadFormdata(Visita vis) async {
    if (vis != null) {
      _radioExec = vis.id_execucao;
      _spinAtiv = vis.id_atividade;
      _spinMun = vis.id_municipio;
      _agente = vis.agente;
      _data = vis.dt_cadastro;
    } else {}
    dateController.text = _data;
  }

  void _handleRadioExecChange(int value) {
    setState(() {
      _radioExec = value;
    });
  }

  void _loadChoices() async {
    try {
      var atv = await Storage.recupera('atividade');
      var mnc = await Storage.recupera('municipio');
      print(atv);
      _spinAtiv = int.parse(atv);
      _spinMun = int.parse(mnc);
    } catch (e) {}
  }

  void _doRegister() async {
    await _loadChoices();
    if (_radioExec < 1 || _spinAtiv == 0 || _spinMun == 0) {
      final scaffold = ScaffoldMessenger.of(context);
      scaffold.showSnackBar(SnackBar(
        content: const Text('Todos os campos são obrigatórios.'),
        backgroundColor: Colors.redAccent[700],
      ));
      return;
    }
    if (_form.currentState.validate()) {
      _form.currentState.save();
      Storage.insere('agente', _agente);
      Storage.insere('exec', _radioExec);
      print('salvou a porra');

      /*  Visita saved = Visita(
          id_execucao: _radioExec,
          id_municipio: _spinMun,
          id_atividade: _spinAtiv,
          dt_cadastro: _data,
          agente: _agente);*/

      if ([5].contains(_spinAtiv)) {
        Navigator.of(context).pushNamed(
          Routes.VIS_IMOVEL,
          arguments: vis, //saved,
        );
      }
    }
  }

  void _loadPreferences() async {
    var ag = '';
    var ex = 0;
    try {
      ag = await Storage.recupera('agente');
      ex = await Storage.recupera('exec');
      setState(() {
        _agente = ag;
        _radioExec = ex;
        _agenteController.text = ag;
      });
    } catch (e) {}
  }

  @override
  void initState() {
    super.initState();
    _loadPreferences();
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
    vis = ModalRoute.of(context).settings.arguments;
    //_loadFormdata(vis);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar Atividade'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _form,
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(
                  'Execução:',
                  style: new TextStyle(
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.start,
                ),
                subtitle: Column(children: <Widget>[
                  new Row(children: <Widget>[
                    new Radio(
                      value: 1,
                      groupValue: _radioExec,
                      onChanged: _handleRadioExecChange,
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
                        groupValue: _radioExec,
                        onChanged: _handleRadioExecChange,
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
                        groupValue: _radioExec,
                        onChanged: _handleRadioExecChange,
                      ),
                      new Text(
                        'Agente Comunitário',
                        style: new TextStyle(
                          fontSize: 11.0,
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
              ListTile(
                leading: const Icon(Icons.accessibility),
                title: TextFormField(
                  controller: _agenteController,
                  decoration: InputDecoration(labelText: 'Agente'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'O nome é obrigatório!!';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) => _agente = value,
                ),
              ),
              ListTile(
                leading: const Icon(Icons.location_city),
                title: Text(
                  'Município:',
                  style: new TextStyle(
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.start,
                ),
                subtitle: ComboBox('municipio', _spinMun),
              ),
              ListTile(
                leading: const Icon(Icons.construction),
                title: Text(
                  'Atividade:',
                  style: new TextStyle(
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.start,
                ),
                subtitle: ComboBox('atividade', _spinAtiv),
              ),
              ListTile(
                leading: const Icon(Icons.calendar_today),
                title: TextFormField(
                  readOnly: true,
                  controller: dateController,
                  decoration: InputDecoration(hintText: 'Data da Atividade'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'A data da atividade deve ser informada!!';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) => _data = value,
                  onTap: () async {
                    var date = await showDatePicker(
                      context: context,
                      initialDate:
                          DateTime.parse(_data.split('-').reversed.join('-')),
                      firstDate: DateTime(ano - 2),
                      lastDate: DateTime(ano + 1),
                    );
                    await getCurrentDate(date.toString().substring(0, 10));
                    dateController.text = _data;
                    //date.toString().substring(0, 10);
                  },
                ),
              ),
              //  SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(20),
                child: SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                      onPressed: () {
                        _doRegister();
                      },
                      child: Text('Prosseguir'),
                      style: ElevatedButton.styleFrom(primary: Colors.blue)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
