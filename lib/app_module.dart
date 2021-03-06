import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:irmao_do_jorel_app/my_home_page.dart';

import 'app_widget.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [];

  @override
  Widget get bootstrap => AppWidget();

  @override
  List<ModularRouter> get routers => [
        ModularRouter(
          Modular.initialRoute,
          child: (context, args) => MyHomePage(),
        ),
      ];
}
