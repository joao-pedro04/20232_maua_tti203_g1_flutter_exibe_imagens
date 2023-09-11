import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'models/image_model.dart';

class App extends StatefulWidget {
  State<App> createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  int numeroImagens = 0;
  void obterImagem() {
    //uniform resource identifier
    //mailto:teste@email.om
    //tel:11991111393
    //www.google.com.br
    var url = Uri.https(
      'api.pexels.com',
      '/v1/search',
      {
        'query': 'people',
        'page': '1',
        'per_page': '1',
      },
    );
    var req = http.Request('get', url);
    req.headers.addAll({
      'Authorization':
          '563492ad6f91700001000001e00b21ab6afb45a18c1d44a759556f14'
    });
    //IO-Bound (tem também CPU-Bound)
    final result = await req.send();
    if (result.statusCode == 200){
      // converter de streamedresponse para response
      final response = await http.Response.fromStream(result);
      final decodedJSON = json.decode(response.body);
      final imagem = ImagemModel.fromJSON(decodeJSON);
      print (imagem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Text('$numeroImagens'),
        floatingActionButton: FloatingActionButton(
          onPressed: obterImagem,
          child: const Icon(Icons.add_a_photo),
        ),
        appBar: AppBar(
          title: const Text('Minhas imagens'),
        ),
      ),
    );
  }
}
