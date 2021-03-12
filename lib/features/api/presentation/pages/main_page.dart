import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:irmao_do_jorel_app/features/api/presentation/cubit/main_cubit.dart';
import 'package:irmao_do_jorel_app/features/api/presentation/pages/character_page.dart';
import 'package:irmao_do_jorel_app/features/api/presentation/pages/episode_page.dart';

import '../../../../constants.dart';
import 'animated_controller.dart';

class MainPage extends StatefulWidget {
  static const String route = "/personagens";
  MainPage({
    Key key,
  }) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool okInfo = false;
  final animatedController = AnimatedController();
  final bottomNavigationBarAnimatedController = AnimatedController();
  int _currentSelectedItemBottomBar;

  @override
  void initState() {
    super.initState();
    _currentSelectedItemBottomBar = 0;
    context.read<MainCubit>().getData(true);
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
          _getData(),
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
      bottomNavigationBar: AnimatedBuilder(
        animation: bottomNavigationBarAnimatedController,
        builder: (context, snapshot) {
          return BottomNavigationBar(
            currentIndex: _currentSelectedItemBottomBar,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.people), label: "Personagens"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.video_label), label: "Episódios")
            ],
            onTap: (value) {
              _currentSelectedItemBottomBar = value;
              bottomNavigationBarAnimatedController.notify();
              context
                  .read<MainCubit>()
                  .getData(_currentSelectedItemBottomBar == 0);
            },
          );
        },
      ),
    );
  }

  Widget _getData() {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {
        if (state is ErrorState) {
          okInfo = true;
          animatedController.notify();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is ErrorWithSolutionState) {
          okInfo = true;
          animatedController.notify();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is SuccessStateCharacters) {
          okInfo = true;
          animatedController.notify();
        } else if (state is SuccessStateEpisodes) {
          okInfo = true;
          animatedController.notify();
        }
      },
      builder: (context, state) {
        if (state is LoadingState) {
          return Center(
            child: CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
            ),
          );
        } else if (state is SuccessStateCharacters) {
          return ListView(
            children: ListTile.divideTiles(
              context: context,
              tiles: state.list.map(
                (item) => Card(
                  child: ListTile(
                    leading: Image.network(item.imagemUrl),
                    title: Text(item.nome),
                    onTap: () {
                      Modular.to
                          .pushNamed(CharacterPage.route, arguments: item);
                    },
                  ),
                ),
              ),
            ).toList(),
          );
        } else if (state is SuccessStateEpisodes) {
          var season = 0;
          return ListView(
            children: ListTile.divideTiles(
              context: context,
              tiles: state.list.map(
                (item) {
                  if (season != item.temporadaId) {
                    season = item.temporadaId;
                    return Column(
                      children: [
                        Card(
                          child: ListTile(
                            title: Text(
                                "Temporada ${item.temporadaId.toString()}"),
                            tileColor: Colors.grey[400],
                          ),
                        ),
                        Card(
                          child: ListTile(
                            leading: Text(item.id.toString()),
                            title: Text(item.nome),
                            onTap: () {
                              Modular.to.pushNamed(EpisodePage.route,
                                  arguments: item);
                            },
                          ),
                        )
                      ],
                    );
                  }
                  return Card(
                    child: ListTile(
                      leading: Text(item.id.toString()),
                      title: Text(item.nome),
                      onTap: () {
                        Modular.to
                            .pushNamed(EpisodePage.route, arguments: item);
                      },
                    ),
                  );
                },
              ),
            ).toList(),
          );
        } else if (state is ErrorState) {
          return Container(
            child: Text(state.errorMessage),
          );
        } else if (state is ErrorWithSolutionState) {
          return Container(
            child: Column(
              children: [
                Text(state.errorMessage),
                Text(state.solution),
                Text(state.link),
              ],
            ),
          );
        } else {
          return Center(
            child: Text("Error"),
          );
        }
      },
    );
  }
}
