import '../generated/l10n.dart';

abstract class RequestState {}

abstract class RequestSuccess implements RequestState {}

abstract class RequesFailure implements RequestState {
  String getFailureMessage();
}

class Success implements RequestSuccess {}

class SufficientRequestsFetchingSuccess implements RequestSuccess {
  final int remaining;

  SufficientRequestsFetchingSuccess({required this.remaining});
}

class OldVersionFailure implements RequesFailure {
  @override
  String getFailureMessage() {
    return S.current.versionerro;
  }
}

class InternetUnavailableFailure implements RequesFailure {
  @override
  String getFailureMessage() {
    return S.current.neterror;
  }
}

class UnknownRequestError implements RequesFailure {
  final String message;

  UnknownRequestError({required this.message});
  @override
  String getFailureMessage() {
    return message;
  }
}

class IdRequestFailure implements RequesFailure {
  final String message;

  IdRequestFailure({required this.message});
  @override
  String getFailureMessage() {
    return message;
  }
}
