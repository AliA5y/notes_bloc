import 'dart:async';
import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

Future<bool> isInternetAvailable() async {
  try {
    final result = await InternetAddress.lookup('google.com')
        .timeout(const Duration(milliseconds: 2500));
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  } on SocketException catch (_) {
    return false;
  } on TimeoutException {
    return false;
  }
}

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
