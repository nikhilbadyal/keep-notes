import 'package:notes/_app_packages.dart';
import 'package:notes/_external_packages.dart';
import 'package:notes/_internal_packages.dart';

class SetPassword extends StatefulWidget {
  const SetPassword({final Key? key}) : super(key: key);

  @override
  _SetPasswordState createState() => _SetPasswordState();
}

class _SetPasswordState extends State<SetPassword> {
  String enteredPassCode = '';
  late bool isFirst;
  late String firstPass;
  late String title;
  late DataObj args;

  final StreamController<bool> _verificationNotifier =
      StreamController<bool>.broadcast();

  @override
  void dispose() {
    _verificationNotifier.close();
    super.dispose();
  }

  void _onTap(final String text) {
    HapticFeedback.vibrate();

    setState(() {
      if (isFirst) {
        if (enteredPassCode.length < 4) {
          enteredPassCode += text;
          if (enteredPassCode.length == 4) {
            _doneEnteringPass(enteredPassCode);
          }
        }
      } else {
        if (enteredPassCode.length < firstPass.length) {
          enteredPassCode += text;
          if (enteredPassCode.length == firstPass.length) {
            _doneEnteringPass(enteredPassCode);
          }
        }
      }
    });
  }

  void _onDelTap() {
    HapticFeedback.vibrate();
    if (enteredPassCode.isNotEmpty) {
      setState(() {
        enteredPassCode =
            enteredPassCode.substring(0, enteredPassCode.length - 1);
      });
    }
  }

  Future<void> _doneEnteringPass(final String enteredPassCode) async {
    if (isFirst) {
      await navigate(
        ModalRoute.of(context)!.settings.name!,
        context,
        AppRoutes.setPassScreen,
        DataObj(enteredPassCode, Language.of(context).reEnterPassword,
            resetPass: args.resetPass, isFirst: false),
      );
    } else {
      if (enteredPassCode == firstPass) {
        if (args.resetPass) {
          if (Provider.of<LockChecker>(context, listen: false).password ==
              enteredPassCode) {
            Utilities.showSnackbar(
              context,
              Language.of(context).samePasswordError,
              duration: const Duration(milliseconds: 1500),
            );
          } else {
            await Provider.of<LockChecker>(context, listen: false)
                .resetConfig(shouldResetBio: false);
            await Provider.of<NotesHelper>(context, listen: false)
                .recryptEverything(enteredPassCode);
            unawaited(Provider.of<LockChecker>(context, listen: false)
                .passwordSetConfig(enteredPassCode));
          }
          await Navigator.of(context)
              .pushReplacementNamed(AppRoutes.settingsScreen);
          return;
        } else {
          unawaited(Provider.of<LockChecker>(context, listen: false)
              .passwordSetConfig(enteredPassCode));
          Utilities.showSnackbar(
            context,
            Language.of(context).done,
          );
          await navigate(ModalRoute.of(context)!.settings.name!, context,
              AppRoutes.hiddenScreen);
        }
      } else {
        Utilities.showSnackbar(
          context,
          Language.of(context).passwordNotMatch,
        );
        await navigate(
          ModalRoute.of(context)!.settings.name!,
          context,
          AppRoutes.setPassScreen,
          DataObj(
            '',
            Language.of(context).enterNewPassword,
            isFirst: true,
          ),
        );
      }
    }
  }

  Widget _titleWidget(final String title) => Text(
        '$title ',
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      );

  @override
  Widget build(final BuildContext context) {
    args = ModalRoute.of(context)!.settings.arguments! as DataObj;
    isFirst = args.isFirst;
    firstPass = args.firstPass;
    title = args.heading;
    final titleWidget = _titleWidget(title);
    return MyLockScreen(
      title: titleWidget,
      onTap: _onTap,
      onDelTap: _onDelTap,
      enteredPassCode: enteredPassCode,
      stream: _verificationNotifier.stream,
      doneCallBack: (final _) {},
    );
  }
}

class DataObj {
  DataObj(this.firstPass, this.heading,
      {required this.isFirst, this.resetPass = false});

  final bool isFirst;
  final String firstPass;
  final String heading;
  final bool resetPass;
}