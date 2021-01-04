import 'package:flutter/material.dart';
import 'package:sisamob3/components/dropdown.dart';
import 'package:sisamob3/models/imovel_vc.dart';
import 'package:sisamob3/models/visita.dart';
import 'package:sisamob3/util/auxiliar.dart';
import 'package:sisamob3/util/routes.dart';

class VisImovel extends StatefulWidget {
  @override
  _VisImovelState createState() => _VisImovelState();
}

class _VisImovelState extends State<VisImovel> {
  final _form = GlobalKey<FormState>();
  List<DropdownMenuItem<String>> lstArea;
  List<DropdownMenuItem<String>> lstCens;
  List<DropdownMenuItem<String>> lstQuart;
  List<DropdownMenuItem<String>> lstFocal;
  List<DropdownMenuItem<String>> lstPeri;
  List<DropdownMenuItem<String>> lstNeb;
  int oldCens = 0;
  int oldArea = 0;

  Visita vis;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    vis = ModalRoute.of(context).settings.arguments;
  }

  @override
  void initState() {
    super.initState();
    Auxiliar.loadData('area', ' id_municipio=185 ').then((value) {
      setState(() {
        lstArea = value;
      });
    });
    Auxiliar.loadData('produto', ' tipo_uso=1 ').then((value) {
      setState(() {
        lstFocal = value;
      });
    });
    Auxiliar.loadData('produto', ' tipo_uso=2 ').then((value) {
      setState(() {
        lstPeri = value;
      });
    });
    Auxiliar.loadData('produto', ' tipo_uso=3 ').then((value) {
      setState(() {
        lstNeb = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print('create $lstArea');
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
                  leading: const Icon(Icons.accessibility),
                  title: Text(
                    'Área:',
                    style: new TextStyle(
                      fontSize: 13,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  subtitle: (lstArea == null)
                      ? SizedBox(
                          child: CircularProgressIndicator(),
                          height: 50.0,
                          width: 50.0)
                      : Dropdown('Área', lstArea, vis.id_area,
                          update: _updateArea),
                ),
                ListTile(
                  leading: const Icon(Icons.construction),
                  title: Text(
                    'Censitário:',
                    style: new TextStyle(
                      fontSize: 13,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  subtitle: (lstCens == null)
                      ? Text('Aguardando...')
                      : ((vis.id_area != oldArea)
                          ? Center(child: CircularProgressIndicator())
                          : Dropdown('Censitário:', lstCens, vis.id_censitario,
                              update: _updateCens)),
                ),
                ListTile(
                  leading: const Icon(Icons.construction),
                  title: Text(
                    'Quarteirao:',
                    style: new TextStyle(
                      fontSize: 13,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  subtitle: (lstQuart == null)
                      ? Text('Aguardando...')
                      : ((vis.id_censitario != oldCens)
                          ? Center(child: CircularProgressIndicator())
                          : Dropdown('Quarteirão:', lstQuart, vis.id_quarteirao,
                              update: _updateQuart)),
                ),
                ListTile(
                    leading: const Icon(Icons.construction),
                    title: Text(
                      'Tipo de Trabalho:',
                      style: new TextStyle(
                        fontSize: 13,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(children: [
                          new Radio(
                            value: 1,
                            groupValue: vis.tipo_trab,
                            onChanged: _handleRadioTipoChange,
                          ),
                          new Text(
                            'Rotina',
                            style: new TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
                        ]),
                        Row(children: [
                          new Radio(
                            value: 2,
                            groupValue: vis.tipo_trab,
                            onChanged: _handleRadioTipoChange,
                          ),
                          new Text(
                            'Pendência',
                            style: new TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
                        ]),
                        Row(children: [
                          new Radio(
                            value: 3,
                            groupValue: vis.tipo_trab,
                            onChanged: _handleRadioTipoChange,
                          ),
                          new Text(
                            'Demanda',
                            style: new TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
                        ]),
                      ],
                    )),
                ListTile(
                  leading: const Icon(Icons.construction),
                  title: Text(
                    'Focal:',
                    style: new TextStyle(
                      fontSize: 13,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  subtitle: (lstFocal == null)
                      ? Center(child: CircularProgressIndicator())
                      : Dropdown('Focal:', lstFocal, vis.id_focal,
                          update: _updateFoc),
                ),
                ListTile(
                  leading: const Icon(Icons.construction),
                  title: Text(
                    'Perifocal:',
                    style: new TextStyle(
                      fontSize: 13,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  subtitle: (lstPeri == null)
                      ? Center(child: CircularProgressIndicator())
                      : Dropdown('Perifocal:', lstPeri, vis.id_peri,
                          update: _updatePeri),
                ),
                ListTile(
                  leading: const Icon(Icons.construction),
                  title: Text(
                    'Nebulização:',
                    style: new TextStyle(
                      fontSize: 13,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  subtitle: (lstNeb == null)
                      ? Center(child: CircularProgressIndicator())
                      : Dropdown('Nebulização:', lstNeb, vis.id_nebul,
                          update: _updateNeb),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                        onPressed: () {
                          _doRegister();
                        },
                        child: Text('Salvar'),
                        style: ElevatedButton.styleFrom(primary: Colors.blue)),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  void _doRegister() async {
    //await _loadChoices();
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

      if ([5, 6.7].contains(vis.id_atividade)) {
        ImovelVC im = ImovelVC(0, vis.id_visita);
        Navigator.of(context).pushNamed(
          Routes.IMOVEL,
          arguments: im, //saved,
        );
      }
    }
  }

  void _updateArea(String b) {
    setState(() {
      vis.id_area = int.parse(b);
      vis.id_censitario = 0;
      vis.id_quarteirao = 0;
      lstQuart = null;
      Auxiliar.loadData('censitario', ' id_area=${vis.id_area}').then((value) {
        setState(() {
          lstCens = value;
        });
      });
    });
    //if (oldArea != vis.id_area && oldArea > 0) {
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        oldArea = vis.id_area;
      });
    });
    //  } else {
    //     oldArea = vis.id_area;
    //  }
  }

  void _updateCens(String b) {
    setState(() {
      vis.id_quarteirao = 0;
      vis.id_censitario = int.parse(b);
      Auxiliar.loadData('quarteirao', ' id_censitario=${vis.id_censitario}')
          .then((value) {
        setState(() {
          lstQuart = value;
        });
      });
    });
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        oldCens = vis.id_censitario;
      });
    });
  }

  void _updateQuart(String b) {
    setState(() {
      vis.id_quarteirao = int.parse(b);
    });
  }

  void _updateFoc(String b) {
    setState(() {
      vis.id_focal = int.parse(b);
    });
  }

  void _updatePeri(String b) {
    setState(() {
      vis.id_peri = int.parse(b);
    });
  }

  void _updateNeb(String b) {
    setState(() {
      vis.id_nebul = int.parse(b);
    });
  }

  void _handleRadioTipoChange(int value) {
    setState(() {
      vis.tipo_trab = value;
    });
  }
}
