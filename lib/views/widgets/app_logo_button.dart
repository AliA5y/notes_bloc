import 'package:flutter/material.dart';
import 'package:notes_bloc/helpers/tools.dart';
import 'package:notes_bloc/views/widgets/developer_info_sheet_body.dart';

class AppLogoButton extends StatelessWidget {
  const AppLogoButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              // spreadRadius: 1,
              color: Theme.of(context).colorScheme.inverseSurface.withAlpha(20),
              offset: const Offset(-1, -1),
              blurRadius: 4,
            ),
            BoxShadow(
              color: Theme.of(context).colorScheme.inverseSurface.withAlpha(20),
              offset: const Offset(1, 1),
              blurRadius: 4,
            ),
          ],
        ),
        padding: const EdgeInsets.all(0),
        child: MaterialButton(
            onPressed: () {
              Tools.showCustomBottomSheet(
                context,
                body: const DeveloperInfoSheetBody(),
              );
            },
            padding: const EdgeInsets.all(0),
            color: Theme.of(context).colorScheme.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(7.0),
              child: Image.asset('assets/images/logo.png'),
            )),
      ),
    );
  }
}
