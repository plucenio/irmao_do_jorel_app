import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:irmao_do_jorel_app/features/teste/domain/usecases/jorels_brother_usecase.dart';

import 'constants.dart';
import 'features/teste/domain/entities/character.dart';

class MainPage extends StatefulWidget {
  MainPage({
    Key key,
  }) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Character> lista = [];

  @override
  void initState() {
    super.initState();

    Modular.get<IJorelsBrotherUsecase>().getCharacters().then(
          (value) => value.fold((l) => null, (r) {
            setState(() {
              lista = r;
            });
          }),
        );
  }

  @override
  Widget build(BuildContext context) {
    var name = (lista == null || lista.length == 0) ? "" : lista.first.nome;
    return Scaffold(
      appBar: AppBar(
        title: Text(app_name),
      ),
      body: Center(
        child: Card(
          child: ListTile(
            title: Text(name),
            dense: true,
          ),
        ),
      ),
    );
  }
}
