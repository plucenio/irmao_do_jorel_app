import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:irmao_do_jorel_app/features/api/data/datasources_interfaces/jorels_brother_datasource.dart';
import 'package:irmao_do_jorel_app/features/api/domain/repositories_interfaces/jorels_brother_repository.dart';
import 'package:irmao_do_jorel_app/features/api/domain/usecases/jorels_brother_usecase.dart';
import 'package:irmao_do_jorel_app/features/api/external/datasources/jorels_brother_datasource.dart';
import 'package:irmao_do_jorel_app/features/api/presentation/pages/character_page.dart';
import 'package:irmao_do_jorel_app/features/api/presentation/pages/main_page.dart';
import 'features/api/data/repositories/jorels_brother_repository.dart';
import 'features/api/presentation/cubit/main_cubit.dart';
import 'features/api/presentation/pages/episode_page.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind<Dio>((i) => Dio()),
    Bind<IJorelsBrotherDatasource>((i) => JorelsBrotherDatasource()),
    Bind<IJorelsBrotherRepository>((i) => JorelsBrotherRepository()),
    Bind<IJorelsBrotherUsecase>((i) => JorelsBrotherUsecase()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => BlocProvider(
        create: (_) => MainCubit(),
        child: MainPage(),
      ),
    ),
    ChildRoute(
      CharacterPage.route,
      child: (context, args) => CharacterPage(
        character: args.data,
      ),
      transition: TransitionType.fadeIn,
    ),
    ChildRoute(
      EpisodePage.route,
      child: (context, args) => EpisodePage(
        episode: args.data,
      ),
      transition: TransitionType.fadeIn,
    ),
  ];
}
