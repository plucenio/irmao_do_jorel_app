import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:irmao_do_jorel_app/features/api/presentation/cubit/characters_cubit.dart';

import '../../../../constants.dart';
import 'animated_controller.dart';

class CharactersPage extends StatefulWidget {
  CharactersPage({
    Key key,
  }) : super(key: key);

  @override
  _CharactersPageState createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  bool okInfo = false;

  final animatedController = AnimatedController();

  @override
  void initState() {
    super.initState();
    context.read<CharactersCubit>().getCharacters();
  }

  @override
  Widget build(BuildContext context) {
    var landscape =
        MediaQuery.of(context).size.width > MediaQuery.of(context).size.height;

    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(app_name),
      ),
      body: Stack(
        children: [
          BlocConsumer<CharactersCubit, CharactersState>(
            listener: (context, state) {
              if (state is ErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is LoadingState) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor),
                  ),
                );
              } else if (state is SuccessState) {
                return ListView(
                  children: ListTile.divideTiles(
                    context: context,
                    tiles: state.list.map(
                      (item) => Card(
                        child: ListTile(
                          leading: Image.network(item.imagemUrl),
                          title: Text(item.nome),
                          onTap: () {},
                        ),
                      ),
                    ),
                  ).toList(),
                );
              } else if (state is ErrorState) {
                return Container(
                  child: Text(state.errorMessage),
                );
              } else {
                return Center(
                  child: Text("Error"),
                );
              }
            },
          ),
          AnimatedBuilder(
            animation: animatedController,
            builder: (context, snapshot) {
              return AnimatedContainer(
                duration: animatedController.duration,
                transform: Transform.translate(
                  offset: Offset(
                    animatedController.x,
                    animatedController.y,
                  ),
                ).transform,
                child: Transform.scale(
                  scale: 2,
                  child: AnimatedContainer(
                    transform: Transform.translate(
                        offset: Offset(
                      okInfo ? height : height * 0.1,
                      okInfo ? width : (width * 0.1) * -1,
                    )).transform,
                    curve: Curves.decelerate,
                    duration: Duration(milliseconds: 1500),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: okInfo ? Colors.transparent : Colors.green[600],
                    ),
                  ),
                ),
              );
            },
          ),
          Transform.scale(
            scale: 2,
            child: AnimatedContainer(
              transform: Transform.translate(
                  offset: Offset(
                okInfo ? height : height * 0.1,
                okInfo ? width : width * 0.2,
              )).transform,
              curve: Curves.decelerate,
              duration: Duration(milliseconds: 1500),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: okInfo ? Colors.transparent : Colors.green[400],
              ),
            ),
          ),
          AnimatedContainer(
            transform: Transform.translate(
              offset: Offset(
                okInfo ? width : width * 0.4 - 5,
                okInfo ? height : height * 0.4 - 5,
              ),
            ).transform,
            curve: Curves.decelerate,
            duration: Duration(milliseconds: 1500),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: okInfo ? Colors.transparent : Colors.brown[400],
            ),
          ),
          AnimatedContainer(
            transform: Transform.translate(
              offset: Offset(
                okInfo ? width : width * 0.4,
                okInfo ? height : height * 0.4,
              ),
            ).transform,
            curve: Curves.decelerate,
            duration: Duration(milliseconds: 1500),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: okInfo ? Colors.transparent : Colors.brown,
            ),
          ),
          AnimatedContainer(
            transform: Transform.scale(scale: okInfo ? 0 : 1).transform,
            curve: Curves.decelerate,
            duration: Duration(seconds: 1),
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  width * (landscape ? 0.4 : 0.2),
                  height * (landscape ? 0.4 : 0.2),
                  width * (landscape ? 0.4 : 0.2),
                  0),
              child: Align(
                alignment: Alignment.center,
                child: Column(children: [
                  Image.asset(
                    "assets/image.png",
                  ),
                  Text(
                    "Irmão do Jorel API é uma API Rest que trás algumas inforamções sobre os personagens e episódios da série. Dados buscados da API: http://www.irmaodojorelapi.site/",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .copyWith(color: Colors.white)
                        .copyWith(fontSize: 10),
                  ),
                ]),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(okInfo ? Icons.info : Icons.check),
        onPressed: () {
          setState(
            () {
              //okInfo = !okInfo;
              animatedController.teste();
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.people), label: "Personagens"),
          BottomNavigationBarItem(
              icon: Icon(Icons.video_label), label: "Episódios")
        ],
      ),
    );
  }
}
