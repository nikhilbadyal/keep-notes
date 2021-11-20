import 'package:notes/_app_packages.dart';
import 'package:notes/_internal_packages.dart';

Color defaultPrimary = Colors.deepOrange;
Color defaultAccent = Colors.deepOrangeAccent;

class AppConfiguration with ChangeNotifier {
  AppConfiguration();

  // late Color primaryColor;
  // late Color accentColor;
  // late AppTheme appTheme;
  // late ThemeData currentTheme;
  // late bool isHiddenDiscovered;

  /*void readFromSf() {
    primaryColor = Color(getIntFromSF('primaryColor') ?? defaultPrimary.value);
    accentColor = Color(getIntFromSF('accentColor') ?? defaultAccent.value);
    appTheme = AppTheme.values[getIntFromSF('appTheme') ?? 0];
    currentTheme = appTheme == AppTheme.light
        ? lightTheme(primaryColor, accentColor)
        : blackTheme(primaryColor, accentColor);
    isHiddenDiscovered = getBoolFromSF('hiddenDiscovered') ?? false;
    SqfliteDatabaseHelper.syncedWithFirebase =
        getBoolFromSF('syncedWithFirebase') ?? false;
  }*/

  void changePrimaryColor(final Color primaryColor) {
    addIntToSF('primaryColor', primaryColor.value);
    notifyListeners();
  }

  void changeAccentColor(final Color accentColor) {
    addIntToSF('accentColor', accentColor.value);
    notifyListeners();
  }

  void changeAppTheme(final AppTheme appTheme) {
    addIntToSF('appTheme', appTheme.index);
    notifyListeners();
  }

  // ignore: avoid_positional_boolean_parameters
  Future<void> setHiddenDiscovered(final bool status) async {
    await addBoolToSF('hiddenDiscovered', value: status);
  }

  void changeLocale(
    final String langCode,
  ) {
    addStringToSF('appLocale', langCode);
  }
}

List<BoxShadow> shadow = [
  BoxShadow(
    color: Colors.grey[200]!,
    blurRadius: 30,
    offset: const Offset(0, 10),
  )
];

enum AppTheme { dark, black, light }