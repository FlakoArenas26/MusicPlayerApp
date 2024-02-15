import 'package:music_player/src/presentation/utils/theme/themes.dart';

class ThemeRepository {
  Future<void> updateTheme(String themeName) async {
    await Themes.setTheme(themeName);
  }
}
