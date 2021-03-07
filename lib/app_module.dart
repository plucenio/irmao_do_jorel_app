import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:irmao_do_jorel_app/features/teste/data/datasources_interfaces/jorels_brother_datasource.dart';
import 'package:irmao_do_jorel_app/features/teste/domain/repositories_interfaces/jorels_brother_repository.dart';
import 'package:irmao_do_jorel_app/features/teste/domain/usecases/jorels_brother_usecase.dart';
import 'package:irmao_do_jorel_app/features/teste/external/datasources/jorels_brother_datasource.dart';
import 'package:irmao_do_jorel_app/main_page.dart';

import 'app_widget.dart';
import 'features/teste/data/repositories/jorels_brother_repository.dart';

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
          child: (context, args) => MainPage(),
        ),
      ];
}
