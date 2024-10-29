import 'package:flutter/material.dart';
import 'package:notes_bloc/helpers/functions.dart';
import 'package:notes_bloc/helpers/request_states.dart';
import 'package:notes_bloc/shared.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../generated/l10n.dart';

class FailureDialog extends StatelessWidget {
  const FailureDialog(
      {super.key, required this.errorMessage, required this.failure});
  final String errorMessage;
  final RequestState failure;

  Future<String> _getUpdateLink() async {
    return (await SharedPreferences.getInstance())
            .getString(PrefsKeys.updateLink) ??
        'https://alia5y.github.io/notes_bloc/apk/Notes%20Bloc.apk';
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Center(
      child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.all(Radius.circular(16))),
          width: width * 0.85,
          height: height > 400 ? 400 : height,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.error_rounded,
                    size: 64,
                    color: Colors.red,
                  ),
                  Text(
                    errorMessage,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontSize: 19),
                  ),
                  TextButton(
                      onPressed: () async {
                        if (failure is OldVersionFailure) {
                          String link = await _getUpdateLink();
                          final Uri url = Uri.parse(link);
                          launchAUrl(url);
                          Navigator.pop(context);
                        } else {
                          Navigator.pop(context);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 12, top: 12, right: 12, bottom: 12),
                        child: Text(
                          failure is OldVersionFailure
                              ? S.of(context).update
                              : S.of(context).close,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontSize: 18),
                        ),
                      )),
                ],
              ),
            ),
          )),
    );
  }
}
