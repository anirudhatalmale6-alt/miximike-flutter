import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music/api/models/product.dart' as model_product;
import 'package:flutter_music/api/models/track.dart' as model_track;
import 'package:flutter_music/utils/color_from_hex.dart';
import 'package:flutter_music/utils/routes.dart';
import 'package:flutter_music/utils/theme.dart';
import 'package:flutter_music/widgets/flip_card.dart';
import 'package:flutter_music/widgets/sign_in.dart';
import 'package:flutter_music/widgets/tracks/track.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  final scrollController = ScrollController();
  final GlobalKey globalKey = GlobalKey();

  List<model_track.Track> tracks = [
    model_track.Track(
      id: '1',
      name: 'DEMO CANCIONES PERSONALIZADAS',
      url: 'assets/demo/MIS-PRIMERAS-6-CANCIONES.mp3',
      product: model_product.Product(
        id: 1,
        categories: [],
        type: model_product.ProductType.disk,
        isAll: false,
        tracks: [],
        name: 'Demo',
        imageUrl: 'https://via.placeholder.com/150',
      ),
    ),
    model_track.Track(
      id: '2',
      name: 'DEMO CUENTOS PERSONALIZADOS',
      url: 'assets/demo/3-CUENTOS-BONITOS.mp3',
      product: model_product.Product(
        id: 1,
        categories: [],
        type: model_product.ProductType.disk,
        isAll: false,
        tracks: [],
        name: 'Demo',
        imageUrl: 'https://via.placeholder.com/150',
      ),
    ),
    model_track.Track(
      id: '3',
      name: 'DEMO CANCIONES PARA TODOS',
      url: 'assets/demo/CANTEMOS-TODOS-VOL-1.mp3',
      product: model_product.Product(
        id: 1,
        categories: [],
        type: model_product.ProductType.disk,
        isAll: false,
        tracks: [],
        name: 'Demo',
        imageUrl: 'https://via.placeholder.com/150',
      ),
    )
  ];

  FlipCardPosition whatIsMixiMike = FlipCardPosition.front;
  double flipCardHeight = 0;
  bool disableChangeFlipCard = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          isDismissible: false,
          builder: (BuildContext context) => const FractionallySizedBox(
            heightFactor: 0.85,
            child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: SignIn()
            ),
          ),
        ),
        backgroundColor: AppTheme.lightSecondaryColor,
        icon: const Icon(
          Icons.login,
          color: Colors.white,
        ),
        label: const Text(
          "INICIAR SESIÓN",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppTheme.lightSecondaryColor,
                    AppTheme.lightFourColor,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0, 1],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        width: context.width * (context.isPhone ? 0.75 : 0.5),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(''
                      'DISFRUTA CON MIXIMIKE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(''
                      'Simpáticas canciones y entretenidos '
                      'cuentos con el nombre de tu hij@',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  // const Text(''
                  //     'Regálale una experiencia ÚNICA',
                  //   style: TextStyle(
                  //     color: AppTheme.lightThreeColor,
                  //     fontSize: 24,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  const Text('¡Con MIXIMIKE tu HIJ@ es PROTAGONISTA '
                      'en canciones y cuentos personalizados!',
                    style: TextStyle(
                      color: AppTheme.lightThreeColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // const Text('¡Con MIXIMIKE tu HIJ@ es PROTAGONISTA '
                  //     'en canciones y cuentos personalizados!',
                  //   style: TextStyle(
                  //     color: AppTheme.lightThreeColor,
                  //     fontSize: 22,
                  //   ),
                  // ),
                ],
              ).paddingSymmetric(
                  horizontal: 20,
                  vertical: 20
              ),
            ),
            Container(
              color: AppTheme.lightPrimaryColor,
              child: Column(
                children: [
                  InkWell(
                    onTap: disableChangeFlipCard ? null : () async {
                      setState(() {
                        flipCardHeight = globalKey.currentContext?.findRenderObject()?.paintBounds.height ?? 0;
                        whatIsMixiMike = whatIsMixiMike == FlipCardPosition.front
                            ? FlipCardPosition.back
                            : FlipCardPosition.front;
                        disableChangeFlipCard = true;
                      });

                      await Future.delayed(const Duration(seconds: 1));

                      setState(() {
                        disableChangeFlipCard = false;
                      });
                    },
                    child: FlipCard(
                      frontCard: Container(
                        key: globalKey,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const FaIcon(
                              FontAwesomeIcons.volumeHigh,
                              size: 48,
                              color: AppTheme.lightThreeColor,
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              '¿QUÉ ES MIXIMIKE?',
                              style: TextStyle(
                                fontSize: 32,
                                color: AppTheme.lightThreeColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/logo.png',
                                  width: context.width * (context.isPhone ? 0.75 : 0.5),
                                ),
                              ],
                            ),
                          ],
                        ).paddingSymmetric(
                            vertical: 50
                        ),
                      ),
                      backCard: Container(
                        height: flipCardHeight,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          textDirection: TextDirection.ltr,
                          children: [
                            const Text(
                              '¿QUÉ ES MIXIMIKE?',
                              style: TextStyle(
                                fontSize: 24,
                                color: AppTheme.lightThreeColor,
                              ),
                            ),
                            const Divider(
                              color: AppTheme.lightThreeColor,
                              thickness: 2,
                              indent: 20,
                              endIndent: 20,
                            ),
                            RichText(
                              text: const TextSpan(
                                  children: [
                                    TextSpan(
                                        text: '• ',
                                        style: TextStyle(color: Colors.black)
                                    ),
                                    TextSpan(
                                        text: 'Es una',
                                        style: TextStyle(color: Colors.black)
                                    ),
                                    TextSpan(
                                        text: ' APLICACIÓN (APP) ',
                                        style: TextStyle(color: Colors.black, fontFamily: 'Vogue Bold')
                                    ),
                                    TextSpan(
                                        text: 'que reproduce canciones y cuentos infantiles personalizados con el nombre de tu',
                                        style: TextStyle(color: Colors.black)
                                    ),
                                    TextSpan(
                                        text: ' HIJ@.',
                                        style: TextStyle(color: Colors.black, fontFamily: 'Vogue Bold')
                                    ),
                                  ]
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            RichText(
                              text: const TextSpan(
                                  children: [
                                    TextSpan(
                                        text: '• ',
                                        style: TextStyle(color: Colors.black)
                                    ),
                                    TextSpan(
                                        text: 'Funciona en sistemas',
                                        style: TextStyle(color: Colors.black)
                                    ),
                                    TextSpan(
                                        text: ' Android e IOS ',
                                        style: TextStyle(color: Colors.black, fontFamily: 'Vogue Bold')
                                    ),
                                    TextSpan(
                                        text: ', y se descarga desde Google Play o Apple Store, respectivamente.',
                                        style: TextStyle(color: Colors.black)
                                    ),
                                  ]
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            RichText(
                              text: const TextSpan(
                                  children: [
                                    TextSpan(
                                        text: '• ',
                                        style: TextStyle(color: Colors.black)
                                    ),
                                    TextSpan(
                                        text: 'Ofrece una entretenida colección de Canciones y Cuentos infantiles personalizados para niños y niñas, '
                                            'además de Canciones para Todos (no personalizadas).',
                                        style: TextStyle(color: Colors.black)
                                    ),
                                  ]
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            RichText(
                              text: const TextSpan(
                                  children: [
                                    TextSpan(
                                        text: '• ',
                                        style: TextStyle(color: Colors.black)
                                    ),
                                    TextSpan(
                                        text: 'Las compras se hacen en nuestro sitio web www.miximike.com y la reproducción del contenido se efectúa en la',
                                        style: TextStyle(color: Colors.black)
                                    ),
                                    TextSpan(
                                        text: ' APP MIXIMIKE.',
                                        style: TextStyle(color: Colors.black, fontFamily: 'Vogue Bold')
                                    ),
                                  ]
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            RichText(
                              text: const TextSpan(
                                  children: [
                                    TextSpan(
                                        text: '• ',
                                        style: TextStyle(color: Colors.black)
                                    ),
                                    TextSpan(
                                        text: 'No olvides visitar nuestro sitio web constantemente para revisar los nuevos contenidos que iremos agregando en el tiempo.',
                                        style: TextStyle(color: Colors.black)
                                    ),
                                  ]
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ).paddingAll(20),
                      ),
                      currentPosition: whatIsMixiMike,
                    ),
                  ).paddingSymmetric(horizontal: 10)
                ],
              ).paddingSymmetric(
                  horizontal: 20,
                  vertical: 20
              ),
            ),
            Container(
              child: Column(
                children: [
                  const Text(
                    'PRUEBA NUESTRAS CANCIONES Y CUENTOS PERSONALIZADOS',
                    style: TextStyle(
                      fontSize: 22,
                      color: AppTheme.lightThreeColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ...tracks.map((track) => Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: FadeIn(
                      child: Track(
                          id: track.id,
                          imageUrl: track.imageUrl,
                          title: track.name,
                          // subTitle: "3:21 minutos",
                          subTitle: track.product.name,
                          isLocal: true,
                          onTap: () => Get.toNamed(
                              Routes.trackDetails,
                              arguments: {
                                'tracks': tracks,
                                'index': tracks.indexOf(track)
                              }
                          )
                      ),
                    ),
                  )),
                ],
              ).paddingSymmetric(
                  horizontal: 20,
                  vertical: 20
              ),
            ),
            Container(
              color: '#4c7288'.hexToColor(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                textDirection: TextDirection.ltr,
                children: [
                  RichText(
                    text: TextSpan(
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                        children: [
                          const TextSpan(
                              text: 'BENEFICIOS ',
                              style: TextStyle(fontWeight: FontWeight.bold)
                          ),
                          const TextSpan(
                            text: 'DE CANCIONES Y CUENTOS PERSONALIZADOS ',
                          ),
                          TextSpan(
                              text: 'MIXIMIKE',
                              style: TextStyle(fontWeight: FontWeight.bold, color: '#FEE383'.hexToColor())
                          ),
                        ]
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  RichText(
                    text: TextSpan(
                        style: TextStyle(
                          fontSize: 18,
                          color: '#FEE383'.hexToColor(),
                        ),
                        children: const [
                          TextSpan(
                              text: 'Todos estos beneficios se verán reflejados en el día a día de los',
                              style: TextStyle(fontWeight: FontWeight.bold)
                          ),
                          TextSpan(
                              text: ' NIÑ@S ',
                              style: TextStyle(fontWeight: FontWeight.bold)
                          ),
                          TextSpan(
                            text: ', en su desarrollo con el entorno familiar, con los amigos y, por supuesto, también en el colegio.',
                          ),
                        ]
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(32)),
                          color: Colors.white,
                        ),
                        child: const Icon(
                          Icons.check_circle,
                          size: 48,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Expanded(
                        child: Text(
                          'Fortalecen la conexión emocional de los niños con su propio nombre para'
                              ' construir su identidad mientras se divierten y aprenden.',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(32)),
                          color: Colors.white,
                        ),
                        child: const Icon(
                          Icons.check_circle,
                          size: 48,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Expanded(
                        child: Text(
                          'Potencian el desarrollo intelectual, auditivo, sensorial, del habla, motriz y social de los niños.',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(32)),
                          color: Colors.white,
                        ),
                        child: const Icon(
                          Icons.check_circle,
                          size: 48,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Expanded(
                        child: Text(
                          'Ofrecen a los niños un ambiente de seguridad y potencian su autoestima.',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(32)),
                          color: Colors.white,
                        ),
                        child: const Icon(
                          Icons.check_circle,
                          size: 48,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Expanded(
                        child: Text(
                          'Permiten que los niños se sientan los protagonistas de lo que sucede en las canciones '
                              'y cuentos, sumergidos en fantasía, magia y diversión.',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ).paddingOnly(
                left: 20,
                  right: 20,
                  top: 20,
                  bottom: 100
              ),
            ),
          ],
        ),
      ),
    );
  }
}
