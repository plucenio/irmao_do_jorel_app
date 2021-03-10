import 'package:flutter/material.dart';
import 'package:irmao_do_jorel_app/constants.dart';
import 'package:irmao_do_jorel_app/features/api/domain/entities/character.dart';

class CharacterPage extends StatelessWidget {
  static const String route = "/personagem";
  final Character character;
  const CharacterPage({Key key, this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(app_name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: character == null
                ? Container(
                    child: Center(
                      child: Text("O personagem não pôde ser carregado."),
                    ),
                    height: double.infinity,
                    width: double.infinity,
                  )
                : ListView(
                    children: [
                      Center(
                        child: Image.network(
                          character.imagemUrl ?? "",
                          height: height * 0.3,
                        ),
                      ),
                      Text(
                        character.nome ?? "",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Text(
                        "Biografia: ${character.biografia ?? ""}",
                        style: Theme.of(context).textTheme.caption,
                      ),
                      Text(
                        "Descrição: ${character.descricao ?? ""}",
                        style: Theme.of(context).textTheme.caption,
                      ),
                      Text(
                        "Personalidade: ${character.personalidade ?? ""}",
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
