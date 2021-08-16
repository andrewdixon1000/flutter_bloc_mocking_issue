import 'package:get_it/get_it.dart';

import 'bloc/my_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  serviceLocator.registerFactory(() => MyBloc());
}