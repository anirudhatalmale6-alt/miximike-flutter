import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_music/bloc/notification/bloc.dart';
import 'package:flutter_music/utils/theme.dart';
import 'package:flutter_music/widgets/notifications/notification_skeleton.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../utils/routes.dart';

class NotificationsModal extends StatelessWidget {
  const NotificationsModal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: ColoredBox(
        color: Colors.white,
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Notificaciones',
                        style:
                        TextStyle(fontSize: 18, fontFamily: 'Vogue Bold'),
                      ),
                      BlocBuilder<NotificationBloc, NotificationState>(
                          buildWhen: (previous, current) =>
                          (previous.isLoading != current.isLoading),
                          builder: (context, state) {
                            return Semantics(
                              label: 'Refrescar notificaciones',
                              button: true,
                              excludeSemantics: true,
                              child: ElevatedButton(
                                // color: AppTheme.lightSecondaryColor,
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.all(0),
                                    minimumSize: const Size(30, 30),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    side: const BorderSide(
                                        color: Colors.transparent, width: 0),
                                  ),
                                  onPressed: !state.isLoading
                                      ? () {
                                    context.read<NotificationBloc>().add(
                                        InitNotificationEvent(
                                            forceReload: true));
                                  }
                                      : null,
                                  child: const Icon(
                                    Icons.refresh,
                                    size: 20,
                                  )),
                            );
                          })
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Divider(),
                  ),
                  BlocBuilder<NotificationBloc, NotificationState>(
                    builder: (context, state) {
                      return state.notifications.isNotEmpty ? LiveGrid(
                          key: ValueKey(
                              "notifications-${state.isLoading}-${state.notifications.length}"),
                          shrinkWrap: true,
                          controller: scrollController,
                          showItemInterval: const Duration(
                            milliseconds: 200,
                          ),
                          showItemDuration: const Duration(milliseconds: 250),
                          // visibleFraction: 0.001,
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            mainAxisExtent: 90,
                            // childAspectRatio: 2.0,
                          ),
                          itemCount:
                          state.isLoading ? 3 : state.notifications.length,
                          itemBuilder: (context, index, animation) =>
                              FadeTransition(
                                opacity: Tween<double>(
                                  begin: 0,
                                  end: 1,
                                ).animate(animation),
                                child: SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(0, -0.1),
                                    end: Offset.zero,
                                  ).animate(animation),
                                  child: state.isLoading
                                      ? const NotificationSkeleton()
                                      : Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          splashColor:
                                          Colors.grey.withOpacity(0.1),
                                          onTap: () => Get.toNamed(
                                            Routes.notificationDetails,
                                            arguments: {
                                              'notification':
                                              state.notifications[index]
                                            },
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(
                                                state.notifications[index]
                                                    .view
                                                    ? Icons.notifications
                                                    : Icons
                                                    .notifications_active,
                                                color: state
                                                    .notifications[index]
                                                    .view
                                                    ? Colors.grey
                                                    : AppTheme
                                                    .lightSecondaryColor,
                                                size: 48,
                                              ),
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              Flexible(
                                                fit: FlexFit.tight,
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Text(
                                                      state
                                                          .notifications[
                                                      index]
                                                          .cleanTitle,
                                                      overflow: TextOverflow
                                                          .ellipsis,
                                                      maxLines: 1,
                                                      softWrap: false,
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          fontFamily:
                                                          'Vogue Bold'),
                                                    ),
                                                    Text(
                                                      state
                                                          .notifications[
                                                      index]
                                                          .cleanContent,
                                                      overflow: TextOverflow
                                                          .ellipsis,
                                                      maxLines: 1,
                                                      softWrap: false,
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          fontFamily:
                                                          'Vogue'),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Builder(builder:
                                                            (context) {
                                                          String date = DateFormat()
                                                              .format(state
                                                              .notifications[
                                                          index]
                                                              .createdAt)
                                                              .toString();
                                                          return Text(
                                                            date.substring(
                                                                0,
                                                                date.length -
                                                                    3),
                                                            style: const TextStyle(
                                                                fontSize: 14,
                                                                fontFamily:
                                                                'Vogue'),
                                                          );
                                                        }),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const Icon(
                                                Icons.arrow_forward_ios,
                                                color: Colors.grey,
                                                size: 20,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                ),
                              )) : Center(
                        child: const Text(
                          'No hay notificaciones recibidas',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Vogue',
                          ),
                        ).marginOnly(bottom: 10),
                      );
                    },
                  )
                ],
              ),
            )),
      ),
    );
  }
}
