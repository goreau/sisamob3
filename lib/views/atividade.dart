import 'package:flutter/material.dart';
import 'package:sisamob3/components/dropdown.dart';
import 'package:sisamob3/models/visita.dart';
import 'package:sisamob3/util/auxiliar.dart';
import 'package:sisamob3/util/routes.dart';
import 'package:sisamob3/util/storage.dart';

class Atividade extends StatefulWidget {
  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Atividade> {
  final _form = GlobalKey<FormState>();

  List<DropdownMenuItem<String>> lstMun;
  List<DropdownMenuItem<String>> lstAtiv;

  Visita vis;
  final _agenteController = TextEditingController();
  final dateController = TextEditingController();
  int ano = DateTime.parse(new DateTime.now().toString()).year;

  @override
  void initState() {
    super.initState();
    Auxiliar.loadData('municipio', null).then((value) {
      setState(() {
        lstMun = value;
      });
    });
    Auxiliar.loadData('atividade', null).then((value) {
      setState(() {
        lstAtiv = value;
      });
    });
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
  void dispose() {
    // Clean up the controller when the widget is removed
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('create $lstMun');
    /*  if (lstMun == null || lstAtiv == null) {
      return CircularProgressIndicator();
    }*/
    return Card(
      elevation: 10,
      child: Container(
        height: ((MediaQuery.of(context).size.height) / 2),
        padding: EdgeInsets.all(20),
        child: Scaffold(
          appBar: new AppBar(
            title: const Text('Registrar Atividade'),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Form(
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
                      leading: const Icon(Icons.accessibility),
                      title: Text(
                        'Município:',
                        style: new TextStyle(
                          fontSize: 13,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      subtitle: (lstMun == null)
                          ? Center(child: CircularProgressIndicator())
                          : Dropdown('Municipio', lstMun, vis.id_municipio,
                              update: _updateMun),
                    ),
                    ListTile(
                      leading: const Icon(Icons.accessibility),
                      title: Text(
                        'Atividade:',
                        style: new TextStyle(
                          fontSize: 13,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      subtitle: (lstAtiv == null)
                          ? Center(child: CircularProgressIndicator())
                          : Dropdown('Atividade', lstAtiv, vis.id_atividade,
                              update: _updateAtiv),
                    ),
                    ListTile(
                      leading: const Icon(Icons.calendar_today),
                      title: TextFormField(
                        style: new TextStyle(
                          fontSize: 12,
                        ),
                        readOnly: true,
                        controller: dateController,
                        decoration:
                            InputDecoration(hintText: 'Data da Atividade'),
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
                          await getCurrentDate(
                              date.toString().substring(0, 10));
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
                            style:
                                ElevatedButton.styleFrom(primary: Colors.blue)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<String>> loadDados(String tab) async {
    await Future.delayed(Duration(seconds: 10), () => print('Tempo ok.'));
    return ['<15', '15-20', '>20'];
  }

  void _loadPreferences() async {
    var ag = '';
    var ex = 0;
    vis.dt_cadastro = DateTime.now().toString().substring(0, 10);
    try {
      ag = await Storage.recupera('agente');
      ex = await Storage.recupera('exec');
      setState(() {
        vis.agente = ag;
        vis.id_execucao = ex;
        _agenteController.text = ag;
      });
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

  void _loadChoices() async {
    try {
      var atv = await Storage.recupera('atividade');
      var mnc = await Storage.recupera('municipio');
      vis.id_atividade = int.parse(atv);
      vis.id_municipio = int.parse(mnc);
    } catch (e) {}
  }

  // Add this function.
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

  void _updateAtiv(String b) {
    setState(() {
      vis.id_atividade = int.parse(b);
    });
  }

  void _updateMun(String b) {
    setState(() {
      vis.id_municipio = int.parse(b);
    });
  }
}
