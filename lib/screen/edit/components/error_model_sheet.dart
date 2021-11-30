import 'package:notes/_app_packages.dart';
import 'package:notes/_internal_packages.dart';

class ErrorModalSheet extends StatelessWidget {
  const ErrorModalSheet({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => SizedBox(
        child: Text(Language.of(context).error),
      );
}