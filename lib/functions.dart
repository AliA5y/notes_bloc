import 'package:url_launcher/url_launcher.dart';

void launchAUrl(Uri url) async {
  try {
    if (await launchUrl(url)) {
    } else {
      throw 'did not launch $url';
    }
  } catch (e) {
    throw 'Could not launch $url, ${e.toString()}';
  }
}
