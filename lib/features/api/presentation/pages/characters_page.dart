import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:irmao_do_jorel_app/features/api/presentation/cubit/characters_cubit.dart';
import 'package:irmao_do_jorel_app/features/api/presentation/pages/character_page.dart';

import '../../../../constants.dart';
import 'animated_controller.dart';

class CharactersPage extends StatefulWidget {
  static const String route = "/personagens";
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
              } else if (state is SuccessState) {
                okInfo = true;
                animatedController.notify();
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
                          onTap: () {
                            Modular.to.pushNamed(CharacterPage.route,
                                arguments: item);
                          },
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
              return Transform.scale(
                scale: 2,
                child: AnimatedContainer(
                  transform: Transform.translate(
                      offset: Offset(
                    okInfo ? height : height * 0.1,
                    okInfo ? width : (width * 0.1) * -1,
                  )).transform,
                  curve: animatedController.curve,
                  duration: animatedController.duration,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: okInfo ? Colors.transparent : Colors.green[600],
                  ),
                ),
              );
            },
          ),
          AnimatedBuilder(
            animation: animatedController,
            builder: (context, snapshot) {
              return Transform.scale(
                scale: 2,
                child: AnimatedContainer(
                  transform: Transform.translate(
                      offset: Offset(
                    okInfo ? height : height * 0.1,
                    okInfo ? width : width * 0.2,
                  )).transform,
                  curve: animatedController.curve,
                  duration: animatedController.duration,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: okInfo ? Colors.transparent : Colors.green[400],
                  ),
                ),
              );
            },
          ),
          AnimatedBuilder(
            animation: animatedController,
            builder: (context, snapshot) {
              return AnimatedContainer(
                transform: Transform.translate(
                  offset: Offset(
                    okInfo ? width : width * 0.4 - 5,
                    okInfo ? height : height * 0.4 - 5,
                  ),
                ).transform,
                curve: animatedController.curve,
                duration: animatedController.duration,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: okInfo ? Colors.transparent : Colors.brown[400],
                ),
              );
            },
          ),
          AnimatedBuilder(
            animation: animatedController,
            builder: (context, snapshot) {
              return AnimatedContainer(
                transform: Transform.translate(
                  offset: Offset(
                    okInfo ? width : width * 0.4,
                    okInfo ? height : height * 0.4,
                  ),
                ).transform,
                curve: animatedController.curve,
                duration: animatedController.duration,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: okInfo ? Colors.transparent : Colors.brown,
                ),
              );
            },
          ),
          AnimatedBuilder(
            animation: animatedController,
            builder: (context, snapshot) {
              return AnimatedContainer(
                transform: Transform.translate(
                  offset: Offset(
                    okInfo ? width : 0,
                    okInfo ? height : 0,
                  ),
                ).transform,
                curve: animatedController.curve,
                duration: animatedController.duration,
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    child: Image.asset(
                      "assets/image.png",
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: AnimatedBuilder(
            animation: animatedController,
            builder: (context, snapshot) {
              return Icon(okInfo ? Icons.info : Icons.check);
            }),
        onPressed: () {
          okInfo = !okInfo;
          animatedController.notify();
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
