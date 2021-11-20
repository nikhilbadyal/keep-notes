import 'package:notes/_app_packages.dart';
import 'package:notes/_external_packages.dart';
import 'package:notes/_internal_packages.dart';

Future<void> syncNotes(final BuildContext context) async {
  final notesList =
      await Provider.of<NotesHelper>(context, listen: false).myGetAll();
  await SqfliteDatabaseHelper.addAll(notesList);
  SqfliteDatabaseHelper.syncedWithFirebase = true;
  unawaited(addBoolToSF('syncedWithFirebase', value: true));
}