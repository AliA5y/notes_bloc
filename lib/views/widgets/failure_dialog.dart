import 'package:flutter/material.dart';
import 'package:notes_bloc/helpers/functions.dart';
import 'package:notes_bloc/helpers/request_states.dart';
import 'package:notes_bloc/shared.dart';
import 'package:notes_bloc/views/widgets/submit_button.dart';
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          errorMessage,
          textAlign: TextAlign.center,
          style:
              Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 19),
        ),
        SizedBox(height: 32),
        SubmittButton(
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
            text: failure is OldVersionFailure
                ? S.of(context).update
                : S.of(context).close),
      ],
    );
  }
}
