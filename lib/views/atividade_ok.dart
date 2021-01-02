import 'package:flutter/material.dart';
import 'package:sisamob3/components/dropdown.dart';
import 'package:sisamob3/util/auxiliar.dart';

class Atividade extends StatefulWidget {
  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Atividade> {
  List<DropdownMenuItem<String>> lstMun;
  String mun = '0';
  @override
  void initState() {
    super.initState();
    Auxiliar.loadData('municipio', null).then((value) {
      setState(() {
        lstMun = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print('create $lstMun');
    if (lstMun == null) {
      return CircularProgressIndicator();
    }
    return Card(
      elevation: 10,
      child: Container(
        height: ((MediaQuery.of(context).size.height) / 2),
        padding: EdgeInsets.all(20),
        child: Scaffold(
          appBar: new AppBar(
            title: const Text('Add transaction'),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Dropdown('Municipio', lstMun, mun, update: _setCens),
                ],
              ),
              RaisedButton(
                child: Text('Submit'),
                onPressed: () {},
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

  // Add this function.
  void _setCens(String b) {
    setState(() {
      mun = b;
    });
  }
}
