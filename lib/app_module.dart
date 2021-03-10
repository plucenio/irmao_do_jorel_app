import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:irmao_do_jorel_app/features/api/data/datasources_interfaces/jorels_brother_datasource.dart';
import 'package:irmao_do_jorel_app/features/api/domain/repositories_interfaces/jorels_brother_repository.dart';
import 'package:irmao_do_jorel_app/features/api/domain/usecases/jorels_brother_usecase.dart';
import 'package:irmao_do_jorel_app/features/api/external/datasources/jorels_brother_datasource.dart';
import 'package:irmao_do_jorel_app/features/api/presentation/pages/character_page.dart';
import 'package:irmao_do_jorel_app/features/api/presentation/pages/characters_page.dart';

import 'app_widget.dart';
import 'features/api/data/repositories/jorels_brother_repository.dart';
import 'features/api/presentation/cubit/characters_cubit.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind<Dio>((i) => Dio()),
        Bind<IJorelsBrotherDatasource>((i) => JorelsBrotherDatasource()),
        Bind<IJorelsBrotherRepository>((i) => JorelsBrotherRepository()),
        Bind<IJorelsBrotherUsecase>((i) => JorelsBrotherUsecase()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  @override
  List<ModularRouter> get routers => [
        ModularRouter(
          Modular.initialRoute,
          child: (context, args) => BlocProvider(
            create: (_) => CharactersCubit(),
            child: CharactersPage(),
          ),
        ),
        ModularRouter(
          CharacterPage.route,
          child: (context, args) => CharacterPage(
            character: args.data,
          ),
          transition: TransitionType.fadeIn,
        ),
      ];
}
