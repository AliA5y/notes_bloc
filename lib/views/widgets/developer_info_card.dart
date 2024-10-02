import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class DeveloperInfoCard extends StatelessWidget {
  const DeveloperInfoCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: const EdgeInsets.all(0),
      content: Builder(
        builder: (context) {
          return Container(
            height: 260,
            margin: const EdgeInsets.only(bottom: 2),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                color: Theme.of(context).colorScheme.surface),
            padding:
                const EdgeInsets.only(left: 16, right: 16, bottom: 6, top: 10),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Icon(
                        Icons.laptop_chromebook_rounded,
                        // LineIcons.laptop,
                        size: 40,
                      ),
                      const SizedBox(width: 12),
                      Text('Developed By',
                          style: Theme.of(context).textTheme.headlineSmall),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Ali Abdulrahman',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () async {
                          final Uri emailUri = Uri(
                            scheme: 'mailto',
                            path: 'ali.route999@gmail.com',
                          );
                          if (await canLaunchUrl(emailUri)) {
                            await launchUrl(emailUri);
                          } else {
                            throw 'Could not launch $emailUri';
                          }
                        },
                        icon: const Icon(
                          LineIcons.mailBulk,
                          size: 34,
                          color: Colors.blueGrey,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          String link = '967779085571';

                          final Uri url =
                              Uri(scheme: 'https', host: 'wa.me', path: link);
                          launchUrl(url);

                          if (await canLaunchUrl(url)) {
                            //await launchUrl(url, mode: LaunchMode.externalApplication);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        icon: const Icon(
                          LineIcons.whatSApp,
                          size: 34,
                          color: Colors.blueGrey,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          String link = 'AliA5y';

                          final Uri url = Uri(
                              scheme: 'https', host: 'github.com', path: link);
                          try {
                            await launchUrl(url);
                          } catch (_) {}
                        },
                        icon: const Icon(
                          LineIcons.github,
                          size: 34,
                          color: Colors.blueGrey,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          final url = Uri(scheme: 'tel', path: '779085571');
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        icon: const Icon(
                          LineIcons.phone,
                          size: 34,
                          color: Colors.blueGrey,
                        ),
                      )
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 12, top: 12, right: 12, bottom: 12),
                              child: Text(
                                'Great',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            )),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}