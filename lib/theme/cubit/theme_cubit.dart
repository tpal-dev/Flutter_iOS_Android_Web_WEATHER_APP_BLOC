import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ThemeCubit extends Cubit<bool> with HydratedMixin {
  ThemeCubit() : super(true);

  void updateTheme(bool isDarkMode) => (isDarkMode) ? emit(true) : emit(false);

  @override
  bool? fromJson(Map<String, dynamic> json) {
    return json['isDarkMode'] as bool;
  }

  @override
  Map<String, dynamic>? toJson(bool state) {
    return <String, bool>{'isDarkMode': state};
  }
}
