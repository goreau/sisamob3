import 'package:flutter/material.dart';
import 'package:sisamob3/models/menu.dart';

class MenuTile extends StatelessWidget {
  final Menu menu;

  const MenuTile(this.menu);

  @override
  Widget build(BuildContext context) {
    if (menu.icon == null) {}
    return ListTile(
      title: Text(menu.nome),
      leading: menu.icon,
      onTap: () {},
    );
  }
}
