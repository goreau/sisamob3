import 'package:flutter/material.dart';

class Increment extends StatefulWidget {
  final int _valor;

  Increment(this._valor);

  @override
  _IncrementState createState() => _IncrementState();
}

class _IncrementState extends State<Increment> {
  int _n = 0;
  @override
  void initState() {
    super.initState();
    //  _n = widget._valor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FloatingActionButton(
                onPressed: add,
                child: Icon(Icons.add, color: Colors.black),
                backgroundColor: Colors.white,
              ),
              Text('$_n', style: new TextStyle(fontSize: 60.0)),
              FloatingActionButton(
                onPressed: minus,
                child: Icon(Icons.exposure_minus_1, color: Colors.black),
                backgroundColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void add() {
    setState(() {
      _n++;
    });
  }

  void minus() {
    setState(() {
      if (_n != 0) _n--;
    });
  }
}
