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
  // String _data = new DateTime.now().toString().substring(0, 10);

  final dateController = TextEditingController();
  int ano = DateTime.parse(new DateTime.now().toString()).year;

  final _agenteController = TextEditingController();

// data escolhida no picker
  void getCurrentDate(String date) async {
    var dateParse = DateTime.parse(date);

    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
    setState(() {
      vis.dt_cadastro = formattedDate.toString();
    });
  }

  void _handleRadioExecChange(int value) {
    setState(() {
      vis.id_execucao = value;
    });
  }

  void _loadChoices() async {
    try {
      var atv = await Storage.recupera('atividade');
      var mnc = await Storage.recupera('municipio');
      vis.id_atividade = int.parse(atv);
      vis.id_municipio = int.parse(mnc);
    } catch (e) {}
  }

  void _doRegister() async {
    await _loadChoices();
    if (vis.id_execucao < 1 || vis.id_atividade == 0 || vis.id_municipio == 0) {
      final scaffold = ScaffoldMessenger.of(context);
      scaffold.showSnackBar(SnackBar(
        content: const Text('Todos os campos são obrigatórios.'),
        backgroundColor: Colors.redAccent[700],
      ));
      return;
    }
    if (_form.currentState.validate()) {
      _form.currentState.save();
      Storage.insere('agente', vis.agente);
      Storage.insere('exec', vis.id_execucao);

      if ([5, 6.7].contains(vis.id_atividade)) {
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
        vis.agente = ag;
        vis.id_execucao = ex;
        _agenteController.text = ag;
        vis.dt_cadastro = DateTime.now().toString().substring(0, 10);
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
    if (vis == null) {
      vis = Visita(
        id_visita: 0,
        id_execucao: 0,
        id_municipio: 0,
        id_atividade: 0,
        dt_cadastro: '',
        agente: '',
        id_area: 0,
        id_censitario: 0,
        id_quarteirao: 0,
        tipo_trab: 0,
        id_focal: 0,
        id_peri: 0,
        id_nebul: 0,
      );
      _loadPreferences();
    }
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
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.start,
                ),
                subtitle: Column(children: <Widget>[
                  new Row(children: <Widget>[
                    new Radio(
                      value: 1,
                      groupValue: vis.id_execucao,
                      onChanged: _handleRadioExecChange,
                    ),
                    new Text(
                      'Sucen',
                      style: new TextStyle(fontSize: 12.0),
                    ),
                  ]),
                  Row(
                    children: [
                      new Radio(
                        value: 2,
                        groupValue: vis.id_execucao,
                        onChanged: _handleRadioExecChange,
                      ),
                      new Text(
                        'Controle de Vetores',
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
                        groupValue: vis.id_execucao,
                        onChanged: _handleRadioExecChange,
                      ),
                      new Text(
                        'Agente Comunitário',
                        style: new TextStyle(
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
              ListTile(
                leading: const Icon(Icons.accessibility),
                title: TextFormField(
                  style: new TextStyle(
                    fontSize: 12,
                  ),
                  controller: _agenteController,
                  decoration: InputDecoration(labelText: 'Agente'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'O nome é obrigatório!!';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) => vis.agente = value,
                ),
              ),
              ListTile(
                leading: const Icon(Icons.location_city),
                title: Text(
                  'Município:',
                  style: new TextStyle(
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.start,
                ),
                subtitle: ComboBox('municipio', vis.id_municipio),
              ),
              ListTile(
                leading: const Icon(Icons.construction),
                title: Text(
                  'Atividade:',
                  style: new TextStyle(
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.start,
                ),
                subtitle: ComboBox('atividade', vis.id_atividade),
              ),
              ListTile(
                leading: const Icon(Icons.calendar_today),
                title: TextFormField(
                  style: new TextStyle(
                    fontSize: 12,
                  ),
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
                  onSaved: (value) => vis.dt_cadastro = value,
                  onTap: () async {
                    var date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.parse(vis.dt_cadastro),
                      firstDate: DateTime(ano - 2),
                      lastDate: DateTime(ano + 1),
                    );
                    await getCurrentDate(date.toString().substring(0, 10));
                    dateController.text = vis.dt_cadastro;
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
