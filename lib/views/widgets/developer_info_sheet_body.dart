import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:notes_bloc/generated/l10n.dart';
import 'package:notes_bloc/helpers/functions.dart';
import 'package:notes_bloc/shared/app_theme.dart';

class DeveloperInfoSheetBody extends StatelessWidget {
  const DeveloperInfoSheetBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          S.of(context).developed,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 32),
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: AppTheme.getBackground(context),
              border: AppTheme.edgeBorder(),
              borderRadius: BorderRadius.circular(12)),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              S.of(context).myname,
              style: Theme.of(context).textTheme.titleLarge,
              maxLines: 1,
            ),
          ),
        ),
        const SizedBox(height: 32),
        Text(
          S.of(context).contactOn,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ContactMethodIcon(
              onPressed: () async {
                final Uri linkedInAppUri =
                    Uri.parse('linkedin://profile/ali-al-zaidy-00502630a');
                final Uri linkedInWebUri = Uri.parse(
                    'https://www.linkedin.com/in/ali-al-zaidy-00502630a');
                launchAUrl(
                  linkedInAppUri,
                  onError: () {
                    launchAUrl(linkedInWebUri);
                  },
                );
              },
              icon: LineIcons.linkedin,
            ),
            ContactMethodIcon(
              icon: LineIcons.whatSApp,
              onPressed: () async {
                String link = '+967774322947';

                final Uri url = Uri(scheme: 'https', host: 'wa.me', path: link);
                launchAUrl(url);
              },
            ),
            ContactMethodIcon(
              onPressed: () async {
                String link = 'AliA5y';

                final Uri url =
                    Uri(scheme: 'https', host: 'github.com', path: link);
                launchAUrl(url);
              },
              icon: LineIcons.github,
            ),
            ContactMethodIcon(
              onPressed: () async {
                final url = Uri(scheme: 'tel', path: '+967774322947');
                launchAUrl(url);
              },
              icon: LineIcons.phone,
            )
          ],
        ),
        // const Spacer(),
      ],
    );
  }
}

class ContactMethodIcon extends StatelessWidget {
  const ContactMethodIcon({
    super.key,
    required this.icon,
    this.onPressed,
    this.color = Colors.blueGrey,
  });
  final IconData icon;
  final void Function()? onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        size: 38,
        color: color,
      ),
    );
  }
}
