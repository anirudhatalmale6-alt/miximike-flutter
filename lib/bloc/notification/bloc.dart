import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_music/api/models/notification.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/client.dart';
import '../../utils/local_storage.dart';

part 'events.dart';
part 'state.dart';

class NotificationBloc extends Bloc<NotificationsEvents, NotificationState> {
  NotificationBloc({
    NotificationState initialState = const NotificationState(),
  }) : super(initialState) {
    on<InitNotificationEvent>(_initProduct);
    on<SetLastViewEvent>(_setLastViewEvent);
  }

  Future<void> _initProduct(InitNotificationEvent event, Emitter<NotificationState> emit) async {
    emit(state.copyWith(isLoading: true));
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    List<Notification> notifications = await getNotifications(forceReload: event.forceReload);

    String lastDateTimeNotificationView = localStorage.getString(LocalStorage.lastDateTimeNotificationViewed)
        ?? DateTime.now().subtract(Duration(
            days: int.parse(dotenv.env['DEFAULT_DAYS_TO_NOTIFY'] as String)
        )).toString();

    DateTime lastDateTimeNotification = DateTime.parse(lastDateTimeNotificationView);

    notifications
        .where((notification) => notification.createdAt.isAfter(lastDateTimeNotification))
        .toList()
        .forEach((element) => element.setView(false));

    emit(
        state.copyWith(
          isLoading: false,
          notifications: notifications,
        )
    );
  }

  Future<void> _setLastViewEvent(SetLastViewEvent event, Emitter<NotificationState> emit) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    DateTime now = DateTime.now();

    localStorage.setString(LocalStorage.lastDateTimeNotificationViewed, now.toString());
    for (var element in state.notifications) {
      element.setView(true);
    }

    emit(
        state.copyWith(
          forceReload: true,
        )
    );
  }

  Future<List<Notification>> getNotifications({required bool forceReload}) async =>
      await NotificationClient.getNotifications(forceReload: forceReload)
          .then((response) => response.data.map<Notification>((json) => Notification.fromJson(json)).toList())
          .onError<DioException>((error, stackTrace) => [] as List<Notification>);
}
