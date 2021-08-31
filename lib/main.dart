import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:weather_app/app.dart';
import 'package:weather_app/app_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // WidgetBindings init before building an app
  // (we have to be able to call a native code for the HydratedBloc storage)
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}
