part of 'bloc.dart';

abstract class NotificationsEvents {}

class InitNotificationEvent extends NotificationsEvents {
  final bool forceReload;

  InitNotificationEvent({
    this.forceReload = false,
  });
}

class SetLastViewEvent extends NotificationsEvents {
  SetLastViewEvent();
}
