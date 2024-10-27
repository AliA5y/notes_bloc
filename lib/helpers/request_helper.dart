import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:notes_bloc/shared.dart';
import 'package:ntp/ntp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'request_states.dart';

class RequestHelper {
  static late String _id;

  static Future<RequestState> checkAppVersionState() async {
    final FirebaseFirestore fireIns = FirebaseFirestore.instance;
    try {
      final docRef = fireIns.collection('settings').doc('configs');
      final doc = await docRef.get();
      final data = doc.data() as Map<String, dynamic>;
      if (Versions.currentAppVer >= (data['minAllowedVersion'] as int)) {
        return Success();
      } else {
        return OldVersionFailure();
      }
    } on TimeoutException {
      return InternetUnavailableFailure();
    } catch (e) {
      return UnknownRequestError(message: e.toString());
    }
  }

  static Future<RequestState> handelDeviceId() async {
    final CollectionReference colRef =
        FirebaseFirestore.instance.collection('userData');
    DateTime date;
    try {
      date = await NTP.now(timeout: const Duration(milliseconds: 1000));
    } catch (_) {
      date = DateTime.now();
      date = await NTP.now(timeout: const Duration(milliseconds: 1000));
    }
    String? displayId, androidId, securityPatch, incremental;
    final prefs = await SharedPreferences.getInstance();
    String? deviceId = prefs.getString(PrefsKeys.idKey);
    if (deviceId == null) {
      try {
        final deviceInfo = (await DeviceInfoPlugin().androidInfo);
        displayId = deviceInfo.display;
        androidId = deviceInfo.id;
        incremental = deviceInfo.version.incremental;
        securityPatch = deviceInfo.version.securityPatch ?? 'no-sec-pat';
        _id = displayId;
        if (!(_id.contains(incremental))) {
          _id += '.$incremental';
        }
        if (!(_id.contains(androidId))) {
          _id += ':$androidId';
        }
        _id += ':$securityPatch';
      } catch (e) {
        _id = const Uuid().v1();
        securityPatch = 'error getting id info: ${e.toString()}';
        // displayId ??= 'error getting id info: ${e.toString()}';
        incremental ??= 'error getting id info: ${e.toString()}';
        androidId ??= 'error getting id info: ${e.toString()}';
      }
      try {
        await colRef.doc(_id).set({
          'id': _id,
          'androidId': androidId,
          'incremental': incremental,
          'securityPatch': securityPatch,
          'date': date,
        }, SetOptions(merge: true));
        prefs.setString(PrefsKeys.idKey, _id);
      } on TimeoutException catch (_) {
        return InternetUnavailableFailure();
      }
      return Success();
    } else {
      _id = deviceId;
      try {
        (await colRef.doc(_id).get())['id'];
      } on TimeoutException catch (_) {
        return InternetUnavailableFailure();
      } on StateError catch (_) {
        try {
          final deviceInfo = (await DeviceInfoPlugin().androidInfo);
          displayId = deviceInfo.display;
          androidId = deviceInfo.id;
          securityPatch = deviceInfo.version.securityPatch ?? 'no-sec-pat';
          incremental = deviceInfo.version.incremental;
          await colRef.doc(_id).set({
            'id': _id,
            'androidId': androidId,
            'incremental': incremental,
            'securityPatch': securityPatch,
            'date': date
          }, SetOptions(merge: true));
        } on TimeoutException catch (_) {
          return InternetUnavailableFailure();
        } catch (e) {
          throw 'error getting id info: ${e.toString()}';
        }
      }
      return Success();
    }
  }
}
