import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  int currentIndex = 0;
  final Map<int, Map<String, dynamic>> faqs = {
    1: {
      'title': RichText(
        text: const TextSpan(
            text: '¿Qué es MIXIMIKE?',
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
            )
        ),
      ),
      'content': Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: TextDirection.ltr,
        children: [
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
      ),
      'isExpanded': false
    },
    4: {
      'title': RichText(
        text: const TextSpan(
            text: '¿Cuándo y para qué se CREA una cuenta en MIXIMIKE?',
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
            )
        ),
      ),
      'content': Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: TextDirection.ltr,
        children: [
          RichText(
            text: const TextSpan(
                children: [
                  TextSpan(
                      text: '• ',
                      style: TextStyle(color: Colors.black)
                  ),
                  TextSpan(
                      text: 'Tu cuenta',
                      style: TextStyle(color: Colors.black)
                  ),
                  TextSpan(
                      text: ' MIXIMIKE ',
                      style: TextStyle(color: Colors.black, fontFamily: 'Vogue Bold')
                  ),
                  TextSpan(
                      text: 'la crearás cuando realices tu primera compra, en la sección de Finalizar Compra.',
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
                      text: 'Con ella podrás acceder a:',
                      style: TextStyle(color: Colors.black)
                  ),
                ]
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          RichText(
            text: const TextSpan(
                children: [
                  TextSpan(
                      text: '– ',
                      style: TextStyle(color: Colors.black)
                  ),
                  TextSpan(
                      text: 'La',
                      style: TextStyle(color: Colors.black)
                  ),
                  TextSpan(
                      text: ' APP MIXIMIKE ',
                      style: TextStyle(color: Colors.black, fontFamily: 'Vogue Bold')
                  ),
                  TextSpan(
                      text: 'en tus dispositivos móviles para reproducir el contenido adquirido.',
                      style: TextStyle(color: Colors.black)
                  ),
                ]
            ),
          ).paddingOnly(left: 10),
          RichText(
            text: const TextSpan(
                children: [
                  TextSpan(
                      text: '– ',
                      style: TextStyle(color: Colors.black)
                  ),
                  TextSpan(
                      text: 'Nuestro sitio web www.miximike.com para realizar nuevas compras.',
                      style: TextStyle(color: Colors.black)
                  ),
                ]
            ),
          ).paddingOnly(left: 10),
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
                      text: 'Cuando quieras comprar nuevo contenido para tu(s) hij@(s) deberás hacerlo siempre y '
                          'únicamente desde nuestro sitio web www.miximike.com. '
                          'El nuevo contenido adquirido será agregado a tu colección en tu cuenta',
                      style: TextStyle(color: Colors.black)
                  ),
                  TextSpan(
                      text: ' MIXIMIKE.',
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
                      text: 'La',
                      style: TextStyle(color: Colors.black)
                  ),
                  TextSpan(
                      text: ' APP MIXIMIKE ',
                      style: TextStyle(color: Colors.black, fontFamily: 'Vogue Bold')
                  ),
                  TextSpan(
                      text: ' es sólo para reproducción de contenido y no para realizar compras.',
                      style: TextStyle(color: Colors.black)
                  ),
                ]
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
      'isExpanded': false
    },
    8: {
      'title': RichText(
        text: const TextSpan(
            text: 'Quiero REGALAR contenido de MIXIMIKE. ¿CÓMO LO HAGO?',
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
            )
        ),
      ),
      'content': Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: TextDirection.ltr,
        children: [
          RichText(
            text: const TextSpan(
                children: [
                  TextSpan(
                      text: '• ',
                      style: TextStyle(color: Colors.black)
                  ),
                  TextSpan(
                      text: 'En el buscador de nuestro sitio web ingresa el nombre del NIÑ@ a quien desees regalar.',
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
                      text: 'Selecciona los productos que te gusten y agrégalos al carrito de compras. '
                          'En el momento de Finalizar Compra podrás elegir "',
                      style: TextStyle(color: Colors.black)
                  ),
                  TextSpan(
                      text: 'COMPRO PARA REGALAR',
                      style: TextStyle(color: Colors.black, fontFamily: 'Vogue Bold')
                  ),
                  TextSpan(
                      text: '".',
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
                      text: 'Ingresa los datos de quien recibe el regalo (nombre y correo electrónico). '
                          'En este paso podrás redactarle un mensaje especial de saludo.',
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
                      text: 'Nosotros enviaremos a esa dirección de correo electrónico un mail (con copia a ti) con '
                          'toda la información y pasos necesarios para descargar la',
                      style: TextStyle(color: Colors.black)
                  ),
                  TextSpan(
                      text: ' APP MIXIMIKE',
                      style: TextStyle(color: Colors.black, fontFamily: 'Vogue Bold')
                  ),
                  TextSpan(
                      text: ', el contenido que hayas enviado de regalo y las instrucciones para su reproducción.',
                      style: TextStyle(color: Colors.black)
                  ),
                ]
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
      'isExpanded': false
    },
    10: {
      'title': RichText(
        text: const TextSpan(
            text: '¿Cómo me ENTERO que existe NUEVO CONTENIDO para comprar y descargar?',
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
            )
        ),
      ),
      'content': Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: TextDirection.ltr,
        children: [
          RichText(
            text: const TextSpan(
                children: [
                  TextSpan(
                      text: 'Permanentemente iremos desarrollando y agregando nuevo contenido para que puedas ir '
                          'complementando la divertida y entretenida colección de canciones y cuentos infantiles con el nombre de tu',
                      style: TextStyle(color: Colors.black)
                  ),
                  TextSpan(
                      text: ' HIJ@. ',
                      style: TextStyle(color: Colors.black, fontFamily: 'Vogue Bold')
                  ),
                  TextSpan(
                      text: 'Te avisaremos a través de un mensaje enviado a tu aplicación.',
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
                      text: 'De todas maneras, no olvides visitar nuestro sitio web www.miximike.com '
                          'constantemente para revisar los nuevos contenidos que iremos agregando en el tiempo.',
                      style: TextStyle(color: Colors.black)
                  ),
                ]
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
      'isExpanded': false
    },
    5: {
      'title': RichText(
        text: const TextSpan(
            text: '¿Cuáles son las características técnicas y comerciales del producto que compro en MIXIMIKE?',
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
            )
        ),
      ),
      'content': Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: TextDirection.ltr,
        children: [
          RichText(
            text: const TextSpan(
                children: [
                  TextSpan(
                      text: '• ',
                      style: TextStyle(color: Colors.black)
                  ),
                  TextSpan(
                      text: 'El contenido que compras en MIXIMIKE es tuyo para siempre, a través de la APP MIXIMIKE.',
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
                      text: 'Cuando adquieres contenido de MIXIMIKE, lo que compras es el acceso '
                            'de por vida a su reproducción a través de la APP MIXIMIKE. En otras '
                            'palabras, no compras archivos digitales descargables, sino que el acceso '
                            'indefinido a ellos, única y exclusivamente, a través de la APP MIXIMIKE.',
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
                      text: 'La APP MIXIMIKE puede instalarse en varios dispositivos móviles.',
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
                      text: 'Para reproducir el contenido adquirido debes acceder a tu APP MIXIMIKE '
                          'ingresando el correo electrónico y contraseña registrados al momento de la compra.',
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
                      text: 'La reproducción del contenido a través de la APP MIXIMIKE requiere conexión a Internet.',
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
                      text: 'El precio de compra de cada producto se paga una sola vez en la vida. '
                          'No cobramos ni cobraremos un servicio mensual de acceso a la APP MIXIMIKE.',
                      style: TextStyle(color: Colors.black)
                  ),
                ]
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
      'isExpanded': false
    },
    3: {
      'title': RichText(
        text: const TextSpan(
            text: '¿Cómo funciona MIXIMIKE?',
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
            )
        ),
      ),
      'content': Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: TextDirection.ltr,
        children: [
          RichText(
            text: const TextSpan(
                children: [
                  TextSpan(
                      text: '• ',
                      style: TextStyle(color: Colors.black)
                  ),
                  TextSpan(
                      text: 'En',
                      style: TextStyle(color: Colors.black)
                  ),
                  TextSpan(
                      text: ' www.miximike.com',
                      style: TextStyle(color: Colors.black, fontFamily: 'Vogue Bold')
                  ),
                  TextSpan(
                      text: ', primero buscas el nombre de tu ',
                      style: TextStyle(color: Colors.black)
                  ),
                  TextSpan(
                      text: ' HIJ@ ',
                      style: TextStyle(color: Colors.black, fontFamily: 'Vogue Bold')
                  ),
                  TextSpan(
                      text: 'en nuestro buscador.',
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
                      text: 'Seleccionas él o los productos ',
                      style: TextStyle(color: Colors.black, fontFamily: 'Vogue Bold')
                  ),
                  TextSpan(
                      text: 'que quieras comprar.',
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
                      text: 'Al',
                      style: TextStyle(color: Colors.black)
                  ),
                  TextSpan(
                      text: ' finalizar el pedido creas tu cuenta ',
                      style: TextStyle(color: Colors.black, fontFamily: 'Vogue Bold')
                  ),
                  TextSpan(
                      text: 'y procedes con el pago.',
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
                      text: 'Recibirás un mail de confirmación con el link de',
                      style: TextStyle(color: Colors.black)
                  ),
                  TextSpan(
                      text: ' descarga de la APP MIXIMIKE.',
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
                      text: 'Descargas nuestra',
                      style: TextStyle(color: Colors.black)
                  ),
                  TextSpan(
                      text: ' APP MIXIMIKE ',
                      style: TextStyle(color: Colors.black, fontFamily: 'Vogue Bold')
                  ),
                  TextSpan(
                      text: ' desde Google Play (Android) o Apple Store (IOS) y la instalas en tu dispositivo móvil.',
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
                      text: 'Cuando ingreses a tu cuenta, el contenido adquirido estará disponible ahí para reproducirlo.',
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
                      text: 'La reproducción del contenido la realizas desde nuestra',
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
                      text: 'Compras posteriores debes hacerlas en nuestro sitio web www.miximike.com. '
                          'El contenido que vayas adquiriendo se irá sumando automáticamente a tu cuenta.',
                      style: TextStyle(color: Colors.black)
                  ),
                ]
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
      'isExpanded': false
    },
    6: {
      'title': RichText(
        text: const TextSpan(
            text: '¿Puedo USAR mi cuenta en varios dispositivos?',
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
            )
        ),
      ),
      'content': Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: TextDirection.ltr,
        children: [
          RichText(
            text: const TextSpan(
                children: [
                  TextSpan(
                      text: 'Con tu nombre de usuario y contraseña puedes abrir tu cuenta en todos los dispositivos en que tengas descargada la APP MIXIMIKE.',
                      style: TextStyle(color: Colors.black)
                  ),
                ]
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
      'isExpanded': false
    },
    2: {
      'title': RichText(
        text: const TextSpan(
            text: '¿Qué contenido OFRECE MIXIMIKE?',
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
            )
        ),
      ),
      'content': Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: TextDirection.ltr,
        children: [
          RichText(
            text: const TextSpan(
                children: [
                  TextSpan(
                      text: 'MIXIMIKE ',
                      style: TextStyle(color: Colors.black, fontFamily: 'Vogue Bold')
                  ),
                  TextSpan(
                      text: 'ofrece el siguiente contenido infantil (ideal para NIÑ@S de 2 a 6 años):',
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
                      text: 'Simpáticas canciones ',
                      style: TextStyle(color: Colors.black, fontFamily: 'Vogue Bold')
                  ),
                  TextSpan(
                      text: 'infantiles personalizadas.',
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
                      text: 'Entretenidos cuentos ',
                      style: TextStyle(color: Colors.black, fontFamily: 'Vogue Bold')
                  ),
                  TextSpan(
                      text: 'infantiles personalizados.',
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
                      text: 'Divertidas canciones ',
                      style: TextStyle(color: Colors.black, fontFamily: 'Vogue Bold')
                  ),
                  TextSpan(
                      text: 'infantiles para todos (canciones no personalizadas).',
                      style: TextStyle(color: Colors.black)
                  ),
                ]
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
      'isExpanded': false
    },
    7: {
      'title': RichText(
        text: const TextSpan(
            text: '¿Puedo tener varios nombres de NIÑ@S en mi cuenta?',
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
            )
        ),
      ),
      'content': Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: TextDirection.ltr,
        children: [
          RichText(
            text: const TextSpan(
                children: [
                  TextSpan(
                      text: 'Puedes descargar contenidos para distintos nombres de tus',
                      style: TextStyle(color: Colors.black)
                  ),
                  TextSpan(
                      text: ' HIJ@S',
                      style: TextStyle(color: Colors.black, fontFamily: 'Vogue Bold')
                  ),
                  TextSpan(
                      text: ', coleccionarlos y reproducirlos en la misma cuenta. Eso sí, el contenido de cada',
                      style: TextStyle(color: Colors.black)
                  ),
                  TextSpan(
                      text: ' NIÑ@ ',
                      style: TextStyle(color: Colors.black, fontFamily: 'Vogue Bold')
                  ),
                  TextSpan(
                      text: 'debe adquirirse por separado.',
                      style: TextStyle(color: Colors.black)
                  ),
                ]
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
      'isExpanded': false
    },
    11: {
      'title': RichText(
        text: const TextSpan(
            text: 'Tengo inconvenientes con mi cuenta y/o funcionamiento de la aplicación. ¿QUÉ DEBO HACER?',
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
            )
        ),
      ),
      'content': Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: TextDirection.ltr,
        children: [
          RichText(
            text: const TextSpan(
                children: [
                  TextSpan(
                      text: 'Si tienes inconvenientes con tu cuenta o con el funcionamiento de la APP MIXIMIKE, por favor contáctanos a soporte@miximike.com.',
                      style: TextStyle(color: Colors.black)
                  ),
                ]
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
      'isExpanded': false
    },
    9: {
      'title': RichText(
        text: const TextSpan(
            text: 'El nombre de mi HIJ@ no está disponible. ¿QUÉ PUEDO HACER?',
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
            )
        ),
      ),
      'content': Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: TextDirection.ltr,
        children: [
          RichText(
            text: const TextSpan(
                children: [
                  TextSpan(
                      text: 'Es posible que no lo tengamos disponible por el momento. '
                          'Lo primero que debes hacer es verificar la escritura y/o probar con diferentes pronunciaciones '
                          'o formas de escribir el nombre de tu HIJ@.',
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
                      text: 'Debes saber que en forma permanente iremos incorporando nuevo contenido para los nombres '
                          'ya disponibles y también para nuevos nombres de NIÑ@S, preferentemente para aquellos '
                          'que estén siendo más buscados y solicitados por los cibernautas en nuestro buscador.',
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
                      text: 'De todas formas, MIXIMIKE también ofrece simpáticas y divertidas '
                          'CANCIONES PARA TODOS (canciones no personalizadas) que puedes adquirir '
                          'en nuestro sitio web dando clic en CANCIONES PARA TODOS.',
                      style: TextStyle(color: Colors.black)
                  ),
                ]
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
      'isExpanded': false
    },
};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preguntas frecuentes'),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        child: SingleChildScrollView(
          child: ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                faqs[index + 1]?['isExpanded'] = isExpanded;
              });
            },
            expandedHeaderPadding: const EdgeInsets.all(0),
            children: List.generate(faqs.length, (index) {
              final faq = faqs[index + 1]!;

              return ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        faq['isExpanded'] = !faq['isExpanded']!;
                      });
                    },
                    child: ListTile(
                      title: faq['title'],
                    ),
                  );
                },
                body: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  child: faq['content'],
                ),
                isExpanded: faq['isExpanded']!,
              );
            }),
            // children: faqs.map((faq) {
            //   return ExpansionPanel(
            //     headerBuilder: (BuildContext context, bool isExpanded) {
            //       return ListTile(
            //         title: faq['title'],
            //       );
            //     },
            //     body: Padding(
            //       padding: const EdgeInsets.symmetric(
            //         vertical: 10,
            //         horizontal: 20,
            //       ),
            //       child: faq['content'],
            //     ),
            //     isExpanded: faq['isExpanded']!,
            //   );
            // }).toList(),
          ),
        ),
      ),
    );
  }
}
