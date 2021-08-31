part of 'theme_cubit.dart';

class ThemeState extends Equatable {
  const ThemeState({
    required this.themeMode,
    required this.isDarkMode,
  });

  factory ThemeState.fromMap(Map<String, dynamic> map) {
    return ThemeState(
      themeMode: map['themeMode'] as ThemeMode,
      isDarkMode: map['isDarkMode'] as bool,
    );
  }

  factory ThemeState.fromJson(String source) =>
      ThemeState.fromMap(json.decode(source));

  final ThemeMode themeMode;
  final bool isDarkMode;

  @override
  List<Object> get props => [themeMode, isDarkMode];

  ThemeState copyWith({
    ThemeMode? themeMode,
    bool? isDarkMode,
  }) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'themeMode': this.themeMode,
      'isDarkMode': this.isDarkMode,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'ThemeState{themeMode: $themeMode, isDarkMode: $isDarkMode}';
  }
}
