import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_music/bloc/notification/bloc.dart';
import 'package:flutter_music/bloc/player/bloc.dart';
import 'package:flutter_music/bloc/product/bloc.dart';
import 'package:flutter_music/pages/main.dart';
import 'package:flutter_music/widgets/utils/widget_switcher.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:get/get.dart' as get_material_app;
import 'package:get/route_manager.dart';
import 'package:just_audio/just_audio.dart' as just_audio;
import 'package:move_to_background/move_to_background.dart';

import '../../utils/routes.dart';
import '../../utils/theme.dart';
import 'api/models/user.dart';
import 'bloc/authentication/bloc.dart';
import 'bloc/master/bloc.dart';
import 'generated/l10n.dart';
import 'pages/home.dart';
import 'widgets/splash/splash.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(
    widgetsBinding: widgetsBinding,
  );

  runApp(
      DevicePreview(
        // enabled: !kReleaseMode,
        enabled: false,
        builder: (context) => MultiBlocProvider(
          providers: [
            BlocProvider<MasterBloc>(
              create: (BuildContext context) => MasterBloc(),
            ),
            BlocProvider<NotificationBloc>(
              create: (BuildContext context) => NotificationBloc(),
            ),
            BlocProvider<AuthenticationBloc>(
              create: (BuildContext context) => AuthenticationBloc(
                initialState: AuthenticationState(
                    user: User(id: 0, username: '', name: '')
                ),
              ),
            ),
            BlocProvider<ProductBloc>(
              create: (BuildContext context) => ProductBloc(),
            ),
            BlocProvider<PlayerBloc>(
              create: (BuildContext context) {
                just_audio.AudioPlayer player = just_audio.AudioPlayer();

                return PlayerBloc(
                    initialState: PlayerState(
                      player: player,
                      positionStream: player.createPositionStream(
                          steps: 1000
                      ),
                      playList: just_audio.ConcatenatingAudioSource(
                          children: []
                      ),
                    )
                );
              },
            ),
          ],
          child: const MyApp(),
        ),
      )
  );

  FlutterNativeSplash.remove();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AppLifecycleListener _appLifecycleListener;

  @override
  void initState() {
    super.initState();
    context.read<MasterBloc>().add(
        InitAppEvent(
            afterSuccess: (user) {
              context.read<AuthenticationBloc>().add(
                  SetUserEvent(user: user)
              );
            }
        )
    );
    _appLifecycleListener = AppLifecycleListener(
      onDetach: () {
        context.read<PlayerBloc>().add(ResetPlayerEvent());
      },
    );
  }

  @override
  void dispose() {
    _appLifecycleListener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return get_material_app.GetMaterialApp(
      useInheritedMediaQuery: true,
      supportedLocales: S.delegate.supportedLocales,
      // locale: const Locale('es', 'CL'),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        FormBuilderLocalizations.delegate,
      ],
      title: 'MixiMike',
      theme: AppTheme.getTheme(),
      debugShowCheckedModeBanner: false,
      defaultTransition: get_material_app.Transition.rightToLeftWithFade,
      transitionDuration: get_material_app.Get.defaultTransitionDuration,
      getPages: Routes.getPages(),
      home: BlocBuilder<ProductBloc, ProductState>(
          buildWhen: (previous, current) => (
              previous.singleArtist != current.singleArtist ||
                  previous.singleProducts != current.singleProducts ||
                  previous.isLoading != current.isLoading
          ),
          builder: (context, state) {
            return PopScope(
              canPop: false,
              onPopInvokedWithResult : (didPop, result) {
                // SI ESTOY DENTRO DE UN ALBUM, NO CIERRO
                if (state.singleProducts.isNotEmpty) {
                  return;
                }

                // SI ESTOY DENTRO DE UN ARTISTA Y NO ES EL ÚNICO, NO CIERRO YA QUE HAY MENÚ PRINCIPAL
                if (state.singleArtist != null && state.artists.length > 1 ) {
                  return;
                }

                if (didPop) {
                  return;
                }
                MoveToBackground.moveTaskToBack();
              },
              child: BlocBuilder<MasterBloc, MasterState>(
                  buildWhen: (previous, current) => previous.isLoading != current.isLoading,
                  builder: (context, state) =>  AnimatedSwitcher(
                      duration: const Duration(milliseconds: 700),
                      child: state.isLoading ? const Splash() : const MyHomePage(),
                      transitionBuilder: (Widget child, Animation<double> animation) {
                        if (state.isLoading) {
                          return FadeTransition(
                              opacity: animation,
                              child: child
                          );
                        }

                        return ScaleTransition(
                            scale: animation,
                            child: child
                        );
                      }
                  )
              ),
            );
          }
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listenWhen: (previous, current) => previous.isLogged != current.isLogged,
        buildWhen: (previous, current) => previous.isLogged != current.isLogged,
        listener: (context, state) {
          context.read<PlayerBloc>().add(ResetPlayerEvent());
        },
        builder: (context, state) {
          return Container(
            color: state.isLogged ? Theme.of(context).primaryColor : AppTheme.lightSecondaryColor,
            child: SafeArea(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: WidgetSwitcher(
                  condition: !state.isLogged,
                  conditionWidget: const Main(),
                  child: const HomePage(),
                ),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  if (state.isLogged) {
                    return FadeTransition(
                        opacity: animation,
                        child: child
                    );
                  }

                  return ScaleTransition(
                      scale: animation,
                      child: child
                  );
                },
              ),
            ),
          );
        }
    );
  }
}
