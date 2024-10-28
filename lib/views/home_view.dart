import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_bloc/generated/l10n.dart';
import 'package:notes_bloc/helpers/request_helper.dart';
import 'package:notes_bloc/helpers/request_states.dart';
import 'package:notes_bloc/shared.dart';
import 'package:notes_bloc/views/display_note_view.dart';
import 'package:notes_bloc/views/widgets/app_logo_button.dart';
import 'package:notes_bloc/views/widgets/note_item_tile.dart';
import 'package:notes_bloc/views/widgets/failure_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../blocs/home/home_bloc.dart';
import '../blocs/home/home_event.dart';
import '../blocs/home/home_state.dart';
import '../data/models/note_model.dart';
import 'note_editing_view.dart';
import 'widgets/notes_app_drawer.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  static const id = 'home';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool hasInitialized = false;
  bool isSelectionMode = false;
  bool canPop = false;
  final List<int> selectedNotes = [];

  chekVersion(BuildContext context) async {
    final verState = await RequestHelper.checkAppVersionState();
    if (verState is OldVersionFailure) {
      if (context.mounted) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return FailureDialog(
                  failure: verState,
                  errorMessage: verState.getFailureMessage());
            });
      }
    }
  }

  initUser() async {
    final prefs = await SharedPreferences.getInstance();
    final hasInitUser = (prefs.getBool(PrefsKeys.idInitFlagKey));
    if (hasInitUser == null) {
    } else {
      if (!hasInitUser) {
        final initState = await RequestHelper.handelDeviceId(updateUser: true);
        if (initState is Success) {
          prefs.setBool(PrefsKeys.idInitFlagKey, true);
        }
      }
    }
  }

  initPage(BuildContext context) async {
    if (!hasInitialized) {
      BlocProvider.of<NoteBloc>(context).add(Initial());
      await chekVersion(context);
      await initUser();
      hasInitialized = true;
    }
  }

  @override
  void initState() {
    super.initState();
    initPage(context);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop,
      onPopInvokedWithResult: (didPop, result) async {
        if (isSelectionMode) {
          selectedNotes.clear();
          isSelectionMode = false;
          setState(() {});
        } else {
          Future(() async {
            await showDialog(
                context: context,
                builder: (context) {
                  return ActionConfirmationDialog(
                    onCancel: () {
                      Navigator.pop(context);
                    },
                    onConfirm: () {
                      Navigator.pop(context);
                      canPop = true;
                    },
                    title: S.of(context).appCloseMsg,
                    cancelText: S.of(context).cancel,
                    confirmText: S.of(context).confirm,
                  );
                });
          }).then(
            (value) {
              setState(() {});
              if (canPop) {
                SystemNavigator.pop();
              }
            },
          );
        }
      },
      child: Scaffold(
        drawer: const NotesAppDrawer(),
        appBar: AppBar(
          toolbarHeight: 64,
          leadingWidth: 64,
          iconTheme: const IconThemeData(size: 34),
          actions: const [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 6.0, bottom: 6),
                  child: AppLogoButton(),
                ),
                SizedBox(width: 16),
              ],
            ),
          ],

          title: Text(S.of(context).myNotes),
          // actions: [],
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.surface,
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: BlocBuilder<NoteBloc, NoteState>(
            builder: (context, state) {
              if (state is NoteLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is NoteLoadSuccess) {
                final List<NoteModel> notes = state.notes;

                if (notes.isEmpty) {
                  return Center(
                    child: Text(S.of(context).emptyNotes,
                        style: Styles.headlineMedium),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    final note = notes[index];
                    return ColoredBox(
                      color: selectedNotes.contains(note.id!)
                          ? Colors.blue.withOpacity(0.5)
                          : Colors.transparent,
                      child: NoteItemTile(
                        isSelectionMode: isSelectionMode,
                        onLongPress: () {
                          if (!isSelectionMode) {
                            selectedNotes.clear();
                            isSelectionMode = true;
                            selectedNotes.add(note.id!);
                            setState(() {});
                          }
                        },
                        note: note,
                        onEdit: () {
                          _navigateToNoteEditingView(context, note);
                        },
                        onDelete: () {
                          final notesBloc = context.read<NoteBloc>();
                          showDialog(
                              context: context,
                              builder: (context) {
                                return BlocProvider.value(
                                  value: notesBloc,
                                  child: ActionConfirmationDialog(
                                    onCancel: () {
                                      Navigator.pop(context);
                                    },
                                    onConfirm: () {
                                      notesBloc.add(DeleteNote(id: note.id!));
                                      Navigator.pop(context);
                                    },
                                    title: S.of(context).deleteNoteMsg,
                                    cancelText: S.of(context).cancel,
                                    confirmText: S.of(context).confirm,
                                  ),
                                );
                              });
                        },
                        onDisplay: () {
                          if (isSelectionMode) {
                            if (selectedNotes.contains(note.id)) {
                              selectedNotes.remove(note.id);
                              if (selectedNotes.isEmpty) {
                                isSelectionMode = false;
                              }
                            } else {
                              selectedNotes.add(note.id!);
                            }
                            setState(() {});
                          } else {
                            _navigateToDisplayNoteView(context, note);
                          }
                        },
                      ),
                    );
                  },
                );
              } else if (state is NoteOperationFailure) {
                return Center(
                  child:
                      Text('${S.of(context).loadError}\n${state.errorMessage}'),
                );
              } else {
                return Center(
                  child: Text(S.of(context).loadError),
                );
              }
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(isSelectionMode ? Icons.delete : Icons.add),
          onPressed: () {
            if (isSelectionMode) {
              final notesBloc = context.read<NoteBloc>();
              showDialog(
                  context: context,
                  builder: (context) {
                    return BlocProvider.value(
                      value: notesBloc,
                      child: ActionConfirmationDialog(
                        onCancel: () {
                          Navigator.pop(context);
                        },
                        onConfirm: () {
                          notesBloc.add(DeleteNoteList(ids: selectedNotes));
                          isSelectionMode = false;
                          setState(() {});
                          Navigator.pop(context);
                        },
                        title: S.of(context).deleteMultiNotesMsg,
                        cancelText: S.of(context).cancel,
                        confirmText: S.of(context).confirm,
                      ),
                    );
                  });
            } else {
              _navigateToNoteEditingView(context, null);
            }
          },
        ),
      ),
    );
  }

  void _navigateToNoteEditingView(BuildContext context, NoteModel? note) {
    final noteBloc = context.read<NoteBloc>();
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => BlocProvider.value(
        value: noteBloc,
        child: NoteEditingView(note: note),
      ),
    ));
  }

  void _navigateToDisplayNoteView(BuildContext context, NoteModel note) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => DisplayNoteView(note: note),
    ));
  }
}

class ActionConfirmationDialog extends StatelessWidget {
  const ActionConfirmationDialog({
    super.key,
    required this.confirmText,
    required this.cancelText,
    required this.title,
    this.content,
    this.onCancel,
    this.onConfirm,
  });
  final String confirmText;
  final String cancelText;
  final String title;
  final String? content;
  final void Function()? onCancel;
  final void Function()? onConfirm;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      actions: [
        TextButton(
          onPressed: onCancel,
          child: Text(cancelText),
        ),
        TextButton(
          onPressed: onConfirm,
          child: Text(confirmText),
        )
      ],
    );
  }
}
