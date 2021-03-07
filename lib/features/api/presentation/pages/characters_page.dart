import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:irmao_do_jorel_app/features/api/presentation/cubit/characters_cubit.dart';

import '../../../../constants.dart';

class CharactersPage extends StatefulWidget {
  CharactersPage({
    Key key,
  }) : super(key: key);

  @override
  _CharactersPageState createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  @override
  void initState() {
    super.initState();

    context.read<CharactersCubit>().getCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(app_name),
      ),
      body: Center(
        child: BlocConsumer<CharactersCubit, CharactersState>(
          listener: (context, state) {
            return Center(
              child: Text("listener"),
            );
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
              return Center(
                child: Text(state.errorMessage),
              );
            } else {
              return Center(
                child: Text("Error"),
              );
            }
          },
        ),
      ),
    );
  }
}
