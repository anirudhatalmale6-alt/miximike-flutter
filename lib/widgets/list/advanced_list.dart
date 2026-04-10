import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_music/bloc/notification/bloc.dart';
import 'package:flutter_music/widgets/settings/notification/notifications.dart';

import '../../../utils/theme.dart';
import '../settings/settings.dart';

class AdvancedList extends StatelessWidget {
  final Widget title;
  final Widget searchField;
  final List<Widget> slivers;
  final EdgeInsetsGeometry? sliversPadding;

  const AdvancedList({
    super.key,
    required this.title,
    required this.searchField,
    required this.slivers,
    this.sliversPadding = const EdgeInsets.symmetric(horizontal: 10),
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverLayoutBuilder(
          builder: (BuildContext context, constraints) => SliverAppBar(
            pinned: true,
            backgroundColor: constraints.scrollOffset == 0 ? Colors.white : AppTheme.lightPrimaryColor,
            title: AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              opacity: constraints.scrollOffset < 20 ? 1 : 0,
              child: title,
            ),
            actions: [
              AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: constraints.scrollOffset < 20 ? 1 : 0,
                child: IconButton(
                  onPressed: () => showModalBottomSheet<void>(
                      context: context,
                      isScrollControlled: true,
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.85,
                      ),
                      builder: (BuildContext context) => const NotificationsModal()
                  ).whenComplete(() {
                    if (!context.mounted) return;

                    context.read<NotificationBloc>().add(SetLastViewEvent());
                  }),
                  icon: BlocBuilder<NotificationBloc, NotificationState>(
                      buildWhen: (previous, current) {
                        return previous.countState != current.countState || previous.newNotifications.length != current.newNotifications.length;
                      },
                      builder: (context, state) {
                        bool haveNewNotifications = state.newNotifications.isNotEmpty && !state.isLoading;

                        return Semantics(
                          label: 'Lista de notificaciones',
                          button: true,
                          excludeSemantics: true,
                          child: Badge(
                            label: haveNewNotifications ? Text(
                              state.newNotifications.length.toString(),
                              style: const TextStyle(
                                fontFamily: 'Vogue Bold',
                                fontSize: 12,
                              ),
                            ) : null,
                            backgroundColor: haveNewNotifications ? AppTheme.lightSecondaryColor : Colors.transparent,
                            child: const Icon(
                              Icons.notifications,
                              size: 30,
                            ),
                          ),
                        );
                      }
                  ),
                ),
              ),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: constraints.scrollOffset < 20 ? 1 : 0,
                child: Semantics(
                  label: 'Configuraciones',
                  button: true,
                  excludeSemantics: true,
                  child: IconButton(
                    onPressed: () => showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) => ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight: MediaQuery.of(context).size.height * 0.85,
                            ),
                            child: const SettingsModal()
                        )
                    ),
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              )
            ],
            expandedHeight: 120,
            collapsedHeight: 80,
            flexibleSpace: FlexibleSpaceBar(
              expandedTitleScale: 1,
              titlePadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 15,
              ),
              title: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(32),
                child: searchField,
              ),
              background: Column(
                children: [
                  Container(
                    color: AppTheme.lightPrimaryColor,
                    height: 80,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

          ),
        ),
        SliverPadding(
            padding: sliversPadding ?? const EdgeInsets.symmetric(horizontal: 10),
            sliver: SliverMainAxisGroup(
              slivers: slivers,
            )
        )
      ],
    );
  }
}
