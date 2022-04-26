import 'package:notes/_aap_packages.dart';
import 'package:notes/_external_packages.dart';
import 'package:notes/_internal_packages.dart';

class HomeNoteOptions extends StatefulWidget {
  const HomeNoteOptions({
    required this.note,
    required this.autoSaver,
    required this.saveNote,
    final Key? key,
  }) : super(key: key);

  final Note note;
  final Timer autoSaver;
  final Function() saveNote;

  @override
  _HomeNoteOptionsState createState() => _HomeNoteOptionsState();
}

class _HomeNoteOptionsState extends State<HomeNoteOptions> {
  @override
  Widget build(final BuildContext context) {
    return Wrap(
      children: [
        Container(
          margin: const EdgeInsets.all(8),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_outlined),
                onPressed: () => Navigator.of(context).pop(),
              ),
              const SizedBox(width: 16),
              Text(Language.of(context).options),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: 16,
          ),
          child: Column(
            children: [
              Flex(
                direction: Axis.horizontal,
                children: [
                  ModalSheetWidget(
                    label: Language.of(context).hide,
                    icon: TablerIcons.ghost,
                    onTap: () async {
                      widget.autoSaver.cancel();
                      widget.saveNote();
                      final status = Provider.of<AppConfiguration>(
                        context,
                        listen: false,
                      ).password.isNotEmpty;
                      if (!status) {
                        await showDialog(
                          barrierDismissible: true,
                          context: context,
                          builder: (final context) => MyAlertDialog(
                            content:
                                Text(Language.of(context).setPasswordFirst),
                          ),
                        );
                      } else {
                        await Provider.of<NotesHelper>(context, listen: false)
                            .hide(widget.note);
                      }
                      if (!mounted) {
                        return;
                      }
                      Navigator.of(context).popUntil(
                        (final route) =>
                            route.settings.name == widget.note.path,
                      );
                    },
                  ),
                  ModalSheetWidget(
                    onTap: () {
                      widget.autoSaver.cancel();
                      widget.saveNote();
                      unawaited(
                        Provider.of<NotesHelper>(context, listen: false)
                            .archive(widget.note),
                      );
                      Navigator.of(context).popUntil(
                        ModalRoute.withName(widget.note.path),
                      );
                    },
                    icon: Icons.archive_outlined,
                    label: Language.of(context).archive,
                  ),
                  ModalSheetWidget(
                    icon: TablerIcons.copy,
                    onTap: () {
                      widget.autoSaver.cancel();
                      widget.saveNote();
                      Navigator.of(context).pop();
                      unawaited(
                        Clipboard.setData(
                          ClipboardData(text: widget.note.title),
                        ).then((final _) {
                          Clipboard.setData(
                            ClipboardData(text: widget.note.content),
                          ).then(
                            (final value) => showSnackbar(
                              context,
                              Language.of(context).done,
                              snackBarBehavior: SnackBarBehavior.floating,
                            ),
                          );
                        }),
                      );
                    },
                    label: Language.of(context).clipboard,
                  ),
                  ModalSheetWidget(
                    icon: Icons.delete_outlined,
                    onTap: () async {
                      widget.autoSaver.cancel();
                      widget.saveNote();
                      unawaited(
                        Provider.of<NotesHelper>(context, listen: false)
                            .trash(widget.note),
                      );
                      Navigator.of(context).popUntil(
                        (final route) =>
                            route.settings.name == widget.note.path,
                      );
                    },
                    label: Language.of(context).delete,
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
