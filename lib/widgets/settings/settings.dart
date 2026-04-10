import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_music/bloc/player/bloc.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../bloc/authentication/bloc.dart';
import '../../utils/routes.dart';

class SettingsModal extends StatelessWidget {
  const SettingsModal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: ColoredBox(
        color: Colors.white,
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const CircleAvatar(
                    radius: 80,
                    backgroundImage: AssetImage(
                      "assets/images/avatar.png",
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  BlocBuilder<AuthenticationBloc, AuthenticationState>(
                      buildWhen: (previous, current) =>
                      previous.user != current.user,
                      builder: (context, state) {
                        return Column(
                          children: [
                            Text(
                              state.user.name,
                              style: const TextStyle(
                                  fontSize: 18, fontFamily: 'Vogue Bold'),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              state.user.username,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        );
                      }),
                  // const Padding(
                  //   padding: EdgeInsets.symmetric(vertical: 10),
                  //   child: Divider(),
                  // ),
                  // Material(
                  //   color: Colors.transparent,
                  //   child: InkWell(
                  //     splashColor: Colors.grey.withOpacity(0.1),
                  //     onTap: () => {},
                  //     child: const Row(
                  //       children: [
                  //         Icon(
                  //           Icons.account_circle,
                  //           color: Colors.grey,
                  //           size: 32,
                  //         ),
                  //         SizedBox(
                  //           width: 15,
                  //         ),
                  //         Text(
                  //           'Cuenta',
                  //           style: TextStyle(
                  //               fontSize: 16,
                  //               fontFamily: 'Vogue Bold'
                  //           ),
                  //         ),
                  //         Spacer(),
                  //         Icon(
                  //           Icons.arrow_forward_ios,
                  //           color: Colors.grey,
                  //           size: 20,
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(
                    height: 10,
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            backgroundColor: Colors.white,
                            surfaceTintColor: Colors.white,
                            title: const Text('Cerrar sesión'),
                            content: const Text(
                                'Estás a punto de cerrar sesión ¿Estás seguro?'),
                            actionsAlignment: MainAxisAlignment.spaceBetween,
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('No'),
                              ),
                              TextButton(
                                onPressed: () {
                                  context
                                      .read<AuthenticationBloc>()
                                      .add(LogOutEvent(afterSuccess: () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                    context
                                        .read<PlayerBloc>()
                                        .add(ResetPlayerEvent());
                                  }));
                                },
                                child: const Text('Si, cerrar sesión'),
                              ),
                            ],
                          ),
                        );
                      },
                      child: const Row(
                        children: [
                          Icon(
                            Icons.exit_to_app,
                            color: Colors.grey,
                            size: 32,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Cerrar sesión',
                            style: TextStyle(
                                fontSize: 16, fontFamily: 'Vogue Bold'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => Get.toNamed(
                        Routes.faq,
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.question_answer,
                            color: Colors.grey,
                            size: 32,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Preguntas frecuentes',
                            style: TextStyle(
                                fontSize: 16, fontFamily: 'Vogue Bold'),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey,
                            size: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () async {
                        // await launchUrl(
                        //   Uri(
                        //       scheme: 'https',
                        //       host: 'www.miximike.com',
                        //       path: 'terminos-y-condiciones/'),
                        //   mode: LaunchMode.externalApplication,
                        // );
                        Get.toNamed(
                          Routes.termsAndConditions,
                        );
                      },
                      child: const Row(
                        children: [
                          Icon(
                            Icons.list_alt,
                            color: Colors.grey,
                            size: 32,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Términos y condiciones',
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Vogue Bold'
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey,
                            size: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () async {
                        // await launchUrl(
                        //   Uri(
                        //       scheme: 'https',
                        //       host: 'www.miximike.com',
                        //       path: 'politicas-de-privacidad/'),
                        //   mode: LaunchMode.externalApplication,
                        // );
                        Get.toNamed(
                          Routes.privacy,
                        );
                      },
                      child: const Row(
                        children: [
                          Icon(
                            Icons.privacy_tip,
                            color: Colors.grey,
                            size: 32,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Políticas de privacidad',
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Vogue Bold'
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey,
                            size: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            backgroundColor: Colors.white,
                            surfaceTintColor: Colors.white,
                            title: const Text('Eliminar cuenta'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: const TextSpan(
                                      children: [
                                        TextSpan(
                                            text: 'Para ',
                                            style: TextStyle(color: Colors.black)
                                        ),
                                        TextSpan(
                                            text: ' eliminar ',
                                            style: TextStyle(color: Colors.black, fontFamily: 'Vogue Bold')
                                        ),
                                        TextSpan(
                                            text: 'tu cuenta',
                                            style: TextStyle(color: Colors.black)
                                        ),
                                        TextSpan(
                                            text: ' MIXIMIKE ',
                                            style: TextStyle(color: Colors.black, fontFamily: 'Vogue Bold')
                                        ),
                                        TextSpan(
                                            text: 'debes seguir los siguientes pasos:',
                                            style: TextStyle(color: Colors.black,)
                                        )
                                      ]
                                  ),
                                ),
                                const SizedBox(height: 20),
                                RichText(
                                  text: const TextSpan(
                                      children: [
                                        TextSpan(
                                            text: '1. ',
                                            style: TextStyle(color: Colors.black, fontFamily: 'Vogue Bold')
                                        ),
                                        TextSpan(
                                            text: 'Iniciar sesión en tu cuenta en nuestro sitio web',
                                            style: TextStyle(color: Colors.black)
                                        ),
                                        TextSpan(
                                            text: ' www.miximike.com',
                                            style: TextStyle(color: Colors.black, fontFamily: 'Vogue Bold')
                                        ),
                                      ]
                                  ),
                                ),
                                const SizedBox(height: 5),
                                RichText(
                                  text: const TextSpan(
                                      children: [
                                        TextSpan(
                                            text: '2. ',
                                            style: TextStyle(color: Colors.black, fontFamily: 'Vogue Bold')
                                        ),
                                        TextSpan(
                                            text: 'Hacer clic en tu',
                                            style: TextStyle(color: Colors.black)
                                        ),
                                        TextSpan(
                                            text: ' nombre ',
                                            style: TextStyle(color: Colors.black, fontFamily: 'Vogue Bold')
                                        ),
                                        TextSpan(
                                            text: 'e ir a la sección',
                                            style: TextStyle(color: Colors.black)
                                        ),
                                        TextSpan(
                                            text: ' Mis Datos.',
                                            style: TextStyle(color: Colors.black, fontFamily: 'Vogue Bold')
                                        ),
                                      ]
                                  ),
                                ),
                                const SizedBox(height: 5),
                                RichText(
                                  text: const TextSpan(
                                      children: [
                                        TextSpan(
                                            text: '3. ',
                                            style: TextStyle(color: Colors.black, fontFamily: 'Vogue Bold')
                                        ),
                                        TextSpan(
                                            text: 'Dirigirse a la sección',
                                            style: TextStyle(color: Colors.black)
                                        ),
                                        TextSpan(
                                            text: ' Eliminar Cuenta',
                                            style: TextStyle(color: Colors.black, fontFamily: 'Vogue Bold')
                                        ),
                                        TextSpan(
                                            text: ', ubicada en la parte Inferior de tus Datos Personales.',
                                            style: TextStyle(color: Colors.black)
                                        ),
                                      ]
                                  ),
                                ),
                                const SizedBox(height: 5),
                                RichText(
                                  text: const TextSpan(
                                      children: [
                                        TextSpan(
                                            text: '4. ',
                                            style: TextStyle(color: Colors.black, fontFamily: 'Vogue Bold')
                                        ),
                                        TextSpan(
                                            text: 'Ingresar tu contraseña actual y confirmar la eliminación de tu cuenta.',
                                            style: TextStyle(color: Colors.black)
                                        ),
                                      ]
                                  ),
                                ),
                                const SizedBox(height: 20),
                                RichText(
                                  text: const TextSpan(
                                      children: [
                                        TextSpan(
                                            text: 'Para proceder con la eliminación de tu cuenta, haz clic en',
                                            style: TextStyle(color: Colors.black)
                                        ),
                                        TextSpan(
                                            text: ' Ir a mi cuenta.',
                                            style: TextStyle(color: Colors.black, fontFamily: 'Vogue Bold')
                                        ),
                                      ]
                                  ),
                                ),
                              ],
                            ),
                            actionsAlignment: MainAxisAlignment.spaceBetween,
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Volver'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  Navigator.of(context).pop();

                                  await launchUrl(
                                    Uri(
                                        scheme: 'https',
                                        host: 'www.miximike.com',
                                        path: 'mi-cuenta/'
                                    ),
                                    mode: LaunchMode.externalApplication,
                                  );
                                },
                                child: const Text('Ir a mi cuenta'),
                              ),
                            ],
                          ),
                        );
                      },
                      child: const Row(
                        children: [
                          Icon(
                            Icons.delete_forever,
                            color: Colors.red,
                            size: 32,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Eliminar cuenta',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Vogue Bold',
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
