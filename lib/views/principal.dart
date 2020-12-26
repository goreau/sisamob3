import 'package:flutter/material.dart';
import 'package:sisamob3/util/comunica.dart';
import 'package:sisamob3/util/routes.dart';

class Principal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sisamob vs.3'),
      ),
      body: new Container(
        color: Colors.grey[200],
        child: new Image.asset('assets/images/aedes.jfif'),
        alignment: Alignment.center,
      ),
      drawer: Container(
        width: 250,
        child: Drawer(
          child: ListView(
            children: <Widget>[
              Container(
                height: 100,
                child: DrawerHeader(
                  child: ListTile(
                    leading: Icon(Icons.bug_report),
                    title: Text('Sisamob'),
                    subtitle: Text('Sistema para coleta de informações'),
                  ),
                  decoration: BoxDecoration(color: Colors.greenAccent),
                ),
              ),
              Container(
                height: 40,
                child: ListTile(
                  leading: Icon(Icons.home),
                  title: Text(
                    'Início',
                    style: TextStyle(fontSize: 12),
                  ),
                  onTap: () {},
                ),
              ),
              Container(
                height: 5,
                child: Divider(
                  color: Colors.blue,
                ),
              ),
              Container(
                height: 40,
                child: ListTile(
                  title: Text(
                    'Atividades',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
              Container(
                height: 40,
                child: ListTile(
                  leading: Icon(Icons.home_work_outlined),
                  title: Text(
                    'Registrar',
                    style: TextStyle(fontSize: 12),
                  ),
                  onTap: () {},
                ),
              ),
              Container(
                height: 40,
                child: ListTile(
                  leading: Icon(Icons.assignment_outlined),
                  title: Text(
                    'Consultar',
                    style: TextStyle(fontSize: 12),
                  ),
                  onTap: () {},
                ),
              ),
              Container(
                height: 40,
                child: ListTile(
                  leading: Icon(Icons.my_location_outlined),
                  title: Text(
                    'Atualizar Coordenadas',
                    style: TextStyle(fontSize: 12),
                  ),
                  onTap: () {},
                ),
              ),
              Container(
                height: 40,
                child: ListTile(
                  leading: Icon(Icons.list),
                  title: Text(
                    'Relatório de Produção',
                    style: TextStyle(fontSize: 12),
                  ),
                  onTap: () {},
                ),
              ),
              Container(
                height: 40,
                child: ListTile(
                  leading: Icon(Icons.plumbing_outlined),
                  title: Text(
                    'Manutenção',
                    style: TextStyle(fontSize: 12),
                  ),
                  onTap: () {},
                ),
              ),
              Container(
                height: 10,
                child: Divider(
                  color: Colors.blue,
                ),
              ),
              Container(
                height: 40,
                child: ListTile(
                  title: Text(
                    'Comunicação',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
              Container(
                height: 40,
                child: ListTile(
                  leading: Icon(Icons.share),
                  title: Text(
                    'Exportar Produção',
                    style: TextStyle(fontSize: 12),
                  ),
                  onTap: () {},
                ),
              ),
              Container(
                height: 40,
                child: ListTile(
                  leading: Icon(Icons.cloud),
                  title: Text(
                    'Importar Cadastro',
                    style: TextStyle(fontSize: 12),
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      Routes.COM_IMPORTA
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
