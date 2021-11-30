import 'package:notes/_app_packages.dart';
import 'package:notes/_external_packages.dart';
import 'package:notes/_internal_packages.dart';

final RouteObserver<Route> routeObserver = RouteObserver<Route>();

late Encrypt encryption;
final LocalAuthentication localAuthentication = LocalAuthentication();

class MyNotes extends StatefulWidget {
  const MyNotes({
    final Key? key,
  }) : super(key: key);

  static void setLocale(final BuildContext context, final Locale newLocale) {
    final state = context.findAncestorStateOfType<_MyNotesState>();
    state!.setLocale(newLocale);
  }

  @override
  _MyNotesState createState() => _MyNotesState();
}

class _MyNotesState extends State<MyNotes> {
  Locale? _locale;
  final supportedLocales = <Locale>[];

  Iterable<LocalizationsDelegate<dynamic>>? localizationDelegates = [
    const AppLocalizationsDelegate(),
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  @override
  void initState() {
    super.initState();
    for (final element in supportedLanguages) {
      supportedLocales.add(Locale(element.languageCode, ''));
    }
  }

  void setLocale(final Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Future<void> didChangeDependencies() async {
    await getLocale().then((final locale) {
      setState(() {
        _locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(final BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NotesHelper>(
          create: (final _) => NotesHelper(),
        ),
        ChangeNotifierProvider<AppConfiguration>(
          create: (final _) => AppConfiguration(),
        ),
        ChangeNotifierProvider<Auth>(
          create: (final _) => Auth(),
        ),
      ],
      child: Builder(
        builder: (final context) {
          Provider.of<AppConfiguration>(context);
          final curUser =
              Provider.of<Auth>(context, listen: false).auth.currentUser;
          if (curUser != null) {
            initialize(context);
          }
          final initRoute = Provider.of<Auth>(context, listen: false).isLoggedIn
              ? '/'
              : 'welcome';
          return MaterialApp(
            locale: _locale,
            restorationScopeId: 'keepnotes',
            supportedLocales: supportedLocales,
            localizationsDelegates: localizationDelegates,
            localeResolutionCallback: localeResolutionCallback,
            theme: getThemeData(),
            title: Language.of(context).appTitle,
            initialRoute: initRoute,
            debugShowCheckedModeBanner: false,
            navigatorObservers: [routeObserver],
            onGenerateRoute: RouteGenerator.generateRoute,
          );
        },
      ),
    );
  }

  Locale? localeResolutionCallback(
      final Locale? locale, final Iterable<Locale> supportedLocales) {
    for (final supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale?.languageCode &&
          supportedLocale.countryCode == locale?.countryCode) {
        return supportedLocale;
      }
    }
    return supportedLocales.first;
  }
}
