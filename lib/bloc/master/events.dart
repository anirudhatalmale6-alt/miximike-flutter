part of 'bloc.dart';

abstract class MasterEvents {}

class InitAppEvent extends MasterEvents {
  final void Function(User user)? afterSuccess;

  InitAppEvent({
    this.afterSuccess,
  });
}

