part of 'bloc.dart';

class NotificationState extends Equatable {
  final int countState;
  final bool isLoading;
  final List<Notification> notifications;
  List<Notification> get newNotifications => notifications.where((notification) => !notification.view).toList();

  const NotificationState({
    this.countState = 0,
    this.isLoading = false,
    this.notifications = const [],
  });

  @override
  List<Object?> get props => [
    countState,
    isLoading,
    notifications.length,
    newNotifications.length,
  ];

  NotificationState copyWith({
    bool forceReload = false,
    bool? isLoading,
    List<Notification>? notifications,
  }) {
    return NotificationState(
      countState: forceReload ? countState + 1 : countState,
      isLoading: isLoading ?? this.isLoading,
      notifications: notifications ?? this.notifications,
    );
  }
}
