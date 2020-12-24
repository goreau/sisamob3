import 'dart:convert';

import 'package:http/http.dart' as http;

class Comunica{
  Future<Album> fetchAlbum() async {
  final response =
      await http.get('https://200.144.1.24/dados/cadastro.php?id=144&nivel=2');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
}